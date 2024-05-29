import subprocess


def install_mysql():
    try:
        # Execute the apt-get command to install MySQL Server
        subprocess.run(["sudo", "apt-get", "update"])
        subprocess.run(["sudo", "apt-get", "install", "mysql-server"])
        print("MySQL installed successfully.")
    except Exception as e:
        print(f"Error installing MySQL: {e}")


def update_apt():
    try:
        print("Updating APT.....")
        subprocess.run(["sudo", "apt-get", "update"])
        print("APT updated successfully.")
    except Exception as e:
        print(f"Error updating apt: {e}")
