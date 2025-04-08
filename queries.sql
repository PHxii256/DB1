-- for the location table
INSERT INTO location (region, country, location_address) VALUES
('Cairo', 'Egypt', 'Oruba Road, Heliopolis, Cairo, Egypt'),
('New York', 'USA', 'Jamaica, NY 11430, USA'),
('New York', 'USA', '9400 Ditmars Blvd, East Elmhurst, NY 11369, USA'),
('Los Angeles', 'USA', '1 World Way, Los Angeles, CA 90045, USA'),
('Chicago', 'USA', '10000 W O''Hare Ave, Chicago, IL 60666, USA'),
('San Francisco', 'USA', 'San Francisco, CA 94128, USA'),
('Miami', 'USA', '2100 NW 42nd Ave, Miami, FL 33142, USA'),
('London', 'UK', 'Longford TW6, United Kingdom'),
('Paris', 'France', '95700 Roissy-en-France, France'),
('Tokyo', 'Japan', 'Narita, Chiba 282-0004, Japan'),
('Dubai', 'UAE', 'Dubai, United Arab Emirates'),
('Sydney', 'Australia', 'Mascot NSW 2020, Australia'),
('Singapore', 'Singapore', 'Airport Boulevard, Singapore 819643'),
('Toronto', 'Canada', '6301 Silver Dart Drive, Mississauga, ON L5P 1B2, Canada');



-- for the airport table
INSERT INTO airport (code, airport_name, location_id) VALUES
('CAI', 'Cairo International Airport', (SELECT id FROM location WHERE region = 'Cairo' AND country = 'Egypt' AND address = 'Oruba Road, Heliopolis, Cairo, Egypt')),
('JFK', 'John F. Kennedy International Airport', (SELECT id FROM location WHERE region = 'New York' AND country = 'USA' AND address = 'Jamaica, NY 11430, USA')),
('LGA', 'LaGuardia Airport', (SELECT id FROM location WHERE region = 'New York' AND country = 'USA' AND address = '9400 Ditmars Blvd, East Elmhurst, NY 11369, USA')),
('LAX', 'Los Angeles International Airport', (SELECT id FROM location WHERE region = 'Los Angeles' AND country = 'USA' AND address = '1 World Way, Los Angeles, CA 90045, USA')),
('ORD', 'O''Hare International Airport', (SELECT id FROM location WHERE region = 'Chicago' AND country = 'USA' AND address = '10000 W O''Hare Ave, Chicago, IL 60666, USA')),
('SFO', 'San Francisco International Airport', (SELECT id FROM location WHERE region = 'San Francisco' AND country = 'USA' AND address = 'San Francisco, CA 94128, USA')),
('MIA', 'Miami International Airport', (SELECT id FROM location WHERE region = 'Miami' AND country = 'USA' AND address = '2100 NW 42nd Ave, Miami, FL 33142, USA')),
('LHR', 'Heathrow Airport', (SELECT id FROM location WHERE region = 'London' AND country = 'UK' AND address = 'Longford TW6, United Kingdom')),
('CDG', 'Charles de Gaulle Airport', (SELECT id FROM location WHERE region = 'Paris' AND country = 'France' AND address = '95700 Roissy-en-France, France')),
('NRT', 'Narita International Airport', (SELECT id FROM location WHERE region = 'Tokyo' AND country = 'Japan' AND address = 'Narita, Chiba 282-0004, Japan')),
('DXB', 'Dubai International Airport', (SELECT id FROM location WHERE region = 'Dubai' AND country = 'UAE' AND address = 'Dubai, United Arab Emirates')),
('SYD', 'Sydney Kingsford Smith Airport', (SELECT id FROM location WHERE region = 'Sydney' AND country = 'Australia' AND address = 'Mascot NSW 2020, Australia')),
('SIN', 'Singapore Changi Airport', (SELECT id FROM location WHERE region = 'Singapore' AND country = 'Singapore' AND address = 'Airport Boulevard, Singapore 819643')),
('YYZ', 'Toronto Pearson International Airport', (SELECT id FROM location WHERE region = 'Toronto' AND country = 'Canada' AND address = '6301 Silver Dart Drive, Mississauga, ON L5P 1B2, Canada'));


-- Query to retrieve code, region, and country
SELECT 
    airport.code, 
    location.region, 
    location.country
FROM 
    airport
JOIN 
    location
ON 
    airport.location_id = location.id;