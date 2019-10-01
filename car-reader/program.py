import obd
import time
import options
import data.connection
from measurements.sprints import measureSprint

# Set true if not connected to car
running = False

# Enable all debug information
obd.logger.setLevel(obd.logging.DEBUG)

# Connect to elm327 plug
connection = obd.OBD() # auto-connects to USB or RF port

# Stop logging after connection made
obd.logger.removeHandler(obd.console_handler)

if connection.is_connected:
    running = True
elif options.mockMode == True:
    running = True

# Post request just for testing :)
print(data.connection.post('/saveSprints', {}))

while running == True:
    time.sleep( .8 )
    nullToHundred = measureSprint(connection)