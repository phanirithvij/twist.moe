var cloudinary = require('cloudinary');

cloudinary.config().cloud_name = 'rootworld';
cloudinary.config().api_key = '176599776638439';
cloudinary.config().api_secret = 'zISTHB4Cj4j0AWj3hKSabOxVjWA';

var img = cloudinary.url("Screenshot_20180227-012914.png", {width: 100, height: 150, crop: "fill"});
console.log('img',img);

var img2 = cloudinary.url("Test/one-piece-HD-manga-anime-widescreen-desktop-wallpapers-free-download-a17", {width: 100, height: 150, crop: "fill"});
console.log('img2',img2);

cloudinary.v2.uploader.upload("/ug/ug2k17/cse/phani.rithvij/Downloads/twist.moe/settings.svg",
	{ public_id : "Test/settings"} ,
	function(error, result) {console.log('v2',result + error)}
);


cloudinary.api.resource('Screenshot_20180227-012914',
  function(error, result){console.log('res',error)});

