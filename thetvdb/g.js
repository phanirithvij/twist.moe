var request = require('request');

var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
};

var dataString = '{"apikey": "DA9E813C65A0D457","userkey": "1ED0DA3162F6EEF0","username": "phanirithvij"}';

var options = {
    url: 'https://api.thetvdb.com/login',
    method: 'POST',
    headers: headers,
    body: dataString
};

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        console.log(body);
    }
}

request(options, callback);

