#!/bin/zsh

# 1. Go to the project folder
cd /Users/amirk/Desktop/WebSite/hugo-quickstart-861bb || exit

# 2. Update the code first
/usr/bin/git pull origin main >> /tmp/scholar_update.log 2>&1

# 3. Run the Python script
/Users/amirk/miniforge3/bin/python scripts/update_scholar.py >> /tmp/scholar_update.log 2>&1

# 4. Check if the file changed. If yes, send it to GitHub.
if [[ -n $(/usr/bin/git status -s data/scholar.json) ]]; then
    /usr/bin/git add data/scholar.json
    /usr/bin/git commit -m "Daily local update of Scholar metrics"
    /usr/bin/git push origin main >> /tmp/scholar_update.log 2>&1
    echo "$(date): Updated Scholar Metrics" >> /tmp/scholar_update.log
else
    echo "$(date): No changes in metrics" >> /tmp/scholar_update.log
fi
