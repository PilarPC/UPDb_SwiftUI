//guardar artículas
var https = require('https');
const request = require('request');
var fs = require('fs');
var express = require('express');
var ip = require("ip"); 
var app = express();
var bodyParser = require('body-parser');
const { off } = require('process');
var jSONBodyParser =  bodyParser.json();



var j1 = {
     titulo:"Batman",
     year:2022,
     imageId:"https://i0.wp.com/cinemedios.com/wp-content/uploads/2021/10/fecha-estreno-the-batman-mexico.jpg?fit=1024%2C637&ssl=1"
 }
 var j2 = {
     titulo:"Harry Potter y la piedra filosofal",
     year:2001,
     imageId:"https://i0.wp.com/cineyvaloressj.com/wp-content/uploads/2020/08/42100525172832813e301be5faadbbf1.jpg?fit=1077%2C1481&ssl=1"
 }
 var j3 = {
     titulo:"Birts Of Prey",
     year:2020,
     imageId:"https://static.wikia.nocookie.net/batman/images/7/77/BOP_poster_05.png/revision/latest?cb=20191206190029&path-prefix=es"
 }
 var j4 = {
     titulo:"Now You See Me 2",
     year:2016,
     imageId:"https://images-na.ssl-images-amazon.com/images/S/pv-target-images/a7706451b933e4aa354d43f877de6779ad55fee4b88d44ff9efb089ee19d3cd9._RI_V_TTW_.jpg"
 }
 var j5 = {
     titulo:"Onward",
     year:2022,
     imageId:"https://lumiere-a.akamaihd.net/v1/images/p_onward_19732_09862641.jpeg"
 }
 var j6 = {
     titulo:"Mulan",
     year:2020,
     imageId:"https://static.wikia.nocookie.net/disney/images/e/e9/Mulan_%282020%2C_Disney%2B_Original_Poster%29.jpg/revision/latest?cb=20200919141917&path-prefix=es"
 }
 var j7 = {
     titulo:"No time to die",
     year:2021,
     imageId:"https://play-lh.googleusercontent.com/NBMxeiuxDsMNTNqj6gIVwaYW4dvxzUq_aEE7RUB4a_LE7ZmpSFHAOW3uQGRfjzB2fyt_c4IMPC3Ly8yR0gM"
 }
 
 
 
 
 
 
 
 
 
 var peliculas = ["Batman","Harry Potter y la piedra filosofal", "Birts Of Prey", "Now You See Me 2", "Onward","Mulan","No time to die"];
 var agregados = [];
 var listaDisponible = [j1,j2,j3,j4,j5,j6,j7];
 var usuarios = [];
 







app.use(express.static(__dirname + '/www'));


request("https://reqbin.com/echo/get/json", { json: true }, (err, res, body) => {
  if (err) { return console.log(err); }
  console.log(res.url);
  console.log(peliculas);
  
});


app.get('/articulos', function (req, res) {
     res.end(JSON.stringify(agregados))
});



app.post('/agregarArticulo',jSONBodyParser,function(req,res)
{    

     /*for(var i = 0; i < peliculas.length; i++)
     {
          if(req.body == peliculas[i])
          {
               agregados.push(req.body);
               console.table(agregados);
                  
               break;
          }
          else{
               res.status(409).json({mensaje:"La película no está en nuestro catalogo"})
          }
     }*/

     agregados.push(req.body);
     console.table(agregados);
     res.end("Agregado");
     //console.log(agregados);
   
});

app.post('/agregarUsuario',jSONBodyParser,function(req,res)
{    

     usuarios.push(req.body);
     console.table(usuarios);
     res.end("Agregado");
   
});



console.dir ( ip.address() );
//var server = https.createServer(options, app).listen(8443);
app.listen(8080,()=>{console.log("Corriendo...")})