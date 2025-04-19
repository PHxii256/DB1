import os
import re

from datetime import datetime, date
from flask import Flask, flash, redirect, render_template, request, session, jsonify
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

@app.route("/fight-search", methods=["GET", "POST"])
def flight_search():
    if request.method == 'POST':
        """After the user entered his preferences"""
        departure = request.form.get('departure')
        destination = request.form.get('destination')
        depart_date_str = request.form.get('departDate')
        passengers = request.form.get('passengers', type=int)

        # Convert date string to date object
        try:
            depart_date = datetime.strptime(depart_date_str, "%Y-%m-%d").date()
        except (ValueError, TypeError):
            return jsonify({'error': 'Invalid date format'}), 400
        
        # Validate required fields
        if not all([departure, destination, depart_date, passengers]):
            return jsonify({'error': 'Missing required fields'}), 400
            
        if departure == destination:
            return jsonify({'error': 'Departure and destination cannot be the same'}), 400
            
        if passengers <= 0:
            return jsonify({'error': 'Passenger count must be at least 1'}), 400
        
        # Here you would typically:
        # 1. Query your database for available flights
        # 2. Process the results
        # 3. Return the flight options
        
        # For demonstration, we'll just return the received data
        response_data = {
            'status': 'success',
            'data': {
                'departure': departure,
                'destination': destination,
                'depart_date': depart_date_str,
                'passengers': passengers
            }
        }
        
        return jsonify(response_data)
    
    """Show the flight search page"""
    places = list(db.execute("SELECT region FROM location"))
    return render_template('flightSearch.html', places=places, today=date.today())

@app.route("/available_flights", methods=["GET", "POST"])
def available_flights():
    if request.method == "GET":
        """Show available flights depending on the user preference"""
        return render_template('flightsRecommendations.html')
    else:
        """After the user chosed a flight"""
        ...

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