
var http = require('http');
var crypto = require('crypto');//引入加密模块





var user = {
    name : "testUser2",
    password:"1",
    rrname:"",
    rrpassword:""
};


//var userJson=JSON.stringify(user);
//varuserString='data='+userjson;//这种格式在服务器端解析的时候可解析为req.body.datda
var userString = JSON.stringify(user);//转换为json字符格式,在服务器端直接解析req.body
var headers = {
    'Content-Type': 'application/json',
    //如果使用的是varuserString='data='+userjson格式应将'Content-Type':设为'application/x-www-form-urlencoded'//form表单格式
    'Content-Length': userString.length
};

var options = {
    host: 'localhost',//'162.105.74.252',//主机：切记不可在前面加上HTTP://
    port: 8888,//端口号
    path: '/CreateUser',//路径
    method: 'POST',//提交方式
    headers: headers
};

var body = "";
var req = http.request(options, function (res) {
//    console.log('STATUS: ' + res.statusCode);
//    console.log('HEADERS: ' + JSON.stringify(res.headers));
    //  res.setEncoding('utf8');
    res.on('data', function (data) {
        body+=data;
        //console.log('response : ' ,message);
        //var ret= eval('(' + message + ')');
    });
    res.on('end', function () { console.log(body) });  

});


// write data to request body
req.write(userString);//向req.body里写入数据
req.end();
