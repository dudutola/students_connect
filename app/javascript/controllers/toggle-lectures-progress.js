document.addEventListener('turbo:load', initToggle);
document.addEventListener('turbolinks:load', initToggle);

function initToggle() {
  const chapterHeaders = document.querySelectorAll('.progress-header[data-toggle="collapse"]');
  
  chapterHeaders.forEach(header => {
    header.addEventListener('click', function() {
      const targetSelector = this.dataset.target;
      if (!targetSelector) return; 

      const target = document.querySelector(targetSelector);
      if (!target) return; 

      const isExpanded = this.getAttribute('aria-expanded') === 'true';
      
      this.setAttribute('aria-expanded', String(!isExpanded));
      target.classList.toggle('show', !isExpanded);
    });
  });
}

