#!/usr/bin/bash
source /home/oracle/.bash_profile

if [ -f "/u01/app/oracle/RADM-Oracle.loc" ];
then
echo "Rotina ainda em andamento..."
exit

else
touch /u01/app/oracle/RADM-Oracle-Diario.loc
chown oracle:oinstall /u01/app/oracle/RADM-Oracle-Diario.loc

export ORACLE_SID=ORCLMT
$ORACLE_HOME/bin/sqlplus / AS SYSDBA <<EOF

PURGE DBA_RECYCLEBIN;

ALTER SESSION SET CONTAINER = ORCL;
PURGE DBA_RECYCLEBIN;

EXIT;
EOF

$ORACLE_HOME/bin/rman target / <<EOF
BACKUP DATABASE;
DELETE NOPROMPT OBSOLETE;
EXIT;
EOF

export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export MINUTES=+1440
export DAYS=1
echo "INFO: adrci purge started at `date`"
adrci exec="show homes"| grep -v : | while read ADR_HOME
do
echo "INFO: adrci purging diagnostic destination " $ADR_HOME
echo "INFO: purging ALERT older than $MINUTES minutes: $DAYS days"
adrci exec="set homepath $ADR_HOME; purge -age $MINUTES -type ALERT"
echo "INFO: purging INCIDENT older than $MINUTES minutes: $DAYS days"
adrci exec="set homepath $ADR_HOME; purge -age $MINUTES -type INCIDENT"
echo "INFO: purging TRACE older than $MINUTES minutes: $DAYS days"
adrci exec="set homepath $ADR_HOME; purge -age $MINUTES -type TRACE"
echo "INFO: purging CDUMP older than $MINUTES minutes: $DAYS days"
adrci exec="set homepath $ADR_HOME; purge -age $MINUTES -type CDUMP"
echo "INFO: purging HM older than $MINUTES minutes: $DAYS days"
adrci exec="set homepath $ADR_HOME; purge -age $MINUTES -type HM"
echo ""
done
echo "INFO: adrci purge finished at `date`"
echo ""

rm -f /u01/app/oracle/RADM-Oracle-Diario.loc

fi
