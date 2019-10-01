import requests
import json      
import options

def post(dest, data):

    status = False

    # Create new request with json data
    try:
        request = requests.post(options.carLinkUrl + dest, json={"data": data})

        # Check status code
        if request.status_code == 200:
            status = True
    # Catch errors
    except:
        status = False
    finally:
        return status


