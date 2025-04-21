USE AirReservationDB;

-- Clear existing data (if needed)
DELETE FROM ticket;
DELETE FROM seat;
DELETE FROM flight;
DELETE FROM airplane;
DELETE FROM passenger;
DELETE FROM airport;
DELETE FROM location;
DELETE FROM airline;

-- Locations
INSERT INTO location (region, country, location_address) VALUES
('Cairo', 'Egypt', 'Oruba Road, Heliopolis'),
('New York', 'USA', 'Jamaica, NY 11430'),
('Los Angeles', 'USA', '1 World Way, Los Angeles, CA 90045'),
('Chicago', 'USA', '10000 W O''Hare Ave, Chicago, IL 60666'),
('London', 'UK', 'Longford TW6'),
('Dubai', 'UAE', 'Dubai, UAE');

-- Airports
INSERT INTO airport (code, airport_name, location_id) VALUES
('CAI', 'Cairo International Airport', (SELECT id FROM location WHERE location_address = 'Oruba Road, Heliopolis')),
('JFK', 'John F. Kennedy International Airport', (SELECT id FROM location WHERE location_address = 'Jamaica, NY 11430')),
('LAX', 'Los Angeles International Airport', (SELECT id FROM location WHERE location_address = '1 World Way, Los Angeles, CA 90045')),
('ORD', 'O''Hare International Airport', (SELECT id FROM location WHERE location_address = '10000 W O''Hare Ave, Chicago, IL 60666')),
('LHR', 'Heathrow Airport', (SELECT id FROM location WHERE location_address = 'Longford TW6')),
('DXB', 'Dubai International Airport', (SELECT id FROM location WHERE location_address = 'Dubai, UAE'));

-- Airlines
INSERT INTO airline (airline_name, logo_url) VALUES
('Delta Air Lines', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADgAAAAcCAMAAAADZYwMAAAAnFBMVEX////o6Ojn5+e8ws7j4+P6+vrX2uFabIyzuscAEl3y5Ob05+n48fP59fX27e7u3N/q1djw8fHEd3/O0trl5+vCyNLc3+Toqq2pAADLsLMAGFuWoLMvS3Vwf5pTZ4mPma2nsL8AF1+BjqbQAAixIDB/ABYWOmzXV1/SABSsABiiXWbmr7LRABsAB1snRnTrwsTYwsXkmJzWoqbDn6Opv1ZFAAABD0lEQVQ4je2TYVPDIAyGsZSuxbFVq+sQKIi20811nfv//82U6Qcp283e+W3vXckF8iSQSxG6aoTo7ZTNxoBzSmk+rubdBTHxTUDhzd8gufgagcj77wtinPQ2wRiDKR76BT8enUUgVbnkziZPopJgVSU0mCqFxehnK8BmcshNX15r5sAGog2A1uWfpO446ztlhEwG4OrtvV7/gFb3FbXxwMYo5XObj82M1/wIJhkkVsYdTIzrxxaeWrRCbL3mkHK3Wq47ThlayLYqYEtL2UCUla0Fr4WKFvqjUu+F5X7/eThwFuja/yiOosh9CEWeYs8dwidG8/zEEkQII8HJO//seZeDdvmAzDvajfy5rvq7vgB50xDQGponJQAAAABJRU5ErkJggg=='),
('Emirates', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAA4CAMAAAC49krEAAAAaVBMVEXXGSH////VAADXFh7SAADVAATWDxnYHyf87+/ZKTDkeXzgX2Pvtbfkd3rtqqvWCRXaMTfcRUr0zc7xv8HWAA3rnZ/lgIP219jso6XcSk7++Pj65+jib3L43t/okJLdUVXbOj/gZmnmiYuec/tfAAABmklEQVRIie2Tba+jIBCFnQMKCIiiYH3X/v8fudhtb+4mu/Z+3aQnMQR8mHHOjFn20UcfffRNBUvPTzitWG5/QGJpeavYG4p1wDxpwjsuC4tfeXwLwsRakngLOrvZ7N5X9i0Y0QWOWzkhY1d1OxukMa0Om83FdkF29yFxpVAT1+1FerbpPpxqaW3b2P0TLPS2ylMj2Tpe1MOaWQ2q0bC091d1s+bwo5fhtMdfgsrDqhn3UvLZXYAZplZrPetgcZk6hZyIyGBIN/4C5kD+NJehrsUxSpoYO0fkD7nKtEY7lnrGGKtH4FgPpE/MVXFO+1cv0Uo1lE3NNOodTXQaDfYN3a3asWXOza/M1Rh3HGTI91Rq4rLvY+XNTkb7OA5jDN0LtLEbiAfJ+/QaS8XBjeRk0yE1qTj2BCV3xUAIE/cP8IbDp0Mq79TO0OOCLxDYHuAZkS83Pg7rCW7UQUDQb/O7QN5PNTX31Lhe0OA973tDkBU3iylNvz7nyAmlCseUE6JQBTKX/muRC5FWiMzl+Jo39nT35fFj/bb/X/QL0mIYplnAD9gAAAAASUVORK5CYII=');

-- Airplanes
INSERT INTO airplane (registration, model, max_capacity, airline_name) VALUES
-- Delta Air Lines
('N123DA', 'Boeing 737-800', 160, 'Delta Air Lines'),
('N456DL', 'Boeing 767-300ER', 216, 'Delta Air Lines'),

-- Emirates
('A6-EAA', 'Airbus A380', 517, 'Emirates'),
('A6-EBB', 'Boeing 777-300ER', 354, 'Emirates');

-- Seats (simplified to just a few per airplane)
INSERT INTO seat (airplane_registration, seat_number, isle_id, class, is_available) VALUES
-- Delta Air Lines - Boeing 737-800
('N123DA', 1, 'A', 'Business', 1),
('N123DA', 1, 'B', 'Business', 1),
('N123DA', 2, 'A', 'Business', 1),
('N123DA', 2, 'B', 'Business', 1),
('N123DA', 10, 'A', 'Economy', 1),
('N123DA', 10, 'B', 'Economy', 1),
('N123DA', 11, 'A', 'Economy', 1),
('N123DA', 11, 'B', 'Economy', 1),

-- Delta Air Lines - Boeing 767-300ER
('N456DL', 1, 'A', 'First Class', 1),
('N456DL', 1, 'B', 'First Class', 1),
('N456DL', 2, 'A', 'Business', 1),
('N456DL', 2, 'B', 'Business', 1),
('N456DL', 20, 'A', 'Economy', 1),
('N456DL', 20, 'B', 'Economy', 1),

-- Emirates - Airbus A380
('A6-EAA', 1, 'A', 'First Class', 1),
('A6-EAA', 1, 'B', 'First Class', 1),
('A6-EAA', 2, 'A', 'Business', 1),
('A6-EAA', 2, 'B', 'Business', 1),
('A6-EAA', 30, 'A', 'Economy', 1),
('A6-EAA', 30, 'B', 'Economy', 1),

-- Emirates - Boeing 777-300ER
('A6-EBB', 1, 'A', 'Business', 1),
('A6-EBB', 1, 'B', 'Business', 1),
('A6-EBB', 2, 'A', 'Business', 1),
('A6-EBB', 2, 'B', 'Business', 1),
('A6-EBB', 25, 'A', 'Economy', 1),
('A6-EBB', 25, 'B', 'Economy', 1);

-- Flights (simplified to 4 flights)
INSERT INTO flight (airline_name, flight_number, from_airport_code, to_airport_code, airplane_registration, departure_time, duration, status, economy_price, business_price, first_class_price) VALUES
-- Delta flights (US domestic)
('Delta Air Lines', 'DL123', 'JFK', 'LAX', 'N123DA', '2025-06-15 08:00:00', 300, 'On Time', 299, 599, 999),
('Delta Air Lines', 'DL456', 'LAX', 'JFK', 'N456DL', '2025-06-15 12:30:00', 310, 'On Time', 299, 599, 999),

-- Emirates flights (long-haul)
('Emirates', 'EK123', 'DXB', 'JFK', 'A6-EAA', '2025-06-15 22:30:00', 780, 'On Time', 799, 1499, 2499),
('Emirates', 'EK456', 'JFK', 'DXB', 'A6-EBB', '2025-06-16 01:15:00', 795, 'On Time', 799, 1499, 2499);

-- Passengers
INSERT INTO passenger (first_name, last_name, phone_number, gender, age_bracket, nationality, id_doc_type, id_doc_num) VALUES
('John', 'Smith', '1234567890', 'Male', 'Adult', 'American', 'Passport', 12345),
('Sarah', 'Johnson', '2345678901', 'Female', 'Adult', 'British', 'Passport', 23456),
('Michael', 'Williams', '3456789012', 'Male', 'Adult', 'Canadian', 'Passport', 34567),
('Emily', 'Brown', '4567890123', 'Female', 'Child', 'American', 'National ID', 45678);

-- Tickets
INSERT INTO ticket (passenger_id, airline_name, flight_number, seat_number, isle_id, airplane_registration) VALUES
((SELECT id FROM passenger WHERE id_doc_type = 'Passport' AND id_doc_num = 12345), 'Delta Air Lines', 'DL123', 1, 'A', 'N123DA'),
((SELECT id FROM passenger WHERE id_doc_type = 'Passport' AND id_doc_num = 23456), 'Delta Air Lines', 'DL123', 1, 'B', 'N123DA'),
((SELECT id FROM passenger WHERE id_doc_type = 'Passport' AND id_doc_num = 34567), 'Emirates', 'EK123', 1, 'A', 'A6-EAA'),
((SELECT id FROM passenger WHERE id_doc_type = 'National ID' AND id_doc_num = 45678), 'Emirates', 'EK123', 1, 'B', 'A6-EAA');
