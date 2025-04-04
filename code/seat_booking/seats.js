window.onload = function() {
    let button = document.querySelector('.confirm-button')
    button.setAttribute('disabled', "");
    updateSelectedSeats()
    simulateDataResponse()
};  

// TO:DO (Backend)
// FETCH AND COVERT TO JSON LIKE IN MOCK.JS AND PASS IT TO THIS FUNCTION
function simulateDataResponse(){ 
    const businessRes = responseExampleBusinessSeats
    const economyRes = responseExampleEconomySeats
    const flightMetaRes = responseExampleflightMetadata

    setTimeout(function() {
        displayFlightMetaData(flightMetaRes);
        generateBusinessRows(businessRes, economyRes) 
    }, 200);
}

// TO:DO (Backend)
// USE RETURN VALUE TO UPDATE SEAT AVAILABILIY IN THE DATABASE 
function getSelectedSeats(){
    const nodeList = document.querySelectorAll('.selected');
    const reservedSeats = []
    nodeList.forEach(element => {
        if (element.matches(".business")){
            reservedSeats.push(
                {
                    seat_no : element.innerHTML.substring(1),
                    isle_code :  element.innerHTML[0],
                    class : "business",
                    is_available : false
                }
            )
        }
        else {
            reservedSeats.push(
                {
                    seat_no : element.innerHTML.substring(1),
                    isle_code :  element.innerHTML[0],
                    class : "economy",
                    is_available : false
                }
            )
        }
    });
   
    console.log(reservedSeats);
    return reservedSeats;
}

function getRowWidth(seatArr){
    let initCode = seatArr[0].isle_code;
    let currentCode;

    for (let i = 1; i < seatArr.length; i++) {
        currentCode =  seatArr[i].isle_code;
        if (currentCode === initCode){
            return i;
        }
    }
    return seatArr.length;
}

function displayFlightMetaData(flightMetaRes){
    flightRoute = document.querySelector("#flight-route")
    flightRoute.innerHTML = `${flightMetaRes["from_airport_city"]} (${flightMetaRes["from_airport_code"]}) → ${flightMetaRes["to_airport_city"]} (${flightMetaRes["to_airport_code"]})`

    document.querySelector("#flight-date").innerHTML = flightMetaRes["flight_date"]
    document.querySelector("#flight-time").innerHTML = flightMetaRes["flight_time"]
}

function generateBusinessRows(businessRes, economyRes){
    const seatsDiv = document.querySelector(".seats");
    const isle_codes = ["A", "B", "C", "D", "E", "F"];
    let i = 0; 
    
    for (i; i < businessRes.length / getRowWidth(businessRes); i++) {
    //console.log("i: " + i)
        const rowLabel = document.createElement("div")   
        rowLabel.classList = "row-label"
        rowLabel.innerHTML = `Business (Row (${i + 1})`
        seatsDiv.appendChild(rowLabel);
        const rowWidth = getRowWidth(businessRes);

    for (let j = i * getRowWidth(businessRes); j < rowWidth * (i+1); j++) {
        const data = isle_codes[j % rowWidth] + (parseInt(j / rowWidth) + 1)
        const div = document.createElement("div")
        div.innerHTML = data

        //console.log(j);

        if(businessRes[j].is_available === true) {
            div.classList = "seat business"
        }
        else if(businessRes[j].is_available === false){
            div.classList = "seat business unavailable"
        }

        div.setAttribute("name", data); 
        div.setAttribute("data-seat", data); 
        seatsDiv.appendChild(div);

        // Basic functionality for seat selection
        seatsDiv.querySelectorAll('.seat:not(.unavailable)').forEach(seat => {
            seat.addEventListener('click', onSeatClick);
        });
    }
}

generateEconomyRows(i,economyRes);

}

function generateEconomyRows(startingIndex, seatArray){
    const seatsDiv = document.querySelector(".seats");
    const isle_codes = ["A", "B", "C", "D", "E", "F"];
    let i = 0; 
    
    for (i; i < seatArray.length / getRowWidth(seatArray); i++) {
        const rowLabel = document.createElement("div")   
        rowLabel.classList = "row-label"
        rowLabel.innerHTML = `Economy (Row (${i + 1 + startingIndex})`
        seatsDiv.appendChild(rowLabel);
        const rowWidth = getRowWidth(seatArray);

        for (let j = i * getRowWidth(seatArray); j < rowWidth * (i+1); j++) {
            const data = isle_codes[j % rowWidth] + (parseInt(j / rowWidth) + 1 + startingIndex)
            const div = document.createElement("div")
            div.innerHTML = data

            if(seatArray[j].is_available === true) {
                div.classList = "seat"
            }
            else if(seatArray[j].is_available === false){
                div.classList = "seat unavailable"
            }

            div.setAttribute("name", data); 
            div.setAttribute("data-seat", data); 
            seatsDiv.appendChild(div);

            // Basic functionality for seat selection
            seatsDiv.querySelectorAll('.seat:not(.unavailable)').forEach(seat => {
                seat.addEventListener('click', onSeatClick);
            });
        }
    }
}


function onSeatClick(){
    if (this.classList.contains('selected')) {
        this.classList.remove('selected');
        updateSelectedSeats();
    } else {
        this.classList.add('selected');
        updateSelectedSeats();
    }
}

//used to update price summary
function updateSelectedSeats() {
    const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
        .map(seat => {
            const seatId = seat.getAttribute('data-seat');
            const isBusiness = seat.classList.contains('business');
            return `${seatId} (${isBusiness ? 'business' : 'economy'})`;
        });
    
    const selectedSeatsElement = document.querySelector('.selected-seats');
    if (selectedSeats.length === 0) {
        selectedSeatsElement.innerHTML = '<h3>Your selected seats:</h3><p>No seats selected</p>';
    } else {
        selectedSeatsElement.innerHTML = '<h3>Your selected seats:</h3><p>' + selectedSeats.join('</p><p>') + '</p>';
    }

    // Update price summary (simple calculation)
    let seatPrice = 0;
    selectedSeats.forEach(seat => {
        if (seat.includes('business')) {
            seatPrice += 45;
        } else {
            seatPrice += 25;
        }
    });

    const basePrice = 25;
    const taxes = 18.50;
    const total = basePrice + taxes + seatPrice;

    let button = document.querySelector('.confirm-button')
    button.addEventListener('click', getSelectedSeats)

    if(seatPrice === 0){
        button.setAttribute('disabled', "");
    }else{
        button.removeAttribute('disabled');
    } 

    document.querySelector('.price-summary').innerHTML = `
        <h3>Price Summary</h3>
        <div class="price-row">
            <span>Base fare</span>
            <span>$${basePrice.toFixed(2)}</span>
        </div>
        <div class="price-row">
            <span>Taxes & fees</span>
            <span>$${taxes.toFixed(2)}</span>
        </div>
        <div class="price-row">
            <span>Seat selection (${selectedSeats.length} seat${selectedSeats.length !== 1 ? 's' : ''})</span>
            <span>$${seatPrice.toFixed(2)}</span>
        </div>
        <div class="price-row price-total">
            <span>Total</span>
            <span>$${total.toFixed(2)}</span>
        </div>
    `;
}
