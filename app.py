import os
import re

from flask import Flask, flash, redirect, render_template, request, session, jsonify
from flask_session import Session
#from werkzeug.security import check_password_hash, generate_password_hash

import pyodbc

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
connectionString = 'DRIVER=ODBC Driver 18 for SQL Server;SERVER=127.0.0.1,1433;UID=sa;PWD=R&-#G^BGs@MXtA)x;TrustServerCertificate=no;Encrypt=no'
connection = pyodbc.connect(connectionString)

@app.route("/")
def index():
    """Show the homepage"""
    return render_template('home.html')

@app.route("/fight-search")
def flight_search():
    """Show the flight search page"""
    return render_template('flightSearch.html')