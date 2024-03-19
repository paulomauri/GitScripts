#!/bin/bash


USERNAME=oracle
HOST=nerv07
PASSWORD=Nerv2019
ORACLE_SID=ORCLMT
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_1
PATH=$PATH:$ORACLE_HOME/bin

sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -T $USERNAME@$HOST <<EOF
for arquivo in "/u01/ORCLMT/archivelog/2019_08_24/"
do 
#rman target / <<EOI

#CATALOG ARCHIVELOG '/u01/ORCLMT/archivelog/2019_08_24/$arquivo';

#exit;
#EOI
echo arquivo
done
EOF
exit 0

