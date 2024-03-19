#!/bin/bash
# Check if the database is up.

source /home/oracle/db_env
echo "select instance_name, status from v\$instance;" | sqlplus / as sysdba
exit 0 
