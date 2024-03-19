#!/bin/bash
#
# Este script foi utilizado para ser chmado pelo crontab
# o crontab em sua execução do script, leva o minimo de variaveis de ambiente para execução.
# no crontab é feito a chamada do bash profile do usuário para carregar as variáveis
# # crontab
# # . /home/oracle/.bash_profile;/home/oracle/script_rman_backup_1.sh > /home/oracle/backup.$(date +\%Y\%m\%d).log 2>&1
#
rman target / <<EOF
delete noprompt obsolete;
backup database;
EOF
exit 0

