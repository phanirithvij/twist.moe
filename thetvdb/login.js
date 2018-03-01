var curl = require('curlconverter');

var curlinput = "curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{\"apikey\": \"DA9E813C65A0D457\",\"userkey\": \"1ED0DA3162F6EEF0\",\"username\": \"phanirithvij\"}' 'https://api.thetvdb.com/login'";

var e = curl.toNode(curlinput);
console.log(e);
