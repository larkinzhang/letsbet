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

router.post('/CreateUser', function(req, res) {
    var tmp = [
        req.body['name'],
        req.body['password'],
        req.body['rrname'],
        req.body['rrpassword']
    ];
    console.log(conn.format('Insert into User Value(?,?,?,?)', tmp));
    console.log(tmp);
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('Insert into User Value(?,?,?,?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    ;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                
                //return result;
                res.send('1');

            });
        });  
    });  
});

router.post('/CreateBetAndJoin', function(req, res) {
    console.log(req.body);
    var tmp = [
    	req.body['name'],
    	req.body['penaltyA'],
    	req.body['penaltyB'],
    	req.body['introduction'],
    	req.body['RRS'],
    	req.body['RRmesA'],
    	req.body['RRmesB'],    	
    	req.body['UserName'],
    ];
    console.log(req.body);
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('call CreateBet(?,?,?,?,?,?,?,?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    //;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                
                res.send('1');
                

            });
        });  
    }); 
    
});

router.post('/UserJoinBet', function(req, res) {
    var tmp = [
        req.body['name'],
        req.body['idBets'],
        req.body['party'],
        0,
        0
        
    ];
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('Insert into User_has_Bets value(?,?,?,?,?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    ;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                
                res.send(1);
                

            });
        });  
    });
});
    

router.post('/QueryUserBets', function(req, res) {
    var tmp = [
    	req.body['name'],
    	0,
    	1
    ];
    //console.log(tmp);
    //console.log('~~~');
    
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('call QueryBets(?, ?, ?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    ;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                console.log(result);
                var tmp = { 'result' : result[0]};
                var userString = JSON.stringify(tmp);
                res.send(userString);
                

            });
        });  
    }); 
    
});    

router.post('/QueryActiveBets', function(req, res) {
    var tmp = [
        req.body['name'],
        0,
        0
    ];
    
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('call QueryBets(?, ?, ?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    ;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                console.log(result);
                var tmp = { 'result' : result[0]};
                var userString = JSON.stringify(tmp);
                res.send(userString);
                

            });
        });  
    });  
});   

router.post('/QueryNeedConfirmBets', function(req, res) {
    var tmp = [
        req.body['name'],
        1,
        1
    ];
    
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('call QueryBets(?, ?, ?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    //;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                console.log(result);
                var tmp = { 'result' : result[0]};
                var userString = JSON.stringify(tmp);
                res.send(userString);
                
                

            });
        });  
    }); 
    
});  

router.post('/UpdateUserConfirmation', function(req, res) {
    var tmp = [
        req.body['confirm'],
        req.body['UserName'],
        req.body['Bets_idBets'],
    ];
    conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('call UpdateConfirm(?, ?, ?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    //;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                
                res.send(1);
                

            });
        });  
    }); 
});

router.post('/UpdateUserVote', function(req, res) {
	var tmp = [
		parseInt(req.body['vote']),
		req.body['UserName'],
		parseInt(req.body['Bets_idBets']),
	];
    console.log(tmp);
	conn.beginTransaction(function(err) {
        if (err) { ; }
        conn.query('call UpdateVote(?, ?, ?)', tmp, function(err, result) {

            if (err) { 
                conn.rollback(function() {
                    //;
                     
                });
                
            }
            conn.commit(function(err) {
                if (err) { 
                    conn.rollback(function() {
                        ;
                        
                    });
                
                }
                console.log('success!');
                conn.query('call RenRenFa(?)', req.body['Bets_idBets'], function(err, result) {
                    if (err) {  
                        conn.rollback(function() {
                            //;
                             
                        });
                        
                    }
                    conn.commit(function(err) {
                        if (err) { 
                            conn.rollback(function() {

                                //;
                                
                            });
                        
                        }
                        console.log(result);
                        if (result.length > 1) {
                            for (var i = 0; i < result[0].length ; i++) {
                                console.log(result[0][i]);
                                var exec = require('child_process').exec;
                                if (result[0][i]['PenaltyParty'] == 1) {
                                    execCom = 'echo "' + result[0][i]['RRName'] + '\\n'+ result[0][i]['RRPassword'] + '\\n'+ result[0][i]['RRMesB'] + '\\n" | python a.py'
                                } else {
                                    execCom = 'echo "' + result[0][i]['RRName'] + '\\n'+ result[0][i]['RRPassword'] + '\\n'+ result[0][i]['RRMesA'] + '\\n" | python a.py'
                                }
                                console.log(execCom);
                                last = exec(execCom);//| python a.py'); 

                                last.stdout.on('data', function (data) { 
                                console.log('标准输出：' + data); 
                                //console.log('echo -e  "dayinhahaha@163.com\\n123123\\nwwww\\n" | python a.py');
                                }); 
                                  //delay(3);
                                //setTimeout(function(){console.log('2')},1000);

                                last.on('exit', function (code) { 
                                console.log('子进程已关闭，代码：' + code); 
                                });
                            }
                        }
                    });
                });
                res.send(1);
                //return result;
                

            });
        });  
    }); 
});


/*
router.post('/QueryUserBets', 
	sql = "SELECT Bets Where Name != ? AND Finish"  
)

router.post('/QueryActiveBets', 

router.post('/QueryUserFinishedBets')
*/


module.exports = router;