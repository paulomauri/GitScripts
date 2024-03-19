#!/bin/bash
source /home/oracle/db_env

sqlplus -s / as sysdba <<EOF
select sysdate from dual;
EOF


