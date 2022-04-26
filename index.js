const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Running');
})

app.get('/getenv', (req, res) => {
  res.send(JSON.stringify(process.env,2,null));
})

app.listen(process.env.PORT || 3000, () => {})
