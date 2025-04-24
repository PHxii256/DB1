import json
from datetime import datetime, date
from flask import Flask, flash, redirect, render_template, request, make_response, url_for, jsonify
from flask_session import Session
from helpers import Database, Passenger

# Configure application
app = Flask(__name__)

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Database connection configuration
DB_CONFIG = {
    'DRIVER': 'ODBC Driver 18 for SQL Server',
    'SERVER': '127.0.0.1,1433',
    'UID': 'sa',
    'PWD': 'notYourBusiness',
    'DATABASE': 'AirReservationDB',
    'TrustServerCertificate': 'no',
    'Encrypt': 'no'
}

# Initialize database connection
db = Database(';'.join(f"{k}={v}" for k, v in DB_CONFIG.items()))


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
def index():
    """Show the homepage"""
    return render_template('home.html')


@app.route("/flight_search", methods=["GET", "POST"])
def flight_search():
    """Handle flight search requests"""
    default_values = {
        "departure": '',
        "destination": '',
        "depart_date_str": date.today().isoformat(),
        "passengers": 1,
        "places": list(db.execute("SELECT DISTINCT region FROM location"))
    }

    if request.method == "POST":
        # Get form data with defaults
        form_data = {
            "departure": request.form.get("departure", "").strip(),
            "destination": request.form.get("destination", "").strip(),
            "depart_date_str": request.form.get("departDate", "").strip(),
            "passengers": request.form.get("passengers", type=int, default=1)
        }
        values = {**default_values, **form_data}

        # Validate form data
        try:
            depart_date = datetime.strptime(values["depart_date_str"], "%Y-%m-%d").date()
        except ValueError:
            flash("Invalid date format", "warning")
            return render_template("flightSearch.html", values=values)

        if not all([values["departure"], values["destination"], depart_date]):
            flash("Missing required fields", "warning")
            return render_template("flightSearch.html", values=values)

        if values["departure"] == values["destination"]:
            flash("Departure and destination cannot be the same", "warning")
            return render_template("flightSearch.html", values=values)

        if values["passengers"] <= 0:
            flash("Passenger count must be at least 1", "warning")
            return render_template("flightSearch.html", values=values)

        # Store in cookies and redirect
        response = make_response(redirect("/available_flights"))
        response.set_cookie("departure", values["departure"])
        response.set_cookie("destination", values["destination"])
        response.set_cookie("depart_date", values["depart_date_str"])
        response.set_cookie("passengers", str(values["passengers"]))
        return response

    return render_template("flightSearch.html", values=default_values)


@app.route("/available_flights", methods=["GET", "POST"])
def available_flights():
    """Show available flights based on search criteria"""
    if request.method == "POST":
        # Save selected flight info into cookies
        flight_data = {
            'airline': request.form.get('flight_airline'),
            'flight_number': request.form.get('flight_number'),
            'from_city': request.form.get('from'),
            'to_city': request.form.get('to'),
            'departure': request.form.get('departure'),
            'arrival': request.form.get('arrival'),
            'economy_price': request.form.get('economy_price'),
            'business_price': request.form.get('business_price'),
            'first_class_price': request.form.get('first_class_price')
        }

        response = make_response(redirect("/passenger_details"))
        response.set_cookie("selected_flight", json.dumps(flight_data))
        return response

    # GET method - check for available seats
    required_cookies = ["departure", "destination", "depart_date", "passengers"]
    if not all(request.cookies.get(cookie) for cookie in required_cookies):
        flash("Flight search preferences not found. Please search again.", "warning")
        return redirect("/flight_search")

    try:
        depart_date = datetime.strptime(request.cookies.get("depart_date"), "%Y-%m-%d")
        end_date = depart_date.replace(hour=23, minute=59, second=59)
        passengers = int(request.cookies.get("passengers"))
    except (ValueError, TypeError):
        flash("Invalid data in cookies. Please search again.", "warning")
        return redirect("/flight_search")

    flights = db.execute(
        """SELECT * FROM flight_details 
        WHERE fromRegion = ? 
        AND toRegion = ? 
        AND departure >= ? 
        AND departure <= ?
        AND available_seats >= ?""",
        [
            request.cookies.get("departure"),
            request.cookies.get("destination"),
            depart_date.strftime("%Y-%m-%d 00:00:00"),
            end_date.strftime("%Y-%m-%d 23:59:59"),
            passengers
        ]
    )

    return render_template("availableFlights.html", flights=flights)


@app.route('/passenger_details', methods=['GET', 'POST'])
def passenger_details():
    """Handle passenger information collection"""
    if request.method == 'POST':
        passenger_count = int(request.form.get("passenger_count", 1))
        passenger_list = []

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

        response = make_response(redirect("/select_seats"))
        response.set_cookie("passenger_info", json.dumps([p.to_dict() for p in passenger_list]))
        return response

    # GET method
    passenger_count = int(request.cookies.get("passengers", 1))
    return render_template("personalInfo.html", passenger_count=passenger_count)


@app.route('/select_seats', methods=['GET', 'POST'])
def select_seats():
    """Handle seat selection for all passengers in the booking"""
    try:
        # Get and validate flight info from cookies
        selected_flight_json = request.cookies.get("selected_flight")
        if not selected_flight_json:
            flash("No flight selected. Please start over.", "warning")
            return redirect(url_for('flight_search'))

        flight_data = json.loads(selected_flight_json)
        
        # Get and validate passenger info from cookies
        passenger_info = request.cookies.get("passenger_info")
        if not passenger_info:
            flash("No passenger information found. Please enter passenger details.", "warning")
            return redirect(url_for('passenger_details'))

        passengers = json.loads(passenger_info)
        current_passenger_idx = int(request.args.get('passenger_idx', 0))
        
        # Validate passenger index
        if current_passenger_idx >= len(passengers):
            return redirect(url_for('review_booking'))

        current_passenger = passengers[current_passenger_idx]

        # Handle POST request (seat selection)
        if request.method == 'POST':
            selected_seat = request.form.get('selected_seat')
            selected_seat_class = request.form.get('selected_seat_class')
            
            if not selected_seat or not selected_seat_class:
                flash("Please select a seat", "warning")
                return redirect(request.url)

            # Calculate seat price based on class
            business_price = float(flight_data['business_price'])
            seat_prices = {
                'First Class': float(flight_data.get('first_class_price', business_price * 1.5)),
                'Business': business_price,
                'Economy': float(flight_data['economy_price'])
            }
            seat_price = seat_prices.get(selected_seat_class, 0)

            # Update passenger with seat selection
            passengers[current_passenger_idx].update({
                'selected_seat': selected_seat,
                'seat_class': selected_seat_class,
                'seat_price': seat_price
            })
            
            # Prepare redirect URL for next passenger or review page
            if current_passenger_idx + 1 < len(passengers):
                next_url = url_for('select_seats', passenger_idx=current_passenger_idx + 1)
            else:
                next_url = url_for('review_booking')

            # Create response with updated cookie
            response = make_response(redirect(next_url))
            response.set_cookie("passenger_info", json.dumps(passengers), max_age=3600)
            return response

        # GET request - show seat selection page
        airline = flight_data['airline']
        flight_number = flight_data['flight_number']
        
        # Get available seats from database
        seats = db.execute("""
            SELECT seat_number, isle_id, class, is_available 
            FROM FlightSeatAvailability 
            WHERE airline_name = ? AND flight_number = ?
            ORDER BY class, seat_number, isle_id
        """, (airline, flight_number))

        # Organize seats by class and row
        rows = {
            'First Class': {},
            'Business': {},
            'Economy': {}
        }

        # Get all selected seats to mark them as occupied
        selected_seats = [
            p['selected_seat'] for p in passengers 
            if 'selected_seat' in p
        ]

        for seat in seats:
            seat_number, isle_id, seat_class, available = seat
            full_seat = f"{seat_number}{isle_id}"
            
            # Mark seat as unavailable if already selected
            if full_seat in selected_seats:
                available = False
            
            if seat_number not in rows[seat_class]:
                rows[seat_class][seat_number] = {}
            rows[seat_class][seat_number][isle_id] = available

        # Calculate prices for display
        business_price = float(flight_data['business_price'])
        seat_prices = {
            'First Class': float(flight_data.get('first_class_price', business_price * 1.5)),
            'Business': business_price,
            'Economy': float(flight_data['economy_price'])
        }

        return render_template(
            "seatSelection.html",
            seat_map=rows,
            flight_data=flight_data,
            current_passenger=current_passenger,
            passenger_idx=current_passenger_idx,
            total_passengers=len(passengers),
            flight_info={
                'airline': flight_data['airline'],
                'flight_number': flight_data['flight_number'],
                'from_city': flight_data['from_city'],
                'to_city': flight_data['to_city']
            },
            seat_prices=seat_prices
        )

    except Exception as e:
        flash(f"An error occurred: {str(e)}", "error")
        return redirect(url_for('flight_search'))


@app.route('/review_booking', methods=['GET', 'POST'])
def review_booking():
    """Show booking confirmation page before final submission"""
    # Get flight info from cookies
    selected_flight_json = request.cookies.get("selected_flight")
    if not selected_flight_json:
        flash("No flight selected. Please start over.", "warning")
        return redirect(url_for('flight_search'))
    
    flight_data = json.loads(selected_flight_json)
    
    # Get passenger info from cookies
    passenger_info = request.cookies.get("passenger_info")
    if not passenger_info:
        flash("No passenger information found. Please enter passenger details.", "warning")
        return redirect(url_for('passenger_details'))
    
    passengers = json.loads(passenger_info)

    print(passengers)

    # Create passenger records and collect their IDs
    for passenger in passengers:
        # Insert passenger data - now properly formatted as tuple
        db.execute(
            """INSERT INTO passenger 
            (first_name, last_name, phone_number, gender, age_bracket, 
            nationality, id_doc_type, id_doc_num) 
            OUTPUT INSERTED.id
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)""",
            (
                passenger['first_name'],
                passenger['last_name'],
                passenger['phone'],
                passenger['gender'],
                passenger['age_bracket'],
                passenger['nationality'],
                passenger['document_type'],
                passenger['document_number']
            )
        )
        
        passenger_id_query = db.execute("SELECT ID FROM passenger WHERE id_doc_type = ? AND id_doc_num = ?", (passenger['document_type'], passenger['document_number']))
        
        passenger_id = 0
        for row in passenger_id_query:
            passenger_id = row[0]
        
        print(passenger_id)
        
        # Get seat number and isle from selected_seat (format like "12A")
        seat_number = int(passenger['selected_seat'][:-1])
        isle_id = passenger['selected_seat'][-1]
        
        # Create ticket record - properly formatted as tuple
        db.execute(
            """INSERT INTO ticket 
            (passenger_id, airline_name, flight_number, 
            seat_number, isle_id, airplane_registration) 
            VALUES (?, ?, ?, ?, ?, ?)""",
            (
                passenger_id,
                flight_data['airline'],
                flight_data['flight_number'],
                seat_number,
                isle_id,
                flight_data.get('airplane_registration', '')
            )
        )
    
    # Clear cookies after successful booking
    flash("NOT REGISTERED")
    response = make_response(redirect("/"))
    response.delete_cookie("selected_flight")
    response.delete_cookie("passenger_info")
    response.delete_cookie("departure")
    response.delete_cookie("destination")
    response.delete_cookie("depart_date")
    response.delete_cookie("passengers")
    return response