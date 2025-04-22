document.addEventListener("DOMContentLoaded", function () {
  // Highlight selected seat
  const seatRadios = document.querySelectorAll(".seat-radio");
  seatRadios.forEach((radio) => {
    radio.addEventListener("change", function () {
      // Remove all selected classes first
      document.querySelectorAll(".seat").forEach((seat) => {
        seat.classList.remove("selected");
      });

      // Add selected class to the chosen seat
      if (this.checked) {
        const label = document.querySelector(`label[for="${this.id}"]`);
        label.classList.add("selected");
      }
    });
  });
});
