#!/usr/bin/bash
source /home/oracle/.bash_profile

if [ -f "/u01/app/oracle/RADM-Oracle-Archives.loc" ];
then
echo "Rotina ainda em andamento..."
exit

else
touch /u01/app/oracle/RADM-Oracle-Archives.loc
chown oracle:oinstall /u01/app/oracle/RADM-Oracle-Archives.loc

export ORACLE_SID=ORCLMT
rman target / <<EOF
BACKUP ARCHIVELOG ALL NOT BACKED UP 1 TIMES FORMAT '/home/oracle/Backup/Archives/Archives-%d___DBID-%I___Date-%T___Set-%s___Piece-%p.BKP';
EOF

rm -f /u01/app/oracle/RADM-Oracle-Archives.loc
fi
