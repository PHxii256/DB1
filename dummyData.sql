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
