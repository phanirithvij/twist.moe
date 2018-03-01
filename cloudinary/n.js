var request = require('request');
var FormData = require('form-data');
var fs = require('fs');
 
var fd = new FormData();
var unsignedUploadPreset = 'nslkvver';

  file = '~/Downloads/twist.moe/setings.svg';
  fd.append('upload_preset', unsignedUploadPreset);
  fd.append('tags', 'browser_upload'); // Optional - add tag for image admin in Cloudinary
  fd.append('file', file);
console.log(file);
console.log(fd);
request.post(
'https://api.cloudinary.com/v1_1/rootworld/upload',
    fd,
    function (error, response, body) {
            console.log(body);
            console.log(error);
            console.log(response);
    }
);

