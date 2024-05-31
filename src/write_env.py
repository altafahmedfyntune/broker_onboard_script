import os
import re

from run_command import run_command


import mysql.connector
def import_sql_dump(host, username, password, database_name, dump_file):
    try:
        # Connect to the MySQL database
        conn = mysql.connector.connect(
            host=host,
            user=username,
            password=password,
            database=database_name
        )
        cursor = conn.cursor()

        # Read the SQL dump file with UTF-8 encoding
        with open(dump_file, 'r', encoding='utf-8') as f:
            sql_commands = f.read()

        # Split SQL commands by semicolons and execute each command
        for command in sql_commands.split(';'):
            command = command.strip()  # Remove leading/trailing whitespace
            if command:  # Check if the command is not empty
                print(f"Executing command: {command}")  # Add this line for debugging
                cursor.execute(command)
        # Commit the transaction
        conn.commit()
        conn.close()
        print(f"SQL dump imported successfully in {database_name} DB .")

    except mysql.connector.Error as e:
        print(f"Error importing SQL dump: {e}")
                                                            

def read_file_content(file_path):
    with open(file_path, 'r') as file:
        return file.read()


def setup_frontend(original_file_path, new_file_path, new_api_base_url):
    os.chdir('motor_2.0_frontend')
    print('Current DIR : ' + os.getcwd())
    # Read the content from the original file
    env_content = read_file_content('../' + original_file_path)

    # Split the content into lines
    lines = env_content.split('\n')

    # Open the new file for writing
    with open(new_file_path, 'w') as env_file:
        for line in lines:
            if line.startswith('REACT_APP_API_BASE_URL'):
                # Replace the URL in the REACT_APP_API_BASE_URL line
                env_file.write(f"REACT_APP_API_BASE_URL={new_api_base_url}\n")
            else:
                # Write the line as it is
                env_file.write(line + '\n')

    print(f".env file created and updated with new API base URL: {new_api_base_url}")
    run_command('npm i')
    run_command('npm install --force')
    os.chdir('../')
    print('Current DIR : ' + os.getcwd())


def setup_backend(original_file_path, new_file_path, replacements):
    os.chdir('motor_2.0_backend')
    print('Current DIR : ' + os.getcwd())
    # Read the content from the original file
    env_content = read_file_content('../'+original_file_path)

    # Split the content into lines
    lines = env_content.split('\n')

    # Open the new file for writing
    with open(new_file_path, 'w') as env_file:
        for line in lines:
            key = line.split('=')[0] if '=' in line else line

            # Replace specific keys based on the provided dictionary
            if key == 'APP_NAME':
                env_file.write(f"APP_NAME={replacements['app_name']}\n")
            elif key == 'APP_ENV':
                env_file.write(f"APP_ENV={replacements['environment']}\n")
            elif key == 'APP_URL':
                env_file.write(f"APP_URL={replacements['backend_url']}\n")
            elif key == 'APP_FRONTEND_URL':
                env_file.write(f"APP_FRONTEND_URL={replacements['frontend_url']}\n")
            elif key == 'DB_HOST':
                env_file.write(f"DB_HOST={replacements['db_host']}\n")
            elif key == 'DB_PORT':
                env_file.write(f"DB_PORT={replacements['db_post']}\n")
            elif key == 'DB_DATABASE':
                env_file.write(f"DB_DATABASE={replacements['db_name']}\n")
            elif key == 'DB_USERNAME':
                env_file.write(f"DB_USERNAME={replacements['db_username']}\n")
            elif key == 'DB_PASSWORD':
                env_file.write(f"DB_PASSWORD={replacements['db_password']}\n")
            else:
                # Write the line as it is
                env_file.write(line + '\n')

    print(f".env file created and updated with provided replacements")
    run_command('composer install')
    run_command('php artisan migrate')
    run_command('php artisan db:seed')
    run_command('php artisan key:generate')
    os.chdir('../')
    print('Current DIR : ' + os.getcwd())


def setup_ckyc(original_file_path, new_file_path, replacements):
    os.chdir('ckyc-api')
    print('Current DIR : ' + os.getcwd())
    # Read the content from the original file
    env_content = read_file_content('../'+original_file_path)

    # Split the content into lines
    lines = env_content.split('\n')

    # Open the new file for writing
    with open(new_file_path, 'w') as env_file:
        for line in lines:
            key = line.split('=')[0] if '=' in line else line

            # Replace specific keys based on the provided dictionary
            if key == 'APP_NAME':
                env_file.write(f"APP_NAME={replacements['app_name']}\n")
            elif key == 'APP_ENV':
                env_file.write(f"APP_ENV={replacements['environment']}\n")
            elif key == 'APP_URL':
                env_file.write(f"APP_URL={replacements['backend_url']}\n")
            elif key == 'DB_HOST':
                env_file.write(f"DB_HOST={replacements['db_host']}\n")
            elif key == 'DB_PORT':
                env_file.write(f"DB_PORT={replacements['db_post']}\n")
            elif key == 'DB_DATABASE':
                env_file.write(f"DB_DATABASE={replacements['db_name']}\n")
            elif key == 'DB_USERNAME':
                env_file.write(f"DB_USERNAME={replacements['db_username']}\n")
            elif key == 'DB_PASSWORD':
                env_file.write(f"DB_PASSWORD={replacements['db_password']}\n")
            else:
                # Write the line as it is
                env_file.write(line + '\n')

    print(f".env file created and updated with provided replacements")
    # run_command('composer install')
    # run_command('php artisan migrate')
    # run_command('php artisan db:seed')
    # run_command('php artisan key:generate')
    os.chdir('../')
    print('Current DIR : ' + os.getcwd())


def create_virtual_host_config(original_file_path, new_file_path, server_name):
    os.chdir('var/www/html/broker_onboard_script/src/')
    print(os.getcwd())
    print('hi1')
    # Read the content from the original file
    config_content = read_file_content(original_file_path)
    print('hi2')
    os.chdir('/etc/nginx/sites-enabled/')
    print(os.getcwd())

    # Define regular expressions for ServerName and ServerAlias
    server_name_pattern = re.compile(r'(ServerName\s+)(\S+)')
    server_alias_pattern = re.compile(r'(ServerAlias\s+)(\S+)')

    # Replace the ServerName and ServerAlias with the dynamic value
    updated_content = server_name_pattern.sub(r'\1' + server_name, config_content)
    updated_content = server_alias_pattern.sub(r'\1*.' + server_name, updated_content)

    # Write the updated content to the new file
    with open(new_file_path, 'w') as config_file:
        config_file.write(updated_content)
