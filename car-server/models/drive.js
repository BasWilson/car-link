const mongoose = require('mongoose');

const Drive = mongoose.model('Drive', {
    id: String,
    linkedCar: String,
    driveStart: String,
    driveEnd: String,
    sprints: Array
});

module.exports = Drive;