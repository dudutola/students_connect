(function() {
  // Try all possible initialization approaches
  if (document.readyState === 'complete' || document.readyState === 'interactive') {
    // If document is already loaded, run now
    setTimeout(initSkillsEditor, 100);
  }
  
  // Standard event listeners
  document.addEventListener('DOMContentLoaded', initSkillsEditor);
  
  // For Turbolinks
  document.addEventListener('turbolinks:load', initSkillsEditor);
  
  // For jQuery-based apps
  if (typeof jQuery !== 'undefined') {
    jQuery(document).ready(initSkillsEditor);
    jQuery(document).on('turbolinks:load', initSkillsEditor);
  }
  
  // Wait a bit after page load as a fallback
  window.addEventListener('load', function() {
    setTimeout(initSkillsEditor, 200);
  });
})();


// The main initialization function that sets everything up
function initSkillsEditor() {
  console.log('[SkillsEditor] Initializing...');
  
  // Get all required elements
  const addBtn = document.getElementById('add-custom-skill');
  const inputField = document.getElementById('custom-skill-input');
  const skillsContainer = document.querySelector('.predefined-skills');
  
  // Log what we found for debugging
  console.log('[SkillsEditor] Elements found:', {
    addBtn: !!addBtn, 
    inputField: !!inputField,
    skillsContainer: !!skillsContainer
  });
  
  // Stop if any required element is missing
  if (!addBtn || !inputField || !skillsContainer) {
    console.warn('[SkillsEditor] Cannot initialize - missing elements');
    return;
  }
  
  // Clear any existing event listeners by cloning the button
  const newBtn = addBtn.cloneNode(true);
  addBtn.parentNode.replaceChild(newBtn, addBtn);
  
  // Add our click handler to the button
  newBtn.addEventListener('click', function(e) {
    e.preventDefault();
    console.log('[SkillsEditor] Add button clicked');
    addCustomSkill();
  });
  
  // Also support adding with Enter key
  inputField.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      console.log('[SkillsEditor] Enter key pressed');
      addCustomSkill();
    }
  });
  
  // The function to add a custom skill
  function addCustomSkill() {
    const skillName = inputField.value.trim();
    
    if (!skillName) {
      console.log('[SkillsEditor] Empty skill name, doing nothing');
      return;
    }
    
    console.log('[SkillsEditor] Adding skill:', skillName);
    
    // Create a unique ID for the skill
    const skillId = 'skill-' + skillName.toLowerCase().replace(/[^a-z0-9]/g, '-');
    
    // Check if already exists
    if (document.getElementById(skillId)) {
      console.log('[SkillsEditor] Skill already exists, checking it');
      document.getElementById(skillId).checked = true;
      inputField.value = '';
      return;
    }
    
    // Create the skill elements
    const skillDiv = document.createElement('div');
    skillDiv.className = 'skill-checkbox';
    
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.name = 'user[skills][]';
    checkbox.value = skillName;
    checkbox.id = skillId;
    checkbox.className = 'form-check-input';
    checkbox.checked = true;
    
    const label = document.createElement('label');
    label.htmlFor = skillId;
    label.className = 'form-check-label';
    label.textContent = skillName;
    
    // Add to the DOM
    skillDiv.appendChild(checkbox);
    skillDiv.appendChild(label);
    skillsContainer.appendChild(skillDiv);
    
    // Clear the input field
    inputField.value = '';
    
    console.log('[SkillsEditor] Skill added successfully');
  }
  
  // Add debugging for form submission
  const form = document.querySelector('form');
  if (form) {
    form.addEventListener('submit', function() {
      const checkedSkills = document.querySelectorAll('input[name="user[skills][]"]:checked');
      const skillsList = Array.from(checkedSkills).map(cb => cb.value);
      
      console.log('[SkillsEditor] Form submitted with skills:', skillsList);
    });
  }
  
  console.log('[SkillsEditor] Initialization complete');
}