from datetime import datetime
import json
import options
import sprints
import connection
from utils import secondsToMs

driveStart = 0
driveEnd = 0

def startDrive():

    global driveStart

    driveStart = secondsToMs(str(datetime.timestamp(datetime.now()) * 1000))
    print("Started drive")

def endDrive():

    global driveEnd

    driveEnd = secondsToMs(str(datetime.timestamp(datetime.now()) * 1000))

    saveDrive()
    

def saveDrive():

    data = {
        "driveStart": driveStart,
        "driveEnd": driveEnd,
        "username": options.carLinkUsername,
        "pinCode": options.carLinkPinCode,
        "sprints": sprints.times
    }

    saved = connection.post('/saveDrive', data)

    print('saved', saved)