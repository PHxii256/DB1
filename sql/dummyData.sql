USE AirReservationDB;

-- Locations
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

-- Airports
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

-- Airlines
INSERT INTO airline (airline_name, logo_url) VALUES
('Delta Air Lines', 'https://upload.wikimedia.org/wikipedia/en/0/02/Delta_Air_Lines_Logo.svg'),
('Emirates', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Emirates_logo.svg'),
('Lufthansa', 'https://upload.wikimedia.org/wikipedia/commons/8/8b/Lufthansa_Logo_2018.svg'),
('Singapore Airlines', 'https://upload.wikimedia.org/wikipedia/commons/6/6f/Singapore_Airlines_Logo.svg'),
('Qatar Airways', 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Qatar_Airways_Logo.svg'),
('American Airlines', 'https://upload.wikimedia.org/wikipedia/commons/c/c0/American_Airlines_logo_2013.svg'),
('Air France', 'https://upload.wikimedia.org/wikipedia/commons/f/fd/Air_France_Logo.svg'),
('Turkish Airlines', 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Turkish_Airlines_logo_2019.svg');

-- Airplanes with multiple entries per airline
INSERT INTO airplane (model, max_capacity, airline_id) VALUES
-- Delta Air Lines
('Boeing 737-800', 160, 1),
('Boeing 767-300ER', 216, 1),
('Airbus A321', 192, 1),

-- Emirates
('Airbus A380', 517, 2),
('Boeing 777-300ER', 354, 2),
('Boeing 777-200LR', 302, 2),

-- Lufthansa
('Airbus A350-900', 293, 3),
('Airbus A340-600', 281, 3),
('Boeing 747-8', 364, 3),

-- Singapore Airlines
('Boeing 777-300ER', 264, 4),
('Airbus A380', 471, 4),
('Airbus A350-900ULR', 161, 4),

-- Qatar Airways
('Airbus A350-1000', 327, 5),
('Boeing 787-8', 254, 5),
('Boeing 777-300ER', 354, 5),

-- American Airlines
('Boeing 787-9', 285, 6),
('Airbus A321neo', 196, 6),
('Boeing 737 MAX 8', 172, 6),

-- Air France
('Airbus A320', 174, 7),
('Boeing 777-200ER', 280, 7),
('Airbus A350-900', 324, 7),

-- Turkish Airlines
('Boeing 737 MAX 8', 189, 8),
('Airbus A321neo', 206, 8),
('Boeing 787-9 Dreamliner', 300, 8);
