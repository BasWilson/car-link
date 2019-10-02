const mongoose = require('mongoose');

const Car = mongoose.model('Car', {
    id: String,
    linkedUser: String,
    name: String,
    color: String,
    licensePlate: String
});

module.exports = Car;