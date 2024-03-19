#!/bin/bash

# Este script é executado pelo cron, mas antes de sua execução, 
# 	é carregado .bash_profile do usuário no cron.
# 
# 12 16 03 03 * . /home/oracle/.bash_profile; /home/oracle/script_test_cron_profile.sh > /home/oracle/resultado.txt
#
#
sqlplus / as sysdba <<EOF
select username from dba_users;
EOF
exit 0;
