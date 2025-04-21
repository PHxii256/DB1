import os
import re
import json

from datetime import datetime, date
from flask import Flask, flash, redirect, render_template, request, session, jsonify, make_response
from flask_session import Session
from helpers import Database, Passenger

# Configure application
app = Flask(__name__)

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

# Connecting to the database
db = Database('DRIVER=ODBC Driver 18 for SQL Server;SERVER=127.0.0.1,1433;UID=sa;PWD=notYourBusiness;DATABASE=AirReservationDB;TrustServerCertificate=no;Encrypt=no')

@app.route("/")
def index():
    """Show the homepage"""
    return render_template('home.html')

@app.route("/flight_search", methods=["GET", "POST"])
def flight_search():
    values = {
        "departure": '',
        "destination": '',
        "depart_date_str": date.today().isoformat(),
        "passengers": 1,
        "places": list(db.execute("SELECT DISTINCT(region) FROM location"))
    }

    if request.method == "POST":
        values.update({
            "departure": request.form.get("departure", "").strip(),
            "destination": request.form.get("destination", "").strip(),
            "depart_date_str": request.form.get("departDate", "").strip(),
            "passengers": request.form.get("passengers", type=int)
        })

        try:
            depart_date = datetime.strptime(values["depart_date_str"], "%Y-%m-%d").date()
        except (ValueError, TypeError):
            flash("Invalid date format", "warning")
            return render_template("flightSearch.html", values=values)

        if not all([values["departure"], values["destination"], depart_date, values["passengers"]]):
            flash("Missing required fields", "warning")
            return render_template("flightSearch.html", values=values)

        if values["departure"] == values["destination"]:
            flash("Departure and destination cannot be the same", "warning")
            return render_template("flightSearch.html", values=values)

        if values["passengers"] <= 0:
            flash("Passenger count must be at least 1", "warning")
            return render_template("flightSearch.html", values=values)

        # Store in cookies and redirect to available_flights
        resp = make_response(redirect("/available_flights"))
        resp.set_cookie("departure", values["departure"])
        resp.set_cookie("destination", values["destination"])
        resp.set_cookie("depart_date", values["depart_date_str"])
        resp.set_cookie("passengers", str(values["passengers"]))
        return resp

    return render_template("flightSearch.html", values=values)

@app.route("/available_flights", methods=["GET", "POST"])
def available_flights():
    if request.method == "POST":
        # Save selected flight info into cookies and redirect to passenger details
        airline = request.form.get('flight_airline')
        flight_number = request.form.get('flight_number')
        from_city = request.form.get('from')
        to_city = request.form.get('to')
        departure = request.form.get('departure')
        arrival = request.form.get('arrival')
        economy_price = request.form.get('economy_price')
        business_price = request.form.get('business_price')
        first_class_price = request.form.get('first_class_price')

        response = make_response(redirect("/passenger_details"))

        # Store selected flight details in cookies
        response.set_cookie("selected_flight", json.dumps({
            'airline': airline,
            'flight_number': flight_number,
            'from_city': from_city,
            'to_city': to_city,
            'departure': departure,
            'arrival': arrival,
            'economy_price': economy_price,
            'business_price': business_price,
            'first_class_price': first_class_price
        }))

        return response

    # GET method - now checks for available seats
    departure = request.cookies.get("departure")
    destination = request.cookies.get("destination")
    depart_date_str = request.cookies.get("depart_date")
    passengers = request.cookies.get("passengers", type=int)

    if not all([departure, destination, depart_date_str, passengers]):
        flash("Flight search preferences not found. Please search again.", "warning")
        return redirect("/flight_search")

    try:
        depart_date = datetime.strptime(depart_date_str, "%Y-%m-%d")
        end_date = depart_date.replace(hour=23, minute=59, second=59)
    except ValueError:
        flash("Invalid date in cookies. Please search again.", "warning")
        return redirect("/flight_search")

    flights = db.execute(
        """SELECT * FROM flight_details 
        WHERE fromRegion = ? 
        AND toRegion = ? 
        AND departure >= ? 
        AND departure <= ?
        AND available_seats >= ?""",  # Only flights with enough seats
        [
            departure, 
            destination, 
            depart_date.strftime("%Y-%m-%d 00:00:00"), 
            end_date.strftime("%Y-%m-%d 23:59:59"),
            passengers  # Minimum required available seats
        ]
    )

    return render_template("availableFlights.html", flights=flights)

@app.route('/passenger_details', methods=['GET', 'POST'])
def passenger_details():
    if request.method == 'POST':
        passenger_list = []
        passenger_count = int(request.form.get("passenger_count", 1))

        for i in range(passenger_count):
            prefix = f"passengers[{i}]["

            passenger = Passenger(
                first_name=request.form.get(f"{prefix}firstName]"),
                last_name=request.form.get(f"{prefix}lastName]"),
                gender=request.form.get(f"{prefix}gender]"),
                age_bracket=request.form.get(f"{prefix}ageBracket]"),
                nationality=request.form.get(f"{prefix}nationality]"),
                phone=request.form.get(f"{prefix}phone]"),
                document_type=request.form.get(f"{prefix}documentType]"),
                document_number=request.form.get(f"{prefix}documentNumber]")
            )
            passenger_list.append(passenger)

        passenger_data = [p.to_dict() for p in passenger_list]
        response = make_response(jsonify(passenger_data))
        response.set_cookie("passenger_info", json.dumps(passenger_data))
        return response

    # GET method: just return what's stored in cookies as JSON
    passenger_count = int(request.cookies.get("passengers", 1))
    return render_template("personalInfo.html", passenger_count=passenger_count)

@app.route('/select_seats', methods=['GET', 'POST'])
def select_seats():
    if request.method == 'GET':
        seats = db.execute("SELECT * FROM seat WHERE airplane_registration = 'N123DA'")

        rows = {}
        for seat in seats:
            _, row_num, col, seat_class, available = seat
            if seat_class not in rows:
                rows[seat_class] = {}
            if row_num not in rows[seat_class]:
                rows[seat_class][row_num] = {}
            rows[seat_class][row_num][col] = available

        # Read flight info from cookie
        selected_flight_json = request.cookies.get("selected_flight")
        if selected_flight_json:
            values = json.loads(selected_flight_json)
        else:
            values = {}

        return render_template("seatsSelect.html", seat_map=rows, values=values)