const express = require('express');
const api = require('./routers/api');
const app = express();
const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost:27017/car-link', {useNewUrlParser: true});

app.use(express.json());

// Load the routers into the express app
app.use('/api', api);

// 404 Page
app.get('*', function (req, res) {
    res.send('Oopsie floopsie woopsie, this page no existoe.');
});

app.listen(3000, () => console.log(`car-link server running`));