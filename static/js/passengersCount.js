document.addEventListener("DOMContentLoaded", function () {
  const decreasePassengers = document.getElementById("decreasePassengers");
  const increasePassengers = document.getElementById("increasePassengers");
  const passengersCount = document.getElementById("passengersCount");
  const passengersInput = document.getElementById("passengers");

  let currentPassengers = parseInt(passengersInput.value);

  decreasePassengers.addEventListener("click", function () {
    if (currentPassengers > 1) {
      currentPassengers--;
      passengersCount.innerText = currentPassengers;
      passengersInput.value = currentPassengers;
    }
  });

  increasePassengers.addEventListener("click", function () {
    currentPassengers++;
    passengersCount.innerText = currentPassengers;
    passengersInput.value = currentPassengers;
  });
});
