import requests
from bs4 import BeautifulSoup
import json
import os
from datetime import datetime

# --- CONFIGURATION ---
# REPLACE THIS WITH YOUR GOOGLE SCHOLAR ID 
# (It is the part after 'user=' in your profile URL, e.g., 'ABCD123AAAAJ')
SCHOLAR_ID = "IyBL7ogAAAAJ" 
# ---------------------

def fetch_metrics():
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36'
    }
    url = f"https://scholar.google.com/citations?user={SCHOLAR_ID}&hl=en"
    
    print(f"Fetching metrics for {SCHOLAR_ID}...")
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
    except Exception as e:
        print(f"Error connecting to Google Scholar: {e}")
        return

    soup = BeautifulSoup(response.text, 'html.parser')
    
    # The metrics table usually has this ID
    table = soup.find('table', id='gsc_rsb_st')
    
    if not table:
        print("Error: Could not find metrics table on the page.")
        return

    rows = table.find_all('tr')
    
    # Extracting data: The table columns are [Element, All, Since 20xx]
    # Row 1 is header, Row 2 is Citations, Row 3 is h-index, Row 4 is i10-index
    
    try:
        metrics = {
            "citations": {
                "all": rows[1].find_all('td')[1].text,
                "recent": rows[1].find_all('td')[2].text
            },
            "h_index": {
                "all": rows[2].find_all('td')[1].text,
                "recent": rows[2].find_all('td')[2].text
            },
            "i10_index": {
                "all": rows[3].find_all('td')[1].text,
                "recent": rows[3].find_all('td')[2].text
            },
            "last_updated": datetime.now().strftime("%d %B %Y")
        }
    except IndexError:
         print("Error: Table structure changed, could not parse.")
         return

    # Ensure data directory exists
    os.makedirs('data', exist_ok=True)
    
    # Save to JSON file that Hugo can read
    with open('data/scholar.json', 'w') as f:
        json.dump(metrics, f, indent=2)
    
    print("✅ Successfully updated scholarship metrics data.")

if __name__ == "__main__":
    fetch_metrics()
