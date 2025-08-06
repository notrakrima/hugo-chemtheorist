---
title: "Unsubscribe from Mailing List"
date: 2025-08-06
layout: "single"
---

We're sorry to see you go. Use the form below to remove your email from the Australian Computational Chemistry mailing list.

<div class="row mt-5 justify-content-center">
  <div class="col-md-8">
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Unsubscribe</h4>
        <p class="card-text">Remove your email from the list.</p>
        <form name="unsubscribe" method="POST" data-netlify="true" data-netlify-recaptcha="true">
          <div class="mb-3">
            <label for="unsubscribe-email" class="form-label">Email address</label>
            <input type="email" name="email" class="form-control" id="unsubscribe-email" placeholder="name@example.com" required>
          </div>
          <div data-netlify-recaptcha="true" class="mb-3"></div>
          <button type="submit" class="btn btn-danger">Unsubscribe</button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="text-center mt-4">
    <p>Changed your mind? <a href="/mailing-list/">Subscribe again</a>.</p>
</div>
