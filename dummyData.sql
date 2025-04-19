USE AirReservationDB;

INSERT INTO location (region, country, location_address) VALUES
('Cairo', 'Egypt', 'Oruba Road, Heliopolis'),
('New York', 'USA', 'Jamaica, NY 11430'),
('New York', 'USA', '9400 Ditmars Blvd, East Elmhurst, NY 11369'),
('Los Angeles', 'USA', '1 World Way, Los Angeles, CA 90045'),
('Chicago', 'USA', '10000 W O''Hare Ave, Chicago, IL 60666'),
('San Francisco', 'USA', 'San Francisco, CA 94128'),
('Miami', 'USA', '2100 NW 42nd Ave, Miami, FL 33142'),
('London', 'UK', 'Longford TW6'),
('Paris', 'France', '95700 Roissy-en-France'),
('Tokyo', 'Japan', 'Narita, Chiba 282-0004'),
('Dubai', 'UAE', 'Dubai, UAE'),
('Sydney', 'Australia', 'Mascot NSW 2020, Australia'),
('Singapore', 'Singapore', 'Airport Boulevard, Singapore 819643'),
('Toronto', 'Canada', '6301 Silver Dart Drive, Mississauga');

INSERT INTO airport (code, airport_name, location_id) VALUES
('CAI', 'Cairo International Airport', (SELECT id FROM location WHERE location_address = 'Oruba Road, Heliopolis')),
('JFK', 'John F. Kennedy International Airport', (SELECT id FROM location WHERE location_address = 'Jamaica, NY 11430')),
('LGA', 'LaGuardia Airport', (SELECT id FROM location WHERE  location_address = '9400 Ditmars Blvd, East Elmhurst, NY 11369')),
('LAX', 'Los Angeles International Airport', (SELECT id FROM location WHERE  location_address = '1 World Way, Los Angeles, CA 90045')),
('ORD', 'O''Hare International Airport', (SELECT id FROM location WHERE  location_address = '10000 W O''Hare Ave, Chicago, IL 60666')),
('SFO', 'San Francisco International Airport', (SELECT id FROM location WHERE  location_address = 'San Francisco, CA 94128')),
('MIA', 'Miami International Airport', (SELECT id FROM location WHERE  location_address = '2100 NW 42nd Ave, Miami, FL 33142')),
('LHR', 'Heathrow Airport', (SELECT id FROM location WHERE  location_address = 'Longford TW6')),
('CDG', 'Charles de Gaulle Airport', (SELECT id FROM location WHERE  location_address = '95700 Roissy-en-France')),
('NRT', 'Narita International Airport', (SELECT id FROM location WHERE  location_address = 'Narita, Chiba 282-0004')),
('DXB', 'Dubai International Airport', (SELECT id FROM location WHERE  location_address = 'Dubai, UAE')),
('SYD', 'Sydney Kingsford Smith Airport', (SELECT id FROM location WHERE  location_address = 'Mascot NSW 2020, Australia')),
('SIN', 'Singapore Changi Airport', (SELECT id FROM location WHERE  location_address = 'Airport Boulevard, Singapore 819643')),
('YYZ', 'Toronto Pearson International Airport', (SELECT id FROM location WHERE  location_address = '6301 Silver Dart Drive, Mississauga'));

INSERT INTO airline (airline_name, logo_url) VALUES
('SkyJet', 'https://example.com/logo/skyjet.png'),
('CloudAir', 'https://example.com/logo/cloudair.png'),
('GlobalFly', 'https://example.com/logo/globalfly.png');

INSERT INTO airplane (model, max_capacity, airline_id) VALUES
('Boeing 737', 180, 1),
('Airbus A380', 500, 2),
('Boeing 777', 300, 3);

INSERT INTO seat (airplane_id, seat_number, isle_id, class, is_available) VALUES
(1, 1, 'A', 'Economy', 1),
(1, 2, 'B', 'Economy', 1),
(1, 3, 'C', 'Business', 1),
(1, 4, 'D', 'Economy', 1);

INSERT INTO passenger (first_name, last_name, phone_number, gender, age_bracket, nationality) VALUES
('Alice', 'Johnson', '1234567890', 'Female', 'Adult', NULL),
('Bob', 'Smith', '2345678901', 'Male', 'Adult', NULL),
('Cecilia', 'Tanaka', '3456789012', 'Female', 'Adult', 'Japan'),
('David', 'Nguyen', '4567890123', 'Male', 'Child', 'Vietnam'),
('Elena', 'Garcia', '5678901234', 'Female', 'Adult', 'Brazil'),
('Farouk', 'Hassan', '6789012345', 'Male', 'Adult', NULL),
('Grace', 'Lee', '7890123456', 'Female', 'Infant', 'South Korea'),
('James', 'Brown', '8901234567', 'Male', 'Adult', 'UK'),
('jane', 'austin', '19071734214', 'Female', 'Adult', 'USA'),
('jacob', 'smith', '8201564667', 'Male', 'Adult', 'South Africa');

INSERT INTO flight (from_airport_code, to_airport_code, airline_id, airplane_id, departure_time, duration, status) VALUES
('JFK', 'LHR', 1, 1, '2025-04-15 08:00:00', 420, 'On Time'),
('LHR', 'CAI', 2, 2, '2025-04-16 09:30:00', 720, 'Delayed'),
('DXB', 'YYZ', 3, 3, '2025-04-17 23:00:00', 960, 'Cancelled'),
('SFO', 'JFK', 1, 1, '2025-04-18 06:00:00', 840, 'On Time'),
('NRT', 'DXB', 2, 2, '2025-04-19 21:00:00', 540, 'On Time');

INSERT INTO ticket (passenger_id, flight_id, seat_number, isle_id) VALUES
(1, 1, 1, 'A'), 
(2, 1, 2, 'B'),  
(3, 2, 3, 'C'),  
(4, 2, 4, 'D');