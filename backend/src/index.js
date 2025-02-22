const express = require('express');
const mysql = require('mysql');
const dotenv = require('dotenv');
const cors = require('cors');

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL');
});

// Endpoint de prueba
app.get('/api/test', (req, res) => {
  res.json({ message: 'Hello from the backend!' });
});

app.get('/', (req, res) => {
  res.send('Hello World from backend');
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
