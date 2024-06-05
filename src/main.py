from pprint import pprint
import os
import shutil
import traceback
from readFile import config
from request import get_data, downloadFile, updateInstanceStatus
from execSqlite import create_tables, execute_sql_script
from get_data_sqlite import fetch_data_from_db

try:
    script_path = '/var/www/html/broker_onboard_script/src/'
    statusUpdated = updateInstanceStatus('started')
    if statusUpdated['status']:
        print(f'Status Updated as Started.')
    print("------Python Script for Broker Onboarding Started------")
    instance_id = config('instance_id')
    print("############### Instance ID : " + instance_id + " ###############")
    from run_command import update_apt, install_sqlite,install_pip, pip_request, pip_mysql
    update_apt()
    install_sqlite()
    install_pip()
    pip_request()
    pip_mysql()
    from run_command import create_and_populate_database, create_sqlite_db, read_sql_file, \
            modify_sql_for_sqlite, write_sql_file, run_command
    from write_env import setup_frontend, setup_backend, setup_ckyc, create_virtual_host_config,import_sql_dump, modify_nginx_config
    print(config('app_url') + "api/exportSql")
    response = get_data(config('app_url') + "api/exportSql", {
        "domain_instance_id": config('instance_id')
    }).json()
    if response['status']:
        fileUrl = config('app_url') + response['file_name']
        print(fileUrl)
        dbDumpName = 'setupDb.sql'
        downloaded = downloadFile(fileUrl, dbDumpName)
    if downloaded:
        setupDbName = script_path+config('setup_db_name')
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
        domain_name = instance_data[0]['domain_name']
        api_base_url = instance_data[0]['backend_url']
        broker_id = instance_data[0]['broker_id']
        # pprint(instance_data)
        print("----------------------------------------------Broker ID : ", broker_id)
        # fetching data for backend setup
        broker_data = fetch_data_from_db(setupDbName + '.db',
                                         f'select * from broker_information where id = {broker_id};')
        broker_name = broker_data[0]['broker_name']
        environment_id = instance_data[0]['environment_id']
        print("----------------------------------------------Broker name : " + broker_name)
        environment = fetch_data_from_db(setupDbName + '.db',
                                         f'select * from enviroment_master where enviroment_id = {environment_id};')
        server_ids = instance_data[0]['be_server_id']
        print('----------------------Server IDS : ', server_ids)
        database = fetch_data_from_db(setupDbName + '.db',
                                      f'select * from server_master where server_id in ({server_ids}) and server_type = "Database";')
        # pprint(database)
        backend_db = database

        backend_env = {}
        backend_env['app_name'] = f'"{broker_name} Motor"'
        backend_env['environment'] = environment[0]['enviroment_name']
        backend_env['frontend_url'] = instance_data[0]['frontend_pos_url']
        backend_env['backend_url'] = instance_data[0]['backend_url']
        backend_env['db_host'] = database[0]['db_host']
        backend_env['db_post'] = database[0]['db_port']
        backend_env['db_name'] = database[0]['db_database']
        backend_env['db_username'] = database[0]['db_username']
        backend_env['db_password'] = database[0]['db_password']
        # pprint(backend_env)
        env_file_name = '.env'  # The new .env file to be created

        os.chdir('/var/www/html/')
        
        directory = domain_name
        if os.path.exists(directory):
            shutil.rmtree(directory)
            print(f"Directory '{directory}' removed.")
        os.mkdir(domain_name)
        print('Directory created : ' + domain_name)

        os.chdir('/var/www/html/'+domain_name)
        directory = 'motor_2.0_backend'
        if os.path.exists(directory):
            shutil.rmtree(directory)
            print(f"Directory '{directory}' removed.")
        directory = 'motor_2.0_frontend'
        if os.path.exists(directory):
            shutil.rmtree(directory)
            print(f"Directory '{directory}' removed.")
        directory = 'ckyc-api'
        if os.path.exists(directory):
            shutil.rmtree(directory)
            print(f"Directory '{directory}' removed.")
        server_ids = instance_data[0]['ckyc_server_id']
        print('----------------------Server IDS : ', server_ids)
        database = fetch_data_from_db(setupDbName + '.db',
                                      f'select * from server_master where server_id in ({server_ids}) and server_type = "Database";')
        # pprint(database)
        import_sql_dump(database[0]['db_host'], database[0]['db_username'], database[0]['db_password'], database[0]['db_database'],
                        script_path+'ckyc_db.sql')
        import_sql_dump(backend_db[0]['db_host'], backend_db[0]['db_username'], backend_db[0]['db_password'], backend_db[0]['db_database'],
                        script_path+'motor_revemp.sql')
        run_command(f'git clone -b {instance_data[0]["be_git_branch"]} {instance_data[0]["be_git_repo"]}')
        print('Current DIR after backend clone: ' + os.getcwd())
        setup_backend('/var/www/html/broker_onboard_script/src/backend_env.txt', env_file_name, backend_env)
        print('Current DIR after backend setup: ' + os.getcwd())
        os.chdir('/var/www/html/'+domain_name)
        run_command(f'git clone -b {instance_data[0]["fe_git_branch"]} {instance_data[0]["fe_git_repo"]}')
        print('Current DIR after frontend clone : ' + os.getcwd())
        os.chdir('/var/www/html/'+domain_name)
        original_file_path = '/var/www/html/broker_onboard_script/src/frontend_env.txt'  # The file containing the original .env content
        setup_frontend(original_file_path, env_file_name, api_base_url)
        print('Current DIR after frontend setup : ' + os.getcwd())
        ckyc_env = {}
        ckyc_env['app_name'] = f'"{broker_name} CKYC"'
        ckyc_env['backend_url'] = instance_data[0]['ckyc_url']
        ckyc_env['environment'] = environment[0]['enviroment_name']
        ckyc_env['db_host'] = database[0]['db_host']
        ckyc_env['db_post'] = database[0]['db_port']
        ckyc_env['db_name'] = database[0]['db_database']
        ckyc_env['db_username'] = database[0]['db_username']
        ckyc_env['db_password'] = database[0]['db_password']
        # pprint(ckyc_env)
        os.chdir('/var/www/html/'+domain_name)
        run_command(f'git clone -b {instance_data[0]["ckyc_git_branch"]} {instance_data[0]["ckyc_git_repo"]}')
        print('Current DIR after ckyc clone: ' + os.getcwd())
        setup_ckyc('/var/www/html/broker_onboard_script/src/ckyc_env.txt', '.env', ckyc_env)
        print('Current DIR after ckyc setup: ' + os.getcwd())
        modify_nginx_config(script_path+'nginx_config.txt',domain_name,domain_name)
        run_command('sudo systemctl restart nginx')
        statusUpdated = updateInstanceStatus('completed')
        if statusUpdated['status']:
            print(f'Status Updated as Completed.')
except Exception as e:
    os.chdir('/var/www/html/broker_onboard_script/src')
    statusUpdated = updateInstanceStatus('failed')
    if statusUpdated['status']:
        print(f'Status Updated as Failed.')
    print(f"Error while Onboarding the Broker : {e}")
    traceback.print_exc()
