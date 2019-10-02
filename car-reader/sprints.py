import obd
import drive
from options import mockMode
from options import maxSprintTime
from datetime import datetime

# The timestamp of when the car is doing 0kph
zeroTime = 0

# The speed command
cmd = obd.commands['SPEED']

mockspeed = 0

times = []
currentTime = {}

# Measures 0 to 100 sprints made with the car
def measureSprint(connection):

    global mockspeed
    global zeroTime
    global times
    global currentTime

    # time it took 0 - 100
    nullToHundred = 0

    # Keeps track of speed
    speed = 0
    
    if mockMode == False:
        # Run the query
        response = connection.query(cmd)

        # turn the query response into a float
        speed = float(response.value)  
    else:
        speed = mockspeed
        mockspeed += 10

    # Add the current speed to the dictionary with as key the current timestmap
    if speed > 0:

        # If no times added to current time, it means we can add the zeroTime to it.
        if len(currentTime) == 0:
            currentTime[str(zeroTime * 1000).replace('.', '')] = 0

        # Add the time for the current speed
        currentTime[str(datetime.timestamp(datetime.now()) * 1000).replace('.', '')] = speed

    # if speed is 0, save the timestamp.
    if speed == 0:
        zeroTime = datetime.timestamp(datetime.now())


    # When speed is 100 or more and the zerotime has been set, save the timestamp
    if speed == 100 and zeroTime != 0:
        # determine differnce in time between the two timestamps
        nullToHundred = datetime.timestamp(datetime.now()) - zeroTime
        print(nullToHundred)
        if nullToHundred < maxSprintTime:
            # save the current time to times list if bigger than set option
            times.append(currentTime.copy())

        # Reset currenttime and zerotime
        currentTime = {}
        zeroTime = 0


        if mockMode:
            mockspeed = 0

        drive.endDrive()

    return nullToHundred
