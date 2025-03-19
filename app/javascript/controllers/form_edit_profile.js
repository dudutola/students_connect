document.addEventListener('DOMContentLoaded', function() {
  const addCustomSkillBtn = document.getElementById('add-custom-skill');
  const customSkillInput = document.getElementById('custom-skill-input');
  const predefinedSkills = document.querySelector('.predefined-skills');
  
  if (addCustomSkillBtn && customSkillInput && predefinedSkills) {
    addCustomSkillBtn.addEventListener('click', function() {
      const skillName = customSkillInput.value.trim();
      
      if (skillName) {
        // Create a unique ID for the skill
        const skillId = 'skill-' + skillName.toLowerCase().replace(/\s+/g, '-');
        
        // Check if this skill already exists
        if (!document.getElementById(skillId)) {
          // Create a new skill checkbox
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
          
          skillDiv.appendChild(checkbox);
          skillDiv.appendChild(label);
          predefinedSkills.appendChild(skillDiv);
          
          // Clear the input
          customSkillInput.value = '';
        } else {
          // If skill already exists, just check it
          document.getElementById(skillId).checked = true;
        }
      }
    });
    
    // Allow adding by pressing Enter
    customSkillInput.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        addCustomSkillBtn.click();
      }
    });
  }
});