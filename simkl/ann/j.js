var cloudinary = require('cloudinary');

cloudinary.config().cloud_name = 'rootworld';
cloudinary.config().api_key = '176599776638439';
cloudinary.config().api_secret = 'zISTHB4Cj4j0AWj3hKSabOxVjWA';


cloudinary.uploader.upload("~/Downloads/twist.moe/settings.svg", {public_id : "Test/settings"} ,function(error, result) {console.log(result)});
cloudinary.v2.uploader.upload("~/Downloads/twist.moe/settings.svg", {public_id : "Test/settings"} ,function(error, result) {console.log(result)});

