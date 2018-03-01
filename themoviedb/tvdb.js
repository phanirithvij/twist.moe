var request = require('request');

var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MTk5OTY3MTIsImlkIjoiUm9vdHdvcmxkIiwib3JpZ19pYXQiOjE1MTk5MTAzMTIsInVzZXJpZCI6NDk5NzU2LCJ1c2VybmFtZSI6InBoYW5pcml0aHZpaiJ9.Pk9gKSC_GFdqPMZ5gUO4IYhl7Wapbewq3dgQ9uYuHugD5RBooMOETMBy7m907yW9c6vqgaoadhlwrMUGOAgDqYQA6Fh47IrL3Z7g09lzXfhXYktil6vF5UkG51z5ut4t53Ut7KSQA5Lw1ml0Nocu9_MqeaQfrMqdN60f6mhKD6aoQ4CsYtN5kh5FCs-v1HFmU_yFL-h09VgisFbDtT4OJjpV9a-hNSjmZB9ctr84oAfWkFhP0iR9omYRjiSF9bqgD2JLp1N7nwz-RgZKOMi1TO1cvwtwHkl1Qft6l3Q6QWNKGvO6yUGJqMcwzbb4-geD9EEndoF1SW04-z6VNTkGMw'
};

var options = {
    url: 'https://api.thetvdb.com/series/81797/images/query?keyType=season',
    headers: headers
};

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        console.log(body);
    }
}

request(options, callback);
