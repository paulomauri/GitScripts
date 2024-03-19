#!/usr/bin/bash
source /home/oracle/.bash_profile

if [ -f "/u01/app/oracle/RADM-Oracle-Diario-Estatisticas.loc" ];
then
echo "Rotina ainda em andamento..."
exit

else
touch /u01/app/oracle/RADM-Oracle-Diario-Estatisticas.loc
chown oracle:oinstall /u01/app/oracle/RADM-Oracle-Diario-Estatisticas.loc

export ORACLE_SID=ORCLMT
$ORACLE_HOME/bin/sqlplus / AS SYSDBA <<EOF

EXEC DBMS_STATS.GATHER_DATABASE_STATS(OPTIONS=>'GATHER STALE', GATHER_SYS=>FALSE);

ALTER SESSION SET CONTAINER = ORCL;
EXEC DBMS_STATS.GATHER_DATABASE_STATS(OPTIONS=>'GATHER STALE', GATHER_SYS=>FALSE);

EXIT;
EOF

rm -f /u01/app/oracle/RADM-Oracle-Diario-Estatisticas.loc
fi
