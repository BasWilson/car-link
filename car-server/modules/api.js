const lang = require('../modules/lang');
const err = require('../modules/errorHandler');
const Car = require('../models/car');
const Drive = require('../models/drive');
const User = require('../models/user');
const uuidv1 = require('uuid/v1');

// validation keys per function
const linkCarProperties = ['linkedUser', 'pinCode', 'username'];
const updateCarProperties = ['name', 'color', 'licensePlate', 'id', 'pinCode', 'username'];
const createUserProperties = ['username', 'pinCode'];
const authenticateProperties = ['username', 'pinCode'];
const saveDriveProperties = ['username', 'pinCode', 'sprints', 'driveStart', 'driveEnd']; // Car id, pinCode, sprints array

function createUser(body) {
    return new Promise(resolve => {

        try {
            let validationCount = createUserProperties.length;

            createUserProperties.forEach(key => {
                if (typeof body[key] === 'undefined')
                    validationCount--;
            });

            // Check if the user's input was valid
            if (validationCount != createUserProperties.length)
                return resolve(err('en', 'error_invalid_input'))

            const newUser = new User({
                id: uuidv1(),
                username: body['username'],
                pinCode: body['pinCode']
            });

            newUser.save().then(() => {
                return resolve(newUser);
            }).catch((error) => {
                return resolve(err('en', 'error_duplicate_user'))
            })

        } catch (error) {
            return resolve(err('en', 'error_unknown'))
        }

    });
}

function linkCar(body) {
    return new Promise(resolve => {

        try {
            let validationCount = linkCarProperties.length;

            linkCarProperties.forEach(key => {
                if (typeof body[key] === 'undefined')
                    validationCount--;
            });

            // Check if the user's input was valid
            if (validationCount != linkCarProperties.length)
                return resolve(err('en', 'error_invalid_input'))

            const newCar = new Car({
                id: uuidv1(),
                linkedUser: body['linkedUser'],
            });

            authenticate(body).then((authenticated) => {
                if (authenticated) {
                    newCar.save().then(() => {
                        return resolve(newCar);
                    }).catch((error) => {
                        return resolve(err('en', 'error_unknown'))
                    })
                } else {
                    return resolve(err('en', 'error_wrong_pincode'))
                }
            })


        } catch (error) {
            return resolve(err('en', 'error_unknown'))
        }

    });
}

function updateCar(body) {
    return new Promise(resolve => {

        try {
            let validationCount = updateCarProperties.length;

            updateCarProperties.forEach(key => {
                if (typeof body[key] === 'undefined')
                    validationCount--;
            });

            // Check if the user's input was valid
            if (validationCount != updateCarProperties.length)
                return resolve(err('en', 'error_invalid_input'))

            // Find the car by it's ID
            const update = { name: body['name'], color: body['color'], licensePlate: body['licensePlate'] };
            const query = { id: body['id'] };

            // Try to authenticate with given pincode and username
            authenticate(body).then((authenticated) => {

                if (authenticated) {
                    Car.updateOne(query, update).then((doc) => {
                        return resolve(true)
                    }).catch(() => {
                        return resolve(err('en', 'error_car_404'));
                    });
                } else {
                    return resolve(err('en', 'error_wrong_pincode'));
                }

            }).catch(() => {
                return resolve(err('en', 'error_wrong_pincode'));
            });


        } catch (error) {
            return resolve(err('en', 'error_unknown'));
        }

    });
}

function authenticate(body) {
    return new Promise(resolve => {

        try {
            let validationCount = authenticateProperties.length;

            authenticateProperties.forEach(key => {
                if (typeof body[key] === 'undefined')
                    validationCount--;
            });

            // Check if the user's input was valid
            if (validationCount != authenticateProperties.length)
                return resolve(false)

            // Find the car by it's ID
            User.findOne({ username: body['username'], pinCode: body['pinCode'] }).then((result) => {
                if (result.username == body['username'] && result.pinCode == body['pinCode'])
                    return resolve(true)
                else
                    return resolve(false);
            }).catch((err) => {
                return resolve(false);
            });

        } catch (error) {
            return resolve(false);
        }

    });
}

function saveDrive(body) {
    return new Promise(resolve => {

        try {
            let validationCount = saveDriveProperties.length;

            saveDriveProperties.forEach(key => {
                if (typeof body[key] === 'undefined')
                    validationCount--;
            });

            // Check if the user's input was valid
            if (validationCount != saveDriveProperties.length)
                return resolve(err('en', 'error_invalid_input'))

            const newDrive = new Drive({
                id: uuidv1(),
                linkedCar: body['linkedCar'],
                sprints: body['sprints'],
                driveStart: body['driveStart'],
                driveEnd: body['driveEnd'],
            });


            User.findOne({ username: body['username'] }).then((foundUser) => {
                Car.findOne({ linkedUser: foundUser.id }).then((foundCar) => {
                    if (foundCar) {
                        authenticate(body).then((authenticated) => {
                            if (authenticated) {
                                newDrive.save().then(() => {
                                    return resolve(newDrive);
                                }).catch((error) => {
                                    return resolve(err('en', 'error_unknown'))
                                })
                            } else {
                                return resolve(err('en', 'error_wrong_pincode'));
                            }
                        }).catch(() => {
                            return resolve(err('en', 'error_wrong_pincode'));
                        });
                    }
                });
            });



        } catch (error) {
            return resolve(err('en', 'error_unknown'))
        }

    });
}

module.exports = {
    linkCar: linkCar,
    createUser: createUser,
    updateCar: updateCar,
    saveDrive: saveDrive,
}