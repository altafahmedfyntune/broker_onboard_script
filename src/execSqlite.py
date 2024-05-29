# import sqlite3
#
#
# def create_tables(database,sql_file):
#     # Connect to SQLite database
#     conn = sqlite3.connect(database)
#     cursor = conn.cursor()
#
#     # Read SQL commands from file and split by semicolon
#     with open(sql_file, 'r') as f:
#         sql_commands = f.read().split(';')
#
#     # Execute each SQL command
#     for command in sql_commands:
#         command = command.strip()
#         if command:
#             try:
#                 cursor.execute(command)
#             except sqlite3.Error as e:
#                 print(f"An error occurred: {e}")
#                 print(f"Command causing the error: {command}")
#
#     # Commit changes and close connection
#     conn.commit()
#     conn.close()
#     print('Tables Created.')

import sqlite3


def create_tables(database, sql_file):
    print('Creating Tables')
    # Connect to SQLite database
    conn = sqlite3.connect(database)
    cursor = conn.cursor()

    # Read SQL commands from file
    with open(sql_file, 'r') as f:
        sql_script = f.read()

    # Split SQL commands by semicolon
    sql_commands = sql_script.split(';')

    # Execute each SQL command
    for command in sql_commands:
        command = command.strip()
        if command:
            try:
                cursor.execute(command)
            except sqlite3.Error as e:
                print(f"An error occurred: {e}")
                print(f"Command causing the error: {command}")

    # Commit changes and close connection
    conn.commit()
    conn.close()
    print('Tables Created.')


def execute_sql_script(database_path, sql_script_file):
    # Connect to the SQLite database
    conn = sqlite3.connect(database_path)
    cursor = conn.cursor()

    with open(sql_script_file, 'r') as f:
        sql_commands = f.read().split(';')

    for command in sql_commands:
        command = command.strip()
        if command:
            try:
                cursor.execute(command)
            except sqlite3.IntegrityError as e:
                print(f"Skipping command due to integrity error: {e}")
            except sqlite3.Error as e:
                print(f"Skipping command due to error: {e}")


    # Commit the transaction and close the connection
    conn.commit()
    conn.close()
    print("Script executed successfully.")


# # Specify the path to your SQLite database
# database_path = 'setupDB.db'
#
# # Specify the path to your SQL script file
# sql_script_file = 'createTables.sql'
#
# # Execute the SQL script
# execute_sql_script(database_path, sql_script_file)
