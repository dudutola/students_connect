window.openModal = function() {
  console.log("Opening modal");
  document.getElementById('modal-overlay').style.display = 'block';
  document.getElementById('login-modal').style.display = 'block';
  document.body.style.overflow = 'hidden';
}

window.closeModal = function() {
  console.log("Closing modal");
  document.getElementById('modal-overlay').style.display = 'none';
  document.getElementById('login-modal').style.display = 'none';
  document.body.style.overflow = 'auto';
}

// Make sure the JS is loaded
document.addEventListener('turbolinks:load', () => {
  console.log("GitHub login JS loaded");
});
