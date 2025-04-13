document.addEventListener('DOMContentLoaded', function() {
    // Set minimum date for departure to today
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0];
    document.getElementById('departDate').min = formattedDate;
    document.getElementById('departDate').value = formattedDate;
    
    //TODO: backend query database for all airports and assign them to this variable
    // Sample airports data
    const airports = [
        { city: 'Cairo', code: 'CAI', country: 'Egypt' },
        { city: 'New York', code: 'JFK', country: 'USA' },
        { city: 'New York', code: 'LGA', country: 'USA' },
        { city: 'Los Angeles', code: 'LAX', country: 'USA' },
        { city: 'Chicago', code: 'ORD', country: 'USA' },
        { city: 'San Francisco', code: 'SFO', country: 'USA' },
        { city: 'Miami', code: 'MIA', country: 'USA' },
        { city: 'London', code: 'LHR', country: 'UK' },
        { city: 'Paris', code: 'CDG', country: 'France' },
        { city: 'Tokyo', code: 'NRT', country: 'Japan' },
        { city: 'Dubai', code: 'DXB', country: 'UAE' },
        { city: 'Sydney', code: 'SYD', country: 'Australia' },
        { city: 'Singapore', code: 'SIN', country: 'Singapore' },
        { city: 'Toronto', code: 'YYZ', country: 'Canada' }
    ];
    
    // Functions for search suggestions
    function showSuggestions(inputEl, suggestionsEl) {
        const value = inputEl.value.toLowerCase();
        if (value.length < 1) {
            suggestionsEl.style.display = 'none';
            return;
        }
        
        const matches = airports.filter(airport => 
            airport.city.toLowerCase().includes(value) || 
            airport.code.toLowerCase().includes(value) ||
            airport.country.toLowerCase().includes(value)
        );
        
        if (matches.length > 0) {
            suggestionsEl.innerHTML = '';
            matches.forEach(match => {
                const item = document.createElement('div');
                item.className = 'suggestion-item';
                item.innerHTML = `${match.city}, ${match.country} <span class="airport-code">${match.code}</span>`;
                item.addEventListener('click', () => {
                    inputEl.value = `${match.city} (${match.code})`;
                    suggestionsEl.style.display = 'none';
                });
                suggestionsEl.appendChild(item);
            });
            suggestionsEl.style.display = 'block';
        } else {
            suggestionsEl.style.display = 'none';
        }
    }
    
    // Set up departure input
    const departureInput = document.getElementById('departure');
    const departureSuggestions = document.getElementById('departureSuggestions');
    
    departureInput.addEventListener('input', () => {
        showSuggestions(departureInput, departureSuggestions);
    });
    
    departureInput.addEventListener('focus', () => {
        if (departureInput.value.length >= 1) {
            showSuggestions(departureInput, departureSuggestions);
        }
    });
    
    // Set up destination input
    const destinationInput = document.getElementById('destination');
    const destinationSuggestions = document.getElementById('destinationSuggestions');
    
    destinationInput.addEventListener('input', () => {
        showSuggestions(destinationInput, destinationSuggestions);
    });
    
    destinationInput.addEventListener('focus', () => {
        if (destinationInput.value.length >= 1) {
            showSuggestions(destinationInput, destinationSuggestions);
        }
    });
    
    // Hide suggestions when clicking outside
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.from-location')) {
            departureSuggestions.style.display = 'none';
        }
        if (!e.target.closest('.to-location')) {
            destinationSuggestions.style.display = 'none';
        }
    });
    
    
    // Passenger counter functionality
    const decreaseBtn = document.getElementById('decreasePassengers');
    const increaseBtn = document.getElementById('increasePassengers');
    const passengersCountDisplay = document.getElementById('passengersCount');
    const passengersInput = document.getElementById('passengers');
    
    let passengersCount = 1;
    
    // Update counter display and state
    function updatePassengersCounter() {
        passengersCountDisplay.textContent = passengersCount;
        passengersInput.value = passengersCount;
        
        // Disable decrease button if count is 1
        decreaseBtn.disabled = passengersCount <= 1;
        
        // Disable increase button if count is 9
        increaseBtn.disabled = passengersCount >= 9;
    }
    
    // Decrease passengers count
    decreaseBtn.addEventListener('click', () => {
        if (passengersCount > 1) {
            passengersCount--;
            updatePassengersCounter();
        }
    });
    
    // Increase passengers count
    increaseBtn.addEventListener('click', () => {
        if (passengersCount < 9) {
            passengersCount++;
            updatePassengersCounter();
        }
    });
    
    // Initial state setup
    updatePassengersCounter();
    
    // Form submission
    document.getElementById('flightSearchForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Get form values
        const departure = departureInput.value;
        const destination = destinationInput.value;
        const departDate = document.getElementById('departDate').value;
        const passengers = passengersInput.value;
        
        // Validate inputs
        if (!departure || !destination || !departDate) {
            alert('Please fill in all required fields');
            return;
        }

        if(departure == destination){
            alert('Departure and destination cannot be the same airport');
            return;
        }
        
        //TODO: backend querry database Using these variables 
        alert(`Searching for flights:
        From: ${departure}
        To: ${destination}
        Date: ${departDate}
        Passengers: ${passengers}`);
        
        //Then redirect to results page after getting response from database
    });
});