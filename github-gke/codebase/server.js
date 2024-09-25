'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';



// App

const app = express();
var morgan = require('morgan');


app.use(morgan('combined'));

app.get('/', function (req, res) {
  res.send('hello, world express');
});


// app.listen(PORT, HOST);

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
