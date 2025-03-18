document.addEventListener('DOMContentLoaded', function() {
  setTimeout(function() {
    const scrollHint = document.querySelector('.scrolldown-hint');
    if (scrollHint) {
      scrollHint.style.opacity = '0';
      scrollHint.style.transition = 'opacity 1s';
    }
  }, 5000);
});