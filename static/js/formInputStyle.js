export function initFormInputStyle() {
  document.querySelectorAll('.form-control').forEach(input => {
    input.addEventListener('input', () => {
      input.style.color = '#fff';
    });
  });
}
