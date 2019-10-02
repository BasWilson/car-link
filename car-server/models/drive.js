const mongoose = require('mongoose');

const Drive = mongoose.model('Drive', {
    id: String,
    linkedCar: String,
    driveStart: Number,
    driveEnd: Number,
    sprints: Array
});

module.exports = Drive;