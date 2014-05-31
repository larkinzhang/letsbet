var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'a',
    database:'LB',
    port: 3306
});

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});



router.get('/main', function(req, res) {
  //res.render('index', { title: 'Express' });
  //res.send('111');
  res.end('111111');

});


/*------------------------Show phase---------------------*/


module.exports = router;