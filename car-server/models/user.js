const mongoose = require('mongoose');

const User = mongoose.model('User', {
    id: String,
    username: {
        type: String,
        index: true,
        unique: true
    },
    pinCode: String
});

module.exports = User;