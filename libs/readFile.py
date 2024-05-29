import json


def config(config_name):
    try:
        # Opening JSON file
        f = open('../config.json')

        # returns JSON object as
        # a dictionary
        data = json.load(f)

        # Iterating through the json
        # list
        return data[config_name]


    except FileNotFoundError:
        print("Config file not found")
    finally:
        # Closing file
        f.close()
