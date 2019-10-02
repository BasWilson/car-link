import obd
import time
from options import mockMode
from connection import post
from sprints import measureSprint
import drive

# Set true if not connected to car
running = False

# Enable all debug information
obd.logger.setLevel(obd.logging.DEBUG)

connection = None

# Connect to elm327 plug
try:
    connection = obd.OBD() # auto-connects to USB or RF port
except:
    print("Could not connect to ELM327 plug")

# Stop logging after connection made
obd.logger.removeHandler(obd.console_handler)

if connection != None and connection.is_connected() == True:
    running = True
elif mockMode == True:
    print("Running in MOCK MODE")
    running = True

drive.startDrive()

while running == True:
    time.sleep( .8 )
    nullToHundred = measureSprint(connection)