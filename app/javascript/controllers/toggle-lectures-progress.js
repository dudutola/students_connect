document.addEventListener('turbo:load', function() {
  initToggle();
});

// Or for Turbolinks
document.addEventListener('turbolinks:load', function() {
  initToggle();
});

function initToggle() {
  const chapterHeaders = document.querySelectorAll('.progress-header[data-toggle="collapse"]');
  
  chapterHeaders.forEach(header => {
    header.addEventListener('click', function() {
      const target = document.querySelector(this.dataset.target);
      const isExpanded = this.getAttribute('aria-expanded') === 'true';
      
      if (isExpanded) {
        target.classList.remove('show');
        this.setAttribute('aria-expanded', 'false');
      } else {
        target.classList.add('show');
        this.setAttribute('aria-expanded', 'true');
      }
    });
  });
}
