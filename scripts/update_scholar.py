import requests
from bs4 import BeautifulSoup
import json
import os
import sys

# --- CONFIGURATION ---
# Paste your Google Scholar ID here (it's the string in your URL after user=)
SCHOLAR_ID = "8sM8GqMAAAAJ"  # I found this ID for Amir Karton (UNE)
# ---------------------

def get_metrics():
    url = f"https://scholar.google.com.au/citations?user={SCHOLAR_ID}&hl=en"
    
    # Google blocks default python requests, so we must fake a browser
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }

    print(f"Fetching {url}...")
    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
    except Exception as e:
        print(f"Error fetching page: {e}")
        sys.exit(1) # Fail the action if we can't get data

    soup = BeautifulSoup(response.text, "html.parser")

    # Data container
    metrics = {
        "citations": "N/A",
        "h_index": "N/A",
        "i10_index": "N/A"
    }

    # Scholar table structure:
    # The main table has id="gsc_rsb_st"
    table = soup.find("table", id="gsc_rsb_st")
    
    if not table:
        print("Error: Could not find metrics table. Google might be blocking the request.")
        # Check if we got a captcha page
        if "captcha" in response.text.lower():
            print("Blocked by Captcha.")
        sys.exit(1)

    # Rows: [All, Since 2019]
    # We want the first column values (All)
    rows = table.find_all("tr")
    
    try:
        # Row 1: Citations
        metrics["citations"] = rows[1].find_all("td")[1].text
        # Row 2: h-index
        metrics["h_index"] = rows[2].find_all("td")[1].text
        # Row 3: i10-index
        metrics["i10_index"] = rows[3].find_all("td")[1].text
        
        print("Success! Found metrics:")
        print(json.dumps(metrics, indent=2))

    except (IndexError, AttributeError) as e:
        print(f"Error parsing table: {e}")
        sys.exit(1)

    return metrics

if __name__ == "__main__":
    data = get_metrics()
    
    # Ensure directory exists
    os.makedirs("data", exist_ok=True)
    
    # Write file
    output_path = os.path.join("data", "scholar.json")
    with open(output_path, "w") as f:
        json.dump(data, f, indent=2)
    
    print(f"Saved metrics to {output_path}")
