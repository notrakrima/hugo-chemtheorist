const axios = require('axios');

exports.handler = async function(event) {
  // ===================================================================
  // STEP 1: LOG THE RAW INCOMING DATA (FOR DEBUGGING)
  // ===================================================================
  console.log("Function triggered. Raw event body:", event.body);

  try {
    // ===================================================================
    // STEP 2: PARSE THE FORM DATA
    // ===================================================================
    const { payload } = JSON.parse(event.body);
    console.log("Successfully parsed JSON. Payload object:", payload);
    
    const formData = payload.data;
    if (!formData) {
      console.error("Error: 'payload.data' is missing.");
      return { statusCode: 400, body: "Bad request: payload.data is missing." };
    }
    console.log("Successfully accessed formData:", formData);

    const title = formData.title || "Untitled";
    const institution = formData.institution || "N/A";
    const pi = formData.pi || "N/A";
    const link = formData.link || "";
    const expiryDaysInput = formData.expiryDate;
    const category = formData.category || "Other";
    const description = formData.description || "No description provided.";

    // ===================================================================
    // STEP 3: CALCULATE THE EXPIRY DATE
    // ===================================================================
    const expiryDays = parseInt(expiryDaysInput, 10) || 30;
    const futureDate = new Date();
    futureDate.setDate(futureDate.getDate() + expiryDays);
    const year = futureDate.getFullYear();
    const month = String(futureDate.getMonth() + 1).padStart(2, '0');
    const day = String(futureDate.getDate()).padStart(2, '0');
    const formattedExpiryDate = `${year}-${month}-${day}`;
    console.log(`Calculated expiry date: ${formattedExpiryDate}`);

    // ===================================================================
    // STEP 4: CREATE THE MARKDOWN CONTENT
    // ===================================================================
    const markdownContent = `---
title: "${title}"
institution: "${institution}"
pi: "${pi}"
link: "${link}"
publishDate: ${new Date().toISOString().split('T')[0]}
expiryDate: ${formattedExpiryDate}
category: "${category}"
---

${description}
`;

    // ===================================================================
    // STEP 5: COMMIT TO GITHUB (No changes needed here)
    // ===================================================================
    const GITHUB_TOKEN = process.env.GITHUB_ACCESS_TOKEN;
    const REPO_OWNER = 'notrakrima';
    const REPO_NAME = 'hugo-chemtheorist';
    const safeTitle = title.toLowerCase().replace(/[^a-z0-9]+/g, '-').substring(0, 50);
    const timestamp = new Date().getTime();
    const FILENAME = `${safeTitle}-${timestamp}.md`;
    const FILE_PATH = `content/bulletin/${FILENAME}`;
    const COMMIT_MESSAGE = `New job submission: ${title}`;
    const encodedContent = Buffer.from(markdownContent).toString('base64');
    const url = `https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${FILE_PATH}`;
    const data = { message: COMMIT_MESSAGE, content: encodedContent, branch: 'main' };
    const headers = { 'Authorization': `token ${GITHUB_TOKEN}`, 'Accept': 'application/vnd.github.v3+json' };

    await axios.put(url, data, { headers });
    console.log('Successfully created file in GitHub.');
    return { statusCode: 200, body: 'File created successfully.' };

  } catch (error) {
    // ===================================================================
    // FINAL STEP: CATCH AND LOG ANY CRASH
    // ===================================================================
    console.error("!!! FUNCTION CRASHED !!!");
    console.error("Error message:", error.message);
    console.error("Full error object:", error);
    return { statusCode: 500, body: `Function failed: ${error.message}` };
  }
};
