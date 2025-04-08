# Airlines Database

## Overview

This database is designed to manage and organize information related to airlines, including flights, passengers, and crew. It provides a structured way to store and retrieve data efficiently.

## Features

- **Flight Management**: Track flight schedules, routes, and statuses.
- **Passenger Records**: Store passenger details, bookings, and travel history.
- **Crew Information**: Manage crew assignments and roles.
- **Airplane Details**: Maintain data about aircraft models and capacities.

## Database Schema

### 1. Passenger

- `id`, `first_name`, `last_name`, `phone_number`, `gender`, `age_bracket`, `nationality`

### 2. Location

- `id`, `region`, `country`, `location_address`

### 3. Airport

- `code`, `airport_name`, `location_id`

### 4. Airline

- `id`, `airline_name`, `logo_url`

### 5. Airplane

- `id`, `model`, `max_capacity`, `airline_id`

### 6. Seat

- `airplane_id`, `seat_number`, `isle_id`, `class`, `is_available`

### 7. Flight

- `id`, `from_airport_code`, `to_airport_code`, `airline_id`, `airplane_id`, `departure_time`, `duration`, `arrival_time`, `status`

### 8. Ticket

- `id`, `passenger_id`, `flight_id`, `seat_number`, `isle_id`

## Technologies

- **Database Management System**: Microsoft SQL Server.
- **Programming Language**: Python
- **Tools**: SQL for querying and managing data, Flask for backend.
