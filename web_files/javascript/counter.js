// Update the counter element by sending a POST request to AWS API
// API will execute a python script in lambda
// Lamda will increment a database value a provide the new value to the counter

const apiURL = 'https://z3v2iubne2.execute-api.us-east-2.amazonaws.com/beta'
const updateCounter = async () => {
  try {
    // Send POST request to AWS API
    const response = await fetch(apiURL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      }
    });
    // Check for OK 200+
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    const data = await response.json();
    console.log(data);
    // Parse API response as JSON
    // Update counter element "Page Views on webpage"
    const parsedBody  = JSON.parse(data.body);
    const visitorCount = parsedBody['Updated visitor_count'];
    document.getElementById('counter').innerText = `Page Views: ${visitorCount}`;
    // Log error to console and display error msg on webpage
  } catch (error) {
    console.error('Error:', error);
    document.getElementById('counter').innerText = 'Error loading counter';
  }
};

// Call function
updateCounter();
