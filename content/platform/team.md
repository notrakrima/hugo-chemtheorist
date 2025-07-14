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
  }
  .team-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 15px rgba(0,0,0,0.1);
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
    min-height: 50px; /* Ensures cards have similar height */
    margin-bottom: 1.5rem;
  }
  .scholar-link {
    display: inline-block; /* Simplified from flex */
    padding: 0.6rem 1.2rem;
    border: 1px solid #ccc;
    border-radius: 20px;
    text-decoration: none;
    color: #0056b3;
    font-weight: bold;
    transition: background-color 0.2s, color 0.2s;
  }
  .scholar-link:hover {
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
  <p>Our platform is driven by a multidisciplinary team of world-leading experts. Full profiles are coming soon.</p>

  <div class="team-cards-container">
    <div class="team-card">
      <h3>Prof. Amir Karton</h3>
      <p class="expertise">Quantum Chemistry, DFT & Robotics</p>
      <a href="https://scholar.google.com.au/citations?user=ogleADAAAAAJ&hl=en" class="scholar-link" target="_blank" rel="noopener noreferrer">
        Google Scholar
      </a>
    </div>
    <div class="team-card">
      <h3>Prof. Raymond Chiong</h3>
      <p class="expertise">Artificial Intelligence & Machine Learning</p>
      <a href="https://scholar.google.com.my/citations?hl=en&user=NWeGxvIAAAAJ&view_op=list_works&sortby=pubdate" class="scholar-link" target="_blank" rel="noopener noreferrer">
        Google Scholar
      </a>
    </div>
    <div class="team-card">
      <h3>Dr. Kasimir Gregory</h3>
      <p class="expertise">DFT & Machine Learning</p>
      <a href="https://scholar.google.com.au/citations?user=O65PgjUAAAAJ&hl=en" class="scholar-link" target="_blank" rel="noopener noreferrer">
        Google Scholar
      </a>
    </div>
    <div class="team-card">
      <h3>Dr. Tanveer Hussain</h3>
      <p class="expertise">DFT & Materials Simulation</p>
      <a href="https://scholar.google.com.au/citations?user=FJ5HkoIAAAAJ&hl=en" class="scholar-link" target="_blank" rel="noopener noreferrer">
        Google Scholar
      </a>
    </div>
  </div>

  <p class="contact-footer">Please <a href="/contact/">contact us</a> for collaboration inquiries.</p>
</div>
