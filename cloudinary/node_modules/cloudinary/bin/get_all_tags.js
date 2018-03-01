"use strict";
let allCursors = require('./all_cursors');
let cloudinary = require('../cloudinary');
let getAllTags = allCursors(cloudinary.v2.api.tags, (res)=> res.tags);

module.exports = getAllTags;