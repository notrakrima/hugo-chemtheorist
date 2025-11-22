import requests
from bs4 import BeautifulSoup
import json
import os
import sys
import re
from datetime import date

# --- CONFIGURATION ---
SCHOLAR_ID = "ogleADAAAAAJ"
PUB_FILE = "content/publications/_index.md"
# ---------------------

def get_local_pub_count():
    """Reads the publications markdown file and finds the highest publication number."""
    try:
        if not os.path.exists(PUB_FILE):
            print(f"Warning: {PUB_FILE} does not exist.")
            return "N/A"
            
        with open(PUB_FILE, "r") as f:
            content = f.read()
            
        # Regex to find numbers in the format: **<a href="" download>123</a>**
        # This matches your specific pattern in the publications file
        matches = re.findall(r'\*\*<a href="" download>(\d+)</a>\*\*', content)
        
        if matches:
            # Convert strings to integers and find the maximum
            count = max(map(int, matches))
            print(f"Found local publication count: {count}")
            return str(count)
        else:
            print("Warning: No publication numbers found in file.")
            return "N/A"
            
    except Exception as e:
        print(f"Error reading publication file: {e}")
        return "N/A"

def get_metrics():
    url = f"https://scholar.google.com.au/citations?user={SCHOLAR_ID}&hl=en"
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }

    print(f"Fetching {url}...")
    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
    except Exception as e:
        print(f"Error fetching page: {e}")
        sys.exit(1)

    soup = BeautifulSoup(response.text, "html.parser")

    # Initialize metrics
    metrics = {
        "publications": get_local_pub_count(),
        "citations": "N/A",
        "h_index": "N/A",
        "i10_index": "N/A",
        "last_updated": date.today().strftime("%d/%m/%Y")
    }

    table = soup.find("table", id="gsc_rsb_st")
    if not table:
        print("Error: Could not find metrics table.")
        sys.exit(1)

    rows = table.find_all("tr")
    try:
        metrics["citations"] = rows[1].find_all("td")[1].text
        metrics["h_index"] = rows[2].find_all("td")[1].text
        metrics["i10_index"] = rows[3].find_all("td")[1].text
        print("Success! Found metrics:")
        print(json.dumps(metrics, indent=2))
    except (IndexError, AttributeError) as e:
        print(f"Error parsing table: {e}")
        sys.exit(1)

    return metrics

if __name__ == "__main__":
    data = get_metrics()
    os.makedirs("data", exist_ok=True)
    output_path = os.path.join("data", "scholar.json")
    with open(output_path, "w") as f:
        json.dump(data, f, indent=2)
    print(f"Saved metrics to {output_path}")
