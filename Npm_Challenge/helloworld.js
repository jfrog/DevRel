const http = require('http');
const fs = require('fs');

http.createServer(function (req, res) {
 if(req.url === "/index.html" || req.url === "/"){
  fs.readFile('index.html', function(err, data) {
     res.writeHead(200, {'Content-Type': 'text/html'});
     res.write(data);
     res.end();
   });
 } else if(req.url === "/style.css"){
   fs.readFile('style.css', function(err, data) {
     res.writeHead(200, {'Content-Type': 'text/css'});
     res.write(data);
     res.end();
   });
 }
}).listen(1337);

