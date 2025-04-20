import os
import re

from datetime import datetime, date
from flask import Flask, flash, redirect, render_template, request, session, jsonify, make_response
from flask_session import Session
from helpers import Database

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
    if request.method == "GET":
        # Retrieve data from cookies
        departure = request.cookies.get("departure")
        destination = request.cookies.get("destination")
        depart_date_str = request.cookies.get("depart_date")
        passengers = request.cookies.get("passengers", type=int)

        if not all([departure, destination, depart_date_str, passengers]):
            flash("Flight search preferences not found. Please search again.", "warning")
            return redirect("/flight_search")

        # Calculate a date range for demo filtering (e.g., +-7 days)
        try:
            depart_date = datetime.strptime(depart_date_str, "%Y-%m-%d")
            end_date = depart_date.replace(hour=23, minute=59, second=59)
        except ValueError:
            flash("Invalid date in cookies. Please search again.", "warning")
            return redirect("/flight_search")

        flights = db.execute(
            "SELECT * FROM flight_details WHERE fromRegion = ? AND toRegion = ? AND departure >= ? AND departure <= ?",
            [departure, destination, depart_date.strftime("%Y-%m-%d 00:00:00"), end_date.strftime("%Y-%m-%d 23:59:59")]
        )

        return render_template("availableFlights.html", flights=flights, passengers=passengers)

    else:
        # After user chooses a flight
        airline = request.form.get('flight_airline')
        flight_number = request.form.get('flight_number')
        from_city = request.form.get('from')
        to_city = request.form.get('to')
        departure = request.form.get('departure')
        arrival = request.form.get('arrival')
        price = request.form.get('price')

        response_data = {
            'status': 'success',
            'data': {
                'airline': airline,
                'flight_number': flight_number,
                'from_city': from_city,
                'to_city': to_city,
                'departure': departure,
                'arrival': arrival,
                'price': price
            }
        }

        return jsonify(response_data)

@app.route('/passenger_details', methods=['GET', 'POST'])
def passenger_details():
    if request.method == 'GET':
        """Display a form for user input"""
        ...
    else:
        """Process the form data and store passenger information"""
        ...

@app.route('/select_seats', methods=['GET', 'POST'])
def select_seats():
    if request.method == 'GET':
        """Load the seat map and display it to the user"""
        ...
    else:
        """After the user choosed the prefered seat"""
        ...