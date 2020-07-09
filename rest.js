var express = require("express")
var bodyParser = require('body-parser');
var mysql = require("mysql")

path = require('path');
var app = express()
// parse application/x-www-form-urlencoded
app.use(bodyParser.json());
const accountSid = "AC4b67fb5b64d06f7c01b52fd8ad95bd86";
const authToken = 'b0b2ca7bdd50124a87ae5385cf62b5b0';
const client = require('twilio')(accountSid, authToken);
//database connection
var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database:'remediumapp',
    port:3308
});




// Get Patient account
app.get('/getPatient/:tel/:pass',function(req,res){ 
    var query = "select * from Patient where telp = '"+ req.params.tel + "' and pwdp ='" + req.params.pass +"'"; 
   connection.query(query,function(error,results){
    
    if (error) throw error;
    res.send(results[0]);
})
});
app.get('/gettest',function(req,res){ 
    var query = "select * from Patient "; 
   connection.query(query,function(error,results){
    
    if (error) throw error;
    res.send(results);
})
});
// Get Doctor account
app.get('/getDoc/:tel/:pass',function(req,res){ 
    var query = "select * from Medcin where teld = '"+ req.params.tel + "' and pwdd ='" + req.params.pass +"'"; 
   connection.query(query,function(error,results){
    
    if (error) throw error;
    res.send(results[0]);
})
});

// insert patient
app.post('/addPatient',function(req,res){  
    var patient = JSON.parse(JSON.stringify(req.body));
    console.log(req.body)
    var query = "INSERT INTO patient(nssp,nomp,prenomp,adrp,telp,pwdp,firstCon) values (?,?,?,?,?,?,?)"; 
   connection.query(query,[patient.nssp,patient.nomp,patient.prenomp,patient.adrp,patient.telp,patient.pwdp,patient.firstCon],
    function(error,results){
        
    if (error) throw error;
    
    res.send(JSON.stringify("sucess"));
})
});

// Send SMS : 
// require the Twilio module and create a REST client
app.post('/sendSMS',function(req,res){
    var password= req.body.pwdp;
    var num = req.body.telp;
    client.messages.create({
        to: num,
        from: '+12488262974',
        body: "Votre mot de passe est = "+ password,
      },function(err,message) {
        if(err){
          console.error(err.message);
          //res.send("err");
          res.send(JSON.stringify("err.message"));
        }
        else{
          console.log(message.body);
        //  res.send("success");
          res.send(JSON.stringify("message.body)"));
        }
      });
  });
// insert doctor
app.post('/addDoc',function(req,res){  
    var doc = JSON.parse(JSON.stringify(req.body));
    console.log(req.body)
    var query = "INSERT INTO medcin(nssd,nomd,prenomd,adrd,teld,pwdd,openh,closeh,speciality,commune,gpslink) values (?,?,?,?,?,?,?,?,?,?,?)"; 
   connection.query(query,[doc.nss,doc.nom,doc.prenom,doc.adr,doc.tel,doc.pwd,doc.open,doc.close,doc.speciality,doc.comm,doc.gps],
    function(error,results){
        
    if (error) throw error;
    
    res.send(success);
})
});
// update password 
app.post('/updatepass',function(req,res){
    var patient = req.body;
 
    var query = "UPDATE patient SET pwdp=?,firstCon=? WHERE nssp=?";
    connection.query(query,[patient.pwdp,patient.firstCon,patient.nssp],function(error,results){
     if (error) {
       res.send(JSON.stringify("error"));
     }
     else{
       res.send(JSON.stringify("sucess"));
     }
 })
});
//Find Doctor By comm 
app.get('/getMedcinComm/:comm',function(req,res){ 
    var query = "select * from medcin where commune = '"+ req.params.comm + "'"  ;
   connection.query(query,function(error,results){
    
    if (error) throw error;
    
    res.send(JSON.stringify(results));
})
});
//Find Doctor By speciality 
app.get('/getMedcinSpec/:spec',function(req,res){ 
    var query = "select * from medcin where speciality = '"+ req.params.spec + "'"  ;
   connection.query(query,function(error,results){
    
    if (error) throw error;
    
    res.send(JSON.stringify(results));
})
});
//Find Doctor By speciality and comm 
app.get('/getMedcin/:spec/:comm',function(req,res){ 
    var query = "select * from medcin where speciality = '"+ req.params.spec + "' and commune ='" + req.params.comm +"'"; 
   connection.query(query,function(error,results){
    
    if (error) throw error;
    
    res.send(JSON.stringify(results));
})
});
//Insert invitation 
app.post('/insertInv',function(req,res){  
  var inv = JSON.parse(JSON.stringify(req.body));
  console.log(req.body)
  var query = "INSERT INTO invitation(accepted,id_pa,id_doc,nomp,prenomp,adrp,nomd,prenomd,adrd) values (?,?,?,?,?,?,?,?,?)"; 
 connection.query(query,[inv.accepted,inv.id_pa,inv.id_doc,inv.nomp,inv.prenomp,inv.adrp,inv.nomd,inv.prenomd,inv.adrd],
  function(error,results){
      
  if (error) throw error;
  
  res.send(JSON.stringify("sucess"));
})
});
// Find invitation 
app.get('/getInv/:idMedcin',function(req,res){ 
  var query = "select * from invitation where accepted = '"+ 0 + "' and id_doc ='" + req.params.idMedcin +"'"; 
 connection.query(query,function(error,results){
  if (error) throw error;
  res.send(JSON.stringify(results));
})
});
//Get Patient by ID
app.get('/getPatientByID/:idP',function(req,res){ 
  var query = "select * from patient where nssp = '" + req.params.idP +"'"; 
 connection.query(query,function(error,results){
  if (error) throw error;
  res.send(JSON.stringify(results[0]));
})
});
// Accpet invitation
app.post('/acceptInv',function(req,res){
    var invitation = req.body;
    console.log(invitation)
    var query = "UPDATE invitation SET accepted=? WHERE id_invitation=?";
    connection.query(query,[invitation.accepted,invitation.id_invitation],function(error,results){
     if (error) {
       res.send(JSON.stringify("error"));
     }
     else{
       res.send(JSON.stringify("sucess"));
     }
 })
});
// Delete invitation
app.post('/deleteInv',function(req,res){
    var invitation = req.body;
    console.log(invitation)
    var query = "delete from invitation where id_invitation=?";
    connection.query(query,[invitation.id_invitation],function(error,results){
     if (error) {
       res.send(JSON.stringify("error"));
     }
     else{
       res.send(JSON.stringify("sucess"));
     }
 })
});
app.get('/findInv/:id_pa/:id_doc',function(req,res){ 
  var query = "select * from invitation where id_pa = '"+ req.params.id_pa + "' and id_doc ='" + req.params.id_doc +"'"; 
 connection.query(query,function(error,results){
  
  if (error) throw error;
  res.send(results[0]);
})
});
//medcins traitants
app.get('/finDocs/:id_pa',function(req,res){ 
  var query = "select * from invitation where accepted = '"+ 1 + "' and id_pa ='" + req.params.id_pa +"'"; 
 connection.query(query,function(error,results){
  
  if (error) throw error;
       res.send(JSON.stringify(results));
  
})
});
// server creation

var server = app.listen(8082,function(){
    var host = server.address().address
    var port = server.address().port
});