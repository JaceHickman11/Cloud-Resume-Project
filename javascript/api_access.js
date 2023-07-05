const apiURL = 'https://c9i2ztstv8.execute-api.us-east-2.amazonaws.com/'

const postData = async (data) => {
  try {
    const response = await fetch(apiURL + '/endpoint', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
