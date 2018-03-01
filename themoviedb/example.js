var mdb = require('moviedb')('455dd72593a3eb5aa07bbec0e5158a41');

mdb.movieInfo({id: 11}, function(err, res){
  console.log('--------','popular');
  console.log(res);
}).miscPopularMovies({}, function(err, res){
  console.log(err);
  console.log('--------','ninja');
  console.log(res);
});

