#!/usr/bin/env python3
"""
This script fetches new form submissions from the Netlify API,
creates correctly formatted Markdown files for a Hugo site, and tracks
processed submissions to prevent duplicates.
"""
import os
import re
import datetime
import requests

# --- CONFIGURATION ---
CREDENTIALS_FILE_PATH = '~/Desktop/WebSite/.form-id_api'
OUTPUT_DIR = 'content/bulletin'
PROCESSED_IDS_FILE = 'processed_submission_ids.txt'

def load_credentials_from_file(filepath):
    """Loads API credentials from a shell-style export file."""
    expanded_path = os.path.expanduser(filepath)
    try:
        with open(expanded_path, 'r') as f:
            for line in f:
                match = re.match(r'export\s+([A-Z_]+)="(.*)"', line.strip())
                if match:
                    key, value = match.groups()
                    os.environ[key] = value
    except FileNotFoundError:
        print(f"FATAL ERROR: Credentials file not found at {expanded_path}")
        exit()

def get_processed_ids():
    """Reads the set of already processed submission IDs."""
    if not os.path.exists(PROCESSED_IDS_FILE):
        return set()
    with open(PROCESSED_IDS_FILE, 'r') as f:
        return set(line.strip() for line in f)

def save_processed_id(submission_id):
    """Appends a new processed submission ID to the tracking file."""
    with open(PROCESSED_IDS_FILE, 'a') as f:
        f.write(f"{submission_id}\n")

def main():
    """Main function to run the entire process."""
    load_credentials_from_file(CREDENTIALS_FILE_PATH)
    api_token = os.getenv('NETLIFY_API_TOKEN')
    form_id = os.getenv('NETLIFY_FORM_ID')

    if not api_token or not form_id:
        print("FATAL ERROR: API credentials could not be loaded.")
        return

    print("Fetching submissions from Netlify API...")
    headers = {'Authorization': f'Bearer {api_token}'}
    url = f'https://api.netlify.com/api/v1/forms/{form_id}/submissions'
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        submissions = response.json()
    except requests.exceptions.RequestException as e:
        print(f"FATAL ERROR: Could not fetch data from Netlify API: {e}")
        return

    processed_ids = get_processed_ids()
    new_submissions_found = 0
    print(f"Found {len(submissions)} total submissions. Checking for new ones...")

    for sub in reversed(submissions):
        sub_id = sub['id']
        if sub_id in processed_ids:
            continue

        new_submissions_found += 1
        print(f"Processing new submission ID: {sub_id}")
        
        data = sub['data']
        title = data.get('title', 'Untitled Post').replace('"', '“')
        institution = data.get('institution', 'N/A').replace('"', '“')
        pi = data.get('submitter-name', 'N/A').replace('"', '“')
        link = data.get('link', '')
        description = data.get('description', 'No description provided.')
        
        try:
            end_date_str = data.get('end-date')
            expiry_date = datetime.datetime.strptime(end_date_str, '%Y-%m-%d').strftime('%Y-%m-%d')
        except (ValueError, TypeError):
            expiry_date_obj = datetime.date.today() + datetime.timedelta(days=30)
            expiry_date = expiry_date_obj.strftime('%Y-%m-%d')

        # --- THE CRITICAL FIX ---
        # Dates are NOT in quotes. This allows Hugo to parse them as date objects,
        # which is essential for the filtering logic in the layout template.
        markdown_content = f"""---
title: "{title}"
institution: "{institution}"
pi: "{pi}"
link: "{link}"
publishDate: {datetime.date.today().strftime('%Y-%m-%d')}
expiryDate: {expiry_date}
category: "Job"
---

{description}
"""
        
        safe_title = ''.join(c for c in title if c.isalnum() or c in ' .-_').lower().replace(' ', '-')
        filename = f"{datetime.date.today().strftime('%Y-%m-%d')}-{safe_title[:50]}-{sub_id[:6]}.md"
        filepath = os.path.join(OUTPUT_DIR, filename)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(markdown_content)
        
        print(f"  -> Successfully created file: {filepath}")
        save_processed_id(sub_id)

    if new_submissions_found == 0:
        print("Finished. No new submissions to process.")
    else:
        print(f"Finished. Successfully processed {new_submissions_found} new submission(s).")

if __name__ == '__main__':
    main()
