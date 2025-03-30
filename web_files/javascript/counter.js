// Update Page Views: by sending a POST request to AWS API
// API forwards the request to AWS Lambda which executes a python script
// Lambda increments a database value and provides the updated value to counter.js

// apiURL is updated by deploy-frontend.yml in case the backend URL changes due to updates/destruction
// sed -i "s|const apiURL = .*|const apiURL = '$API_URL'|" javascript/counter.js
const apiURL = 'https://c0dal8s0dk.execute-api.us-east-2.amazonaws.com/beta';

const updateCounter = async () => {
  try {
    const response = await fetch(apiURL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    // Parse the JSON response from API
    const data = await response.json();
    console.log("Full API Gateway Response:", data); 

    // Extract visitor count 
    const visitorCount = data['Updated visitor_count'];

    if (visitorCount !== undefined) {
      document.getElementById('counter').innerText = `Page Views: ${visitorCount}`;
    } else {
      throw new Error("Missing 'Updated visitor_count' in response.");
    }

  } catch (error) {
    console.error("Error updating counter:", error);
    document.getElementById('counter').innerText = 'Error loading counter';
  }
};

// Call function
updateCounter();
