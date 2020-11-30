#!/bin/bash

source /home/oracle/.bash_profile

export ORACLE_SID=+ASM
export ORACLE_BASE=/u01/app/oracle/product/12.2.0.1
export ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/grid
export PATH=$PATH:$ORACLE_HOME/bin

USERNAME=oracle
HOST=nerv07
PASSWORD=Nerv2019
DATA_ATUAL=$(date +"%Y_%m_%d")

if [ ! -z $1 ];
then
DATA_ATUAL=$(date -d $1 +"%Y_%m_%d")
echo $DATA_ATUAL
fi

if [ -f "/u01/ORCLMT/script_copia_archivelog_2.loc" ];
then
echo "Rotina ainda em andamento..."
exit

else

touch /u01/ORCLMT/script_copia_archivelog_2.loc
chown oracle:oinstall /u01/ORCLMT/script_copia_archivelog_2.loc

sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -T $USERNAME@$HOST  <<EOF
	if [ ! -d "/u01/ORCLMT/ARCHIVELOG/$DATA_ATUAL" ]; 
	then
		mkdir -p "/u01/ORCLMT/ARCHIVELOG/$DATA_ATUAL"
	fi
	exit
EOF

export ORACLE_SID=+ASM
export ORACLE_BASE=/u01/app/oracle/product/12.2.0.1
export ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/grid
export PATH=$PATH:$ORACLE_HOME/bin


for file in $( asmcmd ls "+FRA/ORCLMT/ARCHIVELOG/$DATA_ATUAL" )
do
asmcmd cp +FRA/ORCLMT/ARCHIVELOG/$DATA_ATUAL/$file SYS/Nerv2019@nerv07.+ASM:/u01/ORCLMT/ARCHIVELOG/$DATA_ATUAL/$file

done

rm -f /u01/ORCLMT/script_copia_archivelog_2.loc

fi
 
exit 0
