const express = require('express');
const router = express.Router();
const api = require('../modules/api');

// define the home page route
router.get('/', function (req, res) {
    res.send('API is up and running');
});

router.post('/linkCar', function (req, res) {
    api.linkCar(req.body).then((result) => {
        console.log('Saved car:', result);
        if (!result.error)
            res.send(result);
        else
            res.sendStatus(500)
    });
});

router.post('/createUser', function (req, res) {
    api.createUser(req.body).then((result) => {
        console.log('Saved user:', result);
        if (!result.error)
            res.send(result);
        else
            res.sendStatus(500)
    });
});


router.post('/updateCar', function (req, res) {
    api.updateCar(req.body).then((result) => {
        console.log('Updated car:', result);
        if (!result.error)
            res.send(result);
        else
            res.sendStatus(500)
    });
});

router.post('/saveDrive', function (req, res) {
    api.saveDrive(req.body).then((result) => {
        console.log('Saved drive:', result);
        if (!result.error)
            res.send(result);
        else
            res.sendStatus(500)
    });
});

module.exports = router;