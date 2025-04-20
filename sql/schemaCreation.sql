CREATE DATABASE AirReservationDB;

USE AirReservationDB;

CREATE TABLE passenger
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone_number VARCHAR(15) NOT NULL
        CHECK (
            phone_number NOT LIKE '%[^0-9]%'
            AND LEN(phone_number) BETWEEN 7 AND 15
        ),
    gender VARCHAR(9) CHECK (gender IN ('Male', 'Female')) NOT NULL,
    age_bracket VARCHAR(6) CHECK (age_bracket IN ('Infant', 'Child', 'Adult')) NOT NULL,
    nationality VARCHAR(30) NOT NULL,
    id_doc_type VARCHAR(20) CHECK (id_doc_type IN ('Driver License', 'Passport', 'National ID')) NOT NULL,
    id_doc_num SMALLINT NOT NULL
);

CREATE TABLE location
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    region VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL,
    location_address VARCHAR(255)
);

CREATE TABLE airport
(
    code CHAR(3) PRIMARY KEY,
    airport_name VARCHAR(60) NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES location(id)
);

CREATE TABLE airline
(
    airline_name VARCHAR(40) PRIMARY KEY,
    logo_url VARCHAR(MAX)
);

CREATE TABLE airplane
(
    registration VARCHAR(20) PRIMARY KEY,
    model VARCHAR(40),
    max_capacity INT NOT NULL,
    airline_name VARCHAR(40) NOT NULL,
    FOREIGN KEY (airline_name) REFERENCES airline(airline_name)
);

CREATE TABLE seat
(
    airplane_registration VARCHAR(20) NOT NULL,
    seat_number INT NOT NULL,
    isle_id CHAR(1) NOT NULL,
    class VARCHAR(15) CHECK (class IN ('Economy', 'Business', 'First Class')),
    is_available BIT NOT NULL DEFAULT 1,
    PRIMARY KEY (seat_number, isle_id, airplane_registration),
    FOREIGN KEY (airplane_registration) REFERENCES airplane(registration)
);

CREATE TABLE flight
(
    airline_name VARCHAR(40) NOT NULL,
    flight_number VARCHAR(10) NOT NULL,
    from_airport_code CHAR(3) NOT NULL,
    to_airport_code CHAR(3) NOT NULL,
    airplane_registration VARCHAR(20) NOT NULL,
    departure_time DATETIME NOT NULL,
    duration INT NOT NULL,
    -- in minutes   
    arrival_time AS DATEADD(MINUTE, duration, departure_time) PERSISTED,
    status VARCHAR(10) CHECK (status IN ('On Time', 'Delayed', 'Cancelled')),
    base_price SMALLINT NOT NULL,
    PRIMARY KEY (airline_name, flight_number),
    FOREIGN KEY (from_airport_code) REFERENCES airport(code),
    FOREIGN KEY (to_airport_code) REFERENCES airport(code),
    FOREIGN KEY (airline_name) REFERENCES airline(airline_name),
    FOREIGN KEY (airplane_registration) REFERENCES airplane(registration)
);

CREATE TABLE ticket
(
    passenger_id INT NOT NULL,
    airline_name VARCHAR(40) NOT NULL,
    flight_number VARCHAR(10) NOT NULL,
    seat_number INT NOT NULL,
    isle_id CHAR(1) NOT NULL,
    airplane_registration VARCHAR(20) NOT NULL,
    FOREIGN KEY (seat_number, isle_id, airplane_registration) REFERENCES seat(seat_number, isle_id, airplane_registration),
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (airline_name, flight_number) REFERENCES flight(airline_name, flight_number),
    PRIMARY KEY (passenger_id, airline_name, flight_number)
);

CREATE VIEW flight_details
AS
    SELECT
        f.airline_name AS airline,
        al.logo_url AS airlineLogo,
        f.flight_number AS flightNumber,
        from_airport.airport_name AS "from",
        from_loc.region AS "fromRegion",
        from_loc.country AS "fromCountry",
        to_airport.airport_name AS "to",
        to_loc.region AS "toRegion",
        to_loc.country AS "toCountry",
        f.departure_time AS departure,
        f.arrival_time AS arrival,
        f.duration,
        f.base_price AS "basePrice"
    FROM
        flight f
        JOIN
        airport from_airport ON f.from_airport_code = from_airport.code
        JOIN
        location from_loc ON from_airport.location_id = from_loc.id
        JOIN
        airport to_airport ON f.to_airport_code = to_airport.code
        JOIN
        location to_loc ON to_airport.location_id = to_loc.id
        JOIN
        airline al ON f.airline_name = al.airline_name;