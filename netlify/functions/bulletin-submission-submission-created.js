const axios = require('axios');

exports.handler = async function(event) {
  // 1. PARSE THE FORM DATA FROM THE EVENT PAYLOAD
  const { payload } = JSON.parse(event.body);
  const formData = payload.data;

  const title = formData.title;
  const institution = formData.institution;
  const pi = formData.pi;
  const link = formData.link;
  const expiryDaysInput = formData.expiryDate; // Renamed for clarity
  const category = formData.category;
  const description = formData.description;

  // --- START: NEW DATE CALCULATION LOGIC ---
  // Get the number of days from the form, default to 30 if not provided or invalid
  const expiryDays = parseInt(expiryDaysInput, 10) || 30;

  // Create a new date object for today
  const futureDate = new Date();

  // Add the number of days to today's date
  futureDate.setDate(futureDate.getDate() + expiryDays);

  // Format the future date into YYYY-MM-DD format for Hugo
  const year = futureDate.getFullYear();
  const month = String(futureDate.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
  const day = String(futureDate.getDate()).padStart(2, '0');
  const formattedExpiryDate = `${year}-${month}-${day}`;
  // --- END: NEW DATE CALCULATION LOGIC ---


  // 2. CREATE THE MARKDOWN CONTENT (NOW USING THE FORMATTED DATE)
  const markdownContent = `---
# ===================================================================
# Opportunity Details - Automatically generated from form submission
# ===================================================================

title: "${title}"
institution: "${institution}"
pi: "${pi}"
link: "${link}"

# --- DATES (Use YYYY-MM-DD format) ---
publishDate: ${new Date().toISOString().split('T')[0]}
expiryDate: ${formattedExpiryDate}

# --- CATEGORY ---
category: "${category}"

# ===================================================================
---

${description}
`;

  // 3. PREPARE FOR GITHUB API
  const GITHUB_TOKEN = process.env.GITHUB_ACCESS_TOKEN;
  const REPO_OWNER = 'notrakrima'; // Your GitHub username
  const REPO_NAME = 'hugo-chemtheorist'; // Your repository name
  
  const safeTitle = title.toLowerCase().replace(/[^a-z0-9]+/g, '-').substring(0, 50);
  const timestamp = new Date().getTime();
  const FILENAME = `${safeTitle}-${timestamp}.md`;
  const FILE_PATH = `content/bulletin/${FILENAME}`;
  
  const COMMIT_MESSAGE = `New job submission: ${title}`;
  const encodedContent = Buffer.from(markdownContent).toString('base64');

  // 4. SEND THE DATA TO GITHUB
  const url = `https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}`;
  const data = { message: COMMIT_MESSAGE, content: encodedContent, branch: 'main' };
  const headers = { 'Authorization': `token ${GITHUB_TOKEN}`, 'Accept': 'application/vnd.github.v3+json' };

  try {
    await axios.put(url, data, { headers });
    console.log('Successfully created file in GitHub.');
    return { statusCode: 200, body: 'File created successfully.' };
  } catch (error) {
    console.error('Error committing to GitHub:', error.response ? error.response.data : error.message);
    return { statusCode: 500, body: 'Error creating file.' };
  }
};
