CREATE DATABASE AirReservationDB;

USE AirReservationDB;

CREATE TABLE passenger (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    title VARCHAR(30) NOT NULL,
    phone_number VARCHAR(15) NOT NULL 
        CHECK (
            phone_number NOT LIKE '%[^0-9]%' 
            AND LEN(phone_number) BETWEEN 7 AND 15
        ),
    gender VARCHAR(9) CHECK (gender IN ('Male', 'Female')),  -- enum (multivalued)
    age_bracket VARCHAR(6) CHECK (age_bracket IN ('Infant', 'Child', 'Adult')),
    nationality VARCHAR(30)
);

CREATE TABLE location( --composite attr in erd
	id INT IDENTITY(1,1) PRIMARY KEY,
	region VARCHAR(30) NOT NULL,
	country VARCHAR(30) NOT NULL,
	address VARCHAR(255)
);

CREATE TABLE airport (
    code CHAR(3) PRIMARY KEY, 
    airport_name VARCHAR(60) NOT NULL,
    location_id INT NOT NULL, 
    FOREIGN KEY (location_id) REFERENCES location(id) 
);

CREATE TABLE airline (
    id INT IDENTITY(1,1) PRIMARY KEY,
    airline_name VARCHAR(40) NOT NULL,
    logo_url VARCHAR(512)
);

CREATE TABLE airplane (
    id INT IDENTITY(1,1) PRIMARY KEY,
    model VARCHAR(40),
    max_capacity INT NOT NULL,
    airline_id INT NOT NULL,  
    FOREIGN KEY (airline_id) REFERENCES airline(id) 
);

CREATE TABLE seat (
    airplane_id INT NOT NULL, 
    seat_number INT NOT NULL,
    isle_id CHAR(1) NOT NULL,
    class VARCHAR(10) CHECK (class IN ('Economy', 'Business', 'First Class')),
    is_available BIT NOT NULL DEFAULT 1,  -- 1 = available, 0 = not available
    PRIMARY KEY (seat_number, isle_id),
    FOREIGN KEY (airplane_id) REFERENCES airplane(id)
);

CREATE TABLE flight (
    id INT IDENTITY(1,1) PRIMARY KEY,
    from_airport_code CHAR(3) NOT NULL,
    to_airport_code CHAR(3) NOT NULL,
    airline_id INT NOT NULL,  
    airplane_id INT NOT NULL,  
    departure_time DATETIME NOT NULL,
    duration INT NOT NULL,  -- in minutes   
    arrival_time AS DATEADD(MINUTE, duration, departure_time) PERSISTED,
    status VARCHAR(10) CHECK (status IN ('On Time', 'Delayed', 'Cancelled')),
    FOREIGN KEY (from_airport_code) REFERENCES airport(code),
    FOREIGN KEY (to_airport_code) REFERENCES airport(code),
    FOREIGN KEY (airline_id) REFERENCES airline(id),
    FOREIGN KEY (airplane_id) REFERENCES airplane(id)
);

CREATE TABLE ticket (
    id INT IDENTITY(1,1) PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    seat_number INT NOT NULL,
    isle_id CHAR(1) NOT NULL,
    FOREIGN KEY (seat_number, isle_id) REFERENCES seat(seat_number, isle_id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (flight_id) REFERENCES flight(id)
);