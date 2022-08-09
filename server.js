const http = require("http");
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'test'
});





http.createServer(function(request, response){
     
    
connection.query( 
  'Delete from company where id=2',
  function(err, results, fields) {
response.end(err.sqlState);
  }
);
}).listen(3000);