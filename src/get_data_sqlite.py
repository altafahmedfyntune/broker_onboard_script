import sqlite3

def fetch_data_from_db(database_path, query):
    # Connect to the SQLite database
    conn = sqlite3.connect(database_path)
    cursor = conn.cursor()

    # Execute the query
    cursor.execute(query)
    
    # Fetch all rows
    rows = cursor.fetchall()
    
    # Get the column names
    column_names = [description[0] for description in cursor.description]
    
    # Convert rows to a list of dictionaries
    data_as_objects = [dict(zip(column_names, row)) for row in rows]
    
    # Close the connection
    conn.close()
    
    return data_as_objects

# Specify the path to your SQLite database
# database_path = 'setupDB.db'
# # Specify the query to fetch data
# query = "select * from server_master;"
# # query = "SELECT name FROM sqlite_master WHERE type='table';"
# # Fetch data from the database
# data_as_objects = fetch_data_from_db(database_path, query)
# print(data_as_objects)
