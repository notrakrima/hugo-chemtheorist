---
title: "Our Team"
date: 2025-06-25
---

<style>
  .team-page-container {
    max-width: 1100px;
    margin: 2rem auto;
    padding: 1rem;
    text-align: center;
  }
  .team-cards-container {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: center;
    margin-top: 2rem;
  }
  .team-card {
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 2rem 1.5rem;
    flex: 1 1 250px;
    max-width: 280px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    text-align: center;
    transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .team-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 15px rgba(0,0,0,0.1);
  }
  .team-headshot {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 1rem;
    border: 3px solid #f0f0f0;
  }
  .team-card h3 {
    margin-top: 0;
    margin-bottom: 0.5rem;
    font-size: 1.3rem;
    color: #2c3e50;
  }
  .team-card .expertise {
    font-size: 0.95rem;
    color: #555;
    min-height: 40px;
    margin-bottom: 1rem;
  }
  .links-container {
    margin-top: auto; /* Pushes links to the bottom of the card */
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
    align-items: center;
  }
  .team-link {
    display: block;
    width: 85%;
    padding: 0.6rem 0;
    border: 1px solid #ccc;
    border-radius: 20px;
    text-decoration: none;
    color: #0056b3;
    font-weight: bold;
    transition: background-color 0.2s, color 0.2s;
  }
  .team-link:hover {
    background-color: #0056b3;
    color: #fff;
  }
  .contact-footer {
    margin-top: 3rem;
    font-size: 1.1rem;
  }
</style>

<div class="team-page-container">
  <h1>Meet the Experts</h1>
  <p>Our team unites world-leading expertise in quantum chemistry, artificial intelligence, and robotic automation to solve the most complex challenges in chemical discovery.</p>

  <div class="team-cards-container">
    <!-- Amir Karton -->
    <div class="team-card">
      <img src="/images/amir.jpg" alt="Prof. Amir Karton" class="team-headshot">
      <h3>Prof. Amir Karton</h3>
      <p class="expertise">Quantum Chemistry, DFT & Robotics</p>
      <div class="links-container">
        <a href="https://www.une.edu.au/staff-profiles/science-and-technology/amir-karton" class="team-link" target="_blank" rel="noopener noreferrer">UNE Profile</a>
        <a href="https://scholar.google.com.au/citations?user=ogleADAAAAAJ&hl=en" class="team-link" target="_blank" rel="noopener noreferrer">Google Scholar</a>
      </div>
    </div>
    <!-- Raymond Chiong -->
    <div class="team-card">
      <img src="/images/raymond.jpg" alt="Prof. Raymond Chiong" class="team-headshot">
      <h3>Prof. Raymond Chiong</h3>
      <p class="expertise">Artificial Intelligence & Machine Learning</p>
      <div class="links-container">
        <a href="https://www.une.edu.au/about-une/faculty-of-science-agriculture-business-and-law/school-of-science-and-technology/our-staff" class="team-link" target="_blank" rel="noopener noreferrer">UNE Profile</a>
        <a href="https://scholar.google.com.my/citations?hl=en&user=NWeGxvIAAAAJ" class="team-link" target="_blank" rel="noopener noreferrer">Google Scholar</a>
      </div>
    </div>
    <!-- Kasimir Gregory -->
    <div class="team-card">
      <img src="/images/kasimir.jpg" alt="Dr. Kasimir Gregory" class="team-headshot">
      <h3>Dr. Kasimir Gregory</h3>
      <p class="expertise">DFT & Machine Learning</p>
      <div class="links-container">
        <a href="https://www.une.edu.au/staff-profiles/science-and-technology/kasimir-gregory" class="team-link" target="_blank" rel="noopener noreferrer">UNE Profile</a>
        <a href="https://scholar.google.com.au/citations?user=O65PgjUAAAAJ&hl=en" class="team-link" target="_blank" rel="noopener noreferrer">Google Scholar</a>
      </div>
    </div>
    <!-- Tanveer Hussain -->
    <div class="team-card">
      <img src="/images/tanveer.jpg" alt="Dr. Tanveer Hussain" class="team-headshot">
      <h3>Dr. Tanveer Hussain</h3>
      <p class="expertise">DFT & Materials Simulation</p>
      <div class="links-container">
        <a href="https://www.une.edu.au/staff-profiles/science-and-technology/tanveer-hussain" class="team-link" target="_blank" rel="noopener noreferrer">UNE Profile</a>
        <a href="https://scholar.google.com.au/citations?user=FJ5HkoIAAAAJ&hl=en" class="team-link" target="_blank" rel="noopener noreferrer">Google Scholar</a>
      </div>
    </div>
  </div>

  <p class="contact-footer">Please <a href="/contact/">contact us</a> for collaboration inquiries.</p>
</div>
