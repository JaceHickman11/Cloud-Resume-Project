// Load the AWS SDK for Node.js
const AWS = require('aws-sdk');

// Set the region
AWS.config.update({region: 'us-east-1'});

// Create the DynamoDB service object
const dynamodb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

// Get the current count from DynamoDB
dynamodb.getItem({
  TableName: 'PageViews',
  Key: {
    'counterName': {S: 'index.html'}
  }
}, function(err, data) {
  if (err) {
    console.log(err, err.stack);
  } else {
    let count = data.Item.Count.N;

    // If the count is not set, initialize it to 0
    if (!count) {
      count = 0;
    }

    // Increment the count and save it back to DynamoDB
    count++;
    dynamodb.updateItem({
      TableName: 'PageViews',
      Key: {
        'counterName': {S: 'index.html'}
      },
      UpdateExpression: 'SET #count = :count',
      ExpressionAttributeNames: {
        '#count': 'Count'
      },
      ExpressionAttributeValues: {
        ':count': {N: count.toString()}
      }
    }, function(err, data) {
      if (err) {
        console.log(err, err.stack);
      } else {
        console.log(data);
      }
    });

    // Display the count on the webpage
    let counterElement = document.getElementById('counter');
    counterElement.innerText = 'Page views: ' + count;
  }
});
