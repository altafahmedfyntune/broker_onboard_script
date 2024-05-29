import requests


def get_data(url, payload = None):
    response = requests.post(url, payload)
    return response


def downloadFile(url, file_name):
    # Send a GET request to download the file
    response = requests.post(url)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Open the file in binary write mode and write the response content (file data) to it
        with open(file_name, 'wb') as file:
            file.write(response.content)
        print('Setup DB File downloaded successfully.')
        return True
    else:
        print('Failed to download the Setup DB file:', response.status_code)
        return False
