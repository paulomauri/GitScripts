#!/bin/bash
#
# Este script foi utilizado para ser chmado pelo crontab
# o crontab em sua execução do script, leva o minimo de variaveis de ambiente para execução.
# por isso adicionado as variaveis abaixo.
#
# 
ORACLE_SID=ORCL
ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/dbhome_1
PATH=$PATH:$ORACLE_HOME/bin
#
rman target / <<EOF
backup database;
EOF
exit 0

