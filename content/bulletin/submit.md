---
title: "Submit an Advertisement"
date: 2025-08-01
layout: "single"
---

Thank you for contributing to the Australian computational chemistry community. 

Please fill out the form below to submit an advertisement for the [Australian Computational Chemistry Bulletin Board](/bulletin/).

All submissions will be reviewed before posting. 

The ad will appear on the board between the start and end dates you specify.

<br>

<form id="job-submission-form" name="bulletin-submission" method="POST" action="/bulletin/success/" data-netlify="true" data-netlify-recaptcha="true">
  <p>
    <label>Your Name: <input type="text" name="submitter-name" required /></label> (will be displayed)
  </p>
  <p>
    <label>Your Email: <input type="email" name="submitter-email" required /></label> (will NOT be displayed)
  </p>
  <p>
    <label>Opportunity Title: <input type="text" name="title" required /></label> (will be displayed)
  </p>
  <p>
    <label>University / Institution / Company: <input type="text" name="institution" required /></label> (will be displayed)
  </p>
<p>
  <label for="description-textarea">PhD / Postdoc / Job / Conference Description (100-word limit):</label><br>
  <textarea name="description" id="description-textarea" rows="10" style="width: 100%;" required></textarea>
  <small id="word-count-display" style="color: #555;">0 / 100 words</small>
  <small id="word-limit-error" style="color: red; display: none; font-weight: bold; display: block; margin-top: 5px;"></small>
</p>

<script>
  const form = document.getElementById('job-submission-form');
  const descriptionTextarea = document.getElementById('description-textarea');
  const wordCountDisplay = document.getElementById('word-count-display');
  const errorDisplay = document.getElementById('word-limit-error');
  const wordLimit = 100;

  // --- 1. Real-time feedback as the user types ---
  descriptionTextarea.addEventListener('input', () => {
    const words = descriptionTextarea.value.trim().split(/\s+/).filter(word => word.length > 0);
    const wordCount = words.length;

    // Update the word count display
    wordCountDisplay.textContent = `${wordCount} / ${wordLimit} words`;

    // Show/hide the error message and change color
    if (wordCount > wordLimit) {
      wordCountDisplay.style.color = 'red';
      errorDisplay.textContent = 'Word limit exceeded. Please shorten your description.';
      errorDisplay.style.display = 'block'; // Show the error
    } else {
      wordCountDisplay.style.color = '#555';
      errorDisplay.style.display = 'none'; // Hide the error
    }
  });

  // --- 2. Final validation before submitting the form ---
  form.addEventListener('submit', (event) => {
    const words = descriptionTextarea.value.trim().split(/\s+/).filter(word => word.length > 0);
    
    // If word count is over the limit, block the submission
    if (words.length > wordLimit) {
      event.preventDefault(); // This is the crucial line that stops the form submission
      
      // Ensure the error message is visible and alert the user
      errorDisplay.textContent = 'Cannot submit. Word limit exceeded. Please shorten your description.';
      errorDisplay.style.display = 'block';
      alert('Please fix the errors before submitting: The description exceeds the 100-word limit.');
    }
  });
</script>
  <p>
    <label>Link for More Information: <input type="url" name="link" /></label> (will be displayed)
  </p>
  <p>
    <label>Display Ad From (Start Date): <input type="date" name="start-date" required /></label>
  </p>
  <p>
    <label>Display Ad Until (End Date): <input type="date" name="end-date" required /></label>
  </p>
  
  <div data-netlify-recaptcha="true" style="margin-bottom: 1rem;"></div>

  <p>
    <button type="submit">Submit for Review</button>
  </p>
</form>
