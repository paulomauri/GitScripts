#!/usr/bin/bash
source /home/oracle/.bash_profile

if [ -f "/u01/app/oracle/RADM-Oracle-Semanal-2.loc" ];
then
echo "Rotina ainda em andamento..."
exit

else
touch /u01/app/oracle/RADM-Oracle-Semanal-2.loc
chown oracle:dba /u01/app/oracle/RADM-Oracle-Semanal-2.loc

export ORACLE_SID=ORCLMT
$ORACLE_HOME/bin/sqlplus / AS SYSDBA <<EOF

EXEC DBMS_STATS.GATHER_SYSTEM_STATS('START');
EXECUTE DBMS_LOCK.SLEEP(3600);
EXEC DBMS_STATS.GATHER_SYSTEM_STATS('STOP');

ALTER SESSION SET CONTAINER = ORCL;
EXEC DBMS_STATS.GATHER_SYSTEM_STATS('START');
EXECUTE DBMS_LOCK.SLEEP(3600);
EXEC DBMS_STATS.GATHER_SYSTEM_STATS('STOP');

EXIT;
EOF

rm -f /u01/app/oracle/RADM-Oracle-Semanal-2.loc
fi
