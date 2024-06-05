import os
import re
import sqlite3
import subprocess


def update_apt():
    try:
        print("----------Updating APT----------")
        subprocess.run(["sudo", "apt-get", "update"])
        print("----------APT updated successfully----------")
    except Exception as e:
        print(f"Error updating apt: {e}")


def install_sqlite():
    try:
        print("----------Installing SQLite----------")
        subprocess.run(["sudo", "apt", "install", "sqlite3"])
        print("----------SQlite Installed----------")
    except Exception as e:
        print(f"Error Installing SQLite ': {e}")


def install_pip():
    try:
        print("----------Installing PIP----------")
        subprocess.run(["sudo", "apt", "install", "python3-pip"])
        print("----------PIP Installed----------")
    except Exception as e:
        print(f"Error Installing PIP ': {e}")


def pip_request():
    try:
        print("----------Installing Request Library----------")
        subprocess.run(["pip", "install", "requests"])
        print("----------Request Library Installed----------")
    except Exception as e:
        print(f"Error Installing Re ': {e}")


def pip_mysql():
    try:
        print("----------Installing MySQL Library----------")
        subprocess.run(["pip", "install", "mysql-connector-python"])
        print("----------MySQL Installed----------")
    except Exception as e:
        print(f"Error Installing Re ': {e}")


def create_table(database_name, table_name):
    # Create table in MySQL
    create_query = f"CREATE TABLE {database_name}.{table_name} (first_name VARCHAR(50), last_name VARCHAR(50), age INT);"
    subprocess.run(['sudo', 'mysql', '-e', create_query])


def insert_data(database_name, table_name, data):
    # Insert data into MySQL table
    insert_query = f"INSERT INTO {database_name}.{table_name} VALUES {data};"
    subprocess.run(['sudo', 'mysql', '-e', insert_query])


def create_sqlite_db(db_name):
    try:
        # Construct the file path for the SQLite database
        db_file = f"{db_name}.db"

        # Check if the database file already exists
        if os.path.exists(db_file):
            os.remove(db_file)
            print(f"Database '{db_name}' removed.")

        # Connect to SQLite database or create it if it doesn't exist
        conn = sqlite3.connect(db_file)
        conn.close()
        print(f"SQLite database '{db_name}' created successfully.")
    except sqlite3.Error as e:
        print(f"Error creating SQLite database: {e}")


def create_and_populate_database1(db_path, sql_script):
    # Connect to the database (it will be created if it does not exist)
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Execute the SQL script
    try:
        sql_commands = sql_script.split(';')
        for command in sql_commands:
            command = command.strip()
            if command:
                try:
                    cursor.execute(command)
                except sqlite3.Error as e:
                    print(f"An error occurred: {e}")
                    print(f"Command causing the error: {command}")
        conn.commit()
        conn.close()
        print(f"Database created and tables populated successfully at {db_path}")
    except sqlite3.Error as e:
        print(f"An error occurred: {e}")


def create_and_populate_database(db_path, sql_script):
    # Connect to the database (it will be created if it does not exist)
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Execute the SQL script
    try:
        sql_commands = sql_script.split(';')
        for command in sql_commands:
            command = command.strip()
            if command:
                try:
                    cursor.execute(command)
                except sqlite3.IntegrityError as e:
                    print(f"Skipping command due to integrity error: {e}")
                except sqlite3.Error as e:
                    print(f"Skipping command due to error: {e}")
        conn.commit()
        conn.close()
        print(f"Tables populated successfully at {db_path}")
    except sqlite3.Error as e:
        print(f"An error occurred: {e}")


def read_sql_file(file_path):
    with open(file_path, 'r') as file:
        sql_script = file.read()
    return sql_script


def write_sql_file(file_path, content):
    with open(file_path, 'w') as file:
        file.write(content)


def modify_sql_for_sqlite(sql_script):
    # Convert bigint to INTEGER
    sql_script = re.sub(r'\bbigint\b', 'INTEGER', sql_script, flags=re.IGNORECASE)

    # Convert unsigned to nothing (SQLite does not support unsigned)
    sql_script = re.sub(r'\bunsigned\b', '', sql_script, flags=re.IGNORECASE)

    # Convert varchar to TEXT
    sql_script = re.sub(r'\b(varchar|varchar\(\d+\))\b', 'TEXT', sql_script, flags=re.IGNORECASE)

    # Convert enum to CHECK constraint
    sql_script = re.sub(r"enum\(([^)]+)\)", lambda m: "TEXT CHECK(value IN (" + m.group(1) + "))", sql_script,
                        flags=re.IGNORECASE)

    # Replace backticks with double quotes (optional, for SQLite compatibility)
    sql_script = sql_script.replace('`', '"')

    # Replace AUTO_INCREMENT with AUTOINCREMENT
    sql_script = re.sub(r'\bAUTO_INCREMENT\b', 'AUTOINCREMENT', sql_script, flags=re.IGNORECASE)

    return sql_script


def run_command(command):
    try:
        command_array = command.split()
        subprocess.run(command_array)
    except Exception as e:
        print(f"Error Running Command ': {e}")


