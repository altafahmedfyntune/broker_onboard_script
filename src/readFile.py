import json


def config(config_name):
    try:
        # Opening JSON file
        f = open('/var/www/html/broker_onboard_script/src/config.json')

        # returns JSON object as
        # a dictionary
        data = json.load(f)

        # Iterating through the json
        # list
        return data[config_name]
    except FileNotFoundError:
        print("Config file not found")
