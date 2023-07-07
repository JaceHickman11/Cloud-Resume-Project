const apiURL = 'https://z3v2iubne2.execute-api.us-east-2.amazonaws.com/beta'

const postData = async (data) => {
  try {
    const response = await fetch(apiURL + '/endpoint', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({}),
    });
