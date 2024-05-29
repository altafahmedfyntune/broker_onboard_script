from pprint import pprint
import os

from readFile import config
from run_command import update_apt, pip_request, create_and_populate_database, create_sqlite_db, read_sql_file, \
    modify_sql_for_sqlite, write_sql_file, run_command, import_sql_dump, pip_mysql
from run_command import install_sqlite
from request import get_data, downloadFile, updateInstanceStatus
from execSqlite import create_tables, execute_sql_script
from get_data_sqlite import fetch_data_from_db
from write_env import setup_frontend, setup_backend, setup_ckyc, create_virtual_host_config

try:
    statusUpdated = updateInstanceStatus('started')
    if statusUpdated['status']:
        print(f'Status Updated as Started.')
    print("------Python Script for Broker Onboarding Started------")
    instance_id = config('instance_id')
    print("Instance ID : " + instance_id)
    update_apt()
    install_sqlite()
    pip_request()
    pip_mysql()
    print(config('app_url') + "exportSql")
    response = get_data(config('app_url') + "api/exportSql", {
        "domain_instance_id": "1"
    }).json()
    if response['status']:
        fileUrl = config('app_url') + response['file_name']
        print(fileUrl)
        dbDumpName = 'setupDb.sql'
        downloaded = downloadFile(fileUrl, dbDumpName)
    if downloaded:
        setupDbName = config('setup_db_name')
        create_sqlite_db(setupDbName)
        # execute_sql_script(setupDbName+'.db', 'createTables.sql') #create tables

        create_tables(setupDbName + ".db", 'createTables.sql')

        original_sql_script = read_sql_file(dbDumpName)
        # # modified_sql_script = modify_sql_for_sqlite(original_sql_script)
        # # write_sql_file(config('modified_setup_db_path'), modified_sql_script)
        create_and_populate_database(setupDbName + ".db", original_sql_script)

        # fetching data for frontend setup
        instance_data = fetch_data_from_db(setupDbName + '.db',
                                           'select * from domain_instances_creation where instance_creation_id = ' + instance_id + ';')
        api_base_url = instance_data[0]['backend_pos_url']
        broker_id = instance_data[0]['broker_id']
        pprint(instance_data)
        print("----------------------------------------------Broker ID : ", broker_id)
        # fetching data for backend setup
        broker_data = fetch_data_from_db(setupDbName + '.db',
                                         f'select * from broker_information where id = {broker_id};')
        broker_name = broker_data[0]['broker_name']
        environment_id = instance_data[0]['environment_id']
        print("----------------------------------------------Broker name : " + broker_name)
        environment = fetch_data_from_db(setupDbName + '.db',
                                         f'select * from enviroment_master where enviroment_id = {environment_id};')
        server_ids = instance_data[0]['server_id']
        print('----------------------Server IDS : ', server_ids)
        database = fetch_data_from_db(setupDbName + '.db',
                                      f'select * from server_master where server_id in ({server_ids}) and server_type = "Database";')
        pprint(database)

        backend_env = {}
        backend_env['app_name'] = broker_name + " Motor"
        backend_env['environment'] = environment[0]['enviroment_name']
        backend_env['frontend_url'] = instance_data[0]['frontend_pos_url']
        backend_env['backend_url'] = instance_data[0]['backend_pos_url']
        backend_env['db_host'] = database[0]['db_host']
        backend_env['db_post'] = database[0]['db_port']
        backend_env['db_name'] = database[0]['db_database']
        backend_env['db_username'] = database[0]['db_username']
        backend_env['db_password'] = database[0]['db_password']
        pprint(backend_env)
        env_file_name = '.env'  # The new .env file to be created
        os.chdir('/var/www/html/')
        run_command(
            'git clone https://github.com/Fyntune/motor_2.0_backend.git')
        setup_backend('backend_env.txt', env_file_name, backend_env)
        run_command(
            'git clone https://github.com/Fyntune/motor_2.0_frontend.git')

        original_file_path = 'frontend_env.txt'  # The file containing the original .env content
        setup_frontend(original_file_path, env_file_name, api_base_url)
        ckyc_env = {}
        ckyc_env['app_name'] = broker_name + " CKYC"
        ckyc_env['backend_url'] = instance_data[0]['backend_pos_url']
        ckyc_env['environment'] = environment[0]['enviroment_name']
        ckyc_env['db_host'] = database[0]['db_host']
        ckyc_env['db_post'] = database[0]['db_port']
        ckyc_env['db_name'] = 'ckyc-api'
        ckyc_env['db_username'] = database[0]['db_username']
        ckyc_env['db_password'] = database[0]['db_password']
        pprint(ckyc_env)
        run_command(
            'git clone https://github.com/Fyntune/ckyc-api.git')
        setup_ckyc('ckyc_env.txt', '.env', ckyc_env)
        import_sql_dump(database[0]['db_host'], database[0]['db_username'], database[0]['db_password'], 'motor_revamp',
                        'motor_revemp.sql')
        import_sql_dump(database[0]['db_host'], database[0]['db_username'], database[0]['db_password'], 'ckyc-api',
                        'ckyc_db.sql')
        create_virtual_host_config('motor_2.0_backend_config.txt', 'paytm.bfynity.in' + '.conf', 'paytm.fynity.in')
        create_virtual_host_config('motor_2.0_frontend_config.txt', 'paytm.ffynity.in' + '.conf', 'paytm.fynity.in')
        create_virtual_host_config('ckyc-api_config.txt', 'paytm.cfynity.in' + '.conf', 'paytm.fynity.in')
        run_command('sudo systemctl restart nginx')
        statusUpdated = updateInstanceStatus('completed')
        if statusUpdated['status']:
            print(f'Status Updated as Completed.')
except Exception as e:
    statusUpdated = updateInstanceStatus('failed')
    if statusUpdated['status']:
        print(f'Status Updated as Failed.')
    print(f"Error while Onboarding the Broker : {e}")
