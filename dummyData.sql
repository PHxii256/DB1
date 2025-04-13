-- Insert Dummy Data

-- Locations
INSERT INTO location (region, country, address)
VALUES 
('California', 'USA', '123 Main St, Los Angeles, CA'),
('Ontario', 'Canada', '456 Maple Ave, Toronto, ON'),
('Bavaria', 'Germany', '789 Flughafenstr, Munich');

-- Airports
INSERT INTO airport (code, airport_name, location_id)
VALUES 
('LAX', 'Los Angeles International Airport', 1),
('YYZ', 'Toronto Pearson International Airport', 2),
('MUC', 'Munich International Airport', 3);

-- Airlines
INSERT INTO airline (airline_name, logo_url)
VALUES 
('SkyHigh Airlines', 'https://example.com/logos/skyhigh.png'),
('MapleWings', 'https://example.com/logos/maplewings.png');

-- Airplanes
INSERT INTO airplane (model, max_capacity, airline_id)
VALUES 
('Boeing 737', 180, 1),
('Airbus A320', 150, 2);

-- Seats
INSERT INTO seat (airplane_id, seat_number, isle_id, class, is_available)
VALUES 
(1, 1, 'A', 'Economy', 1),
(1, 2, 'B', 'Business', 1),
(1, 3, 'C', 'First Class', 1),
(2, 1, 'A', 'Economy', 1),
(2, 2, 'B', 'Business', 1),
(2, 3, 'C', 'First Class', 1);

-- Passengers
INSERT INTO passenger (first_name, last_name, title, phone_number, gender, age_bracket, nationality)
VALUES 
('John', 'Doe', 'Mr', '1234567890', 'Male', 'Adult', 'American'),
('Jane', 'Smith', 'Ms', '2345678901', 'Female', 'Adult', 'Canadian'),
('Tim', 'Brown', 'Master', '3456789012', 'Male', 'Child', 'German');

-- Flights
INSERT INTO flight (from_airport_code, to_airport_code, airline_id, airplane_id, departure_time, duration, status)
VALUES 
('LAX', 'YYZ', 1, 1, '2025-04-15 08:00:00', 300, 'On Time'),
('YYZ', 'MUC', 2, 2, '2025-04-16 10:00:00', 480, 'Delayed');

-- Tickets
INSERT INTO ticket (passenger_id, flight_id, seat_number, isle_id, airplane_id)
VALUES 
(1, 1, 1, 'A', 1),
(2, 1, 2, 'B', 1),
(3, 2, 1, 'A', 2);