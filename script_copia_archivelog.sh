#!/bin/bash

export ORACLE_SID=+ASM

#2019_08_24/
for file in $( asmcmd ls "+FRA/ORCLMT/ARCHIVELOG/2019_08_24" )
do
asmcmd <<EOF 
        cp +FRA/ORCLMT/ARCHIVELOG/2019_08_24/$file SYS/Nerv2019@nerv07.+ASM:/u01/ORCLMT/archivelog/2019_08_24/$file
EOF
done

ORACLE_SID=ORCLMT
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_1
PATH=$PATH:$ORACLE_HOME/bin

sshpass -p $PASSWORD ssh -o  StrictHostKeyChecking=no -T $USERNAME@$HOST  <<EOF

        for arquivo in "/u01/ORCLMT/archivelog/2019_08_24/"
        do 
                rman target / <<EOI
                        RUN {
                                CATALOG ARCHIVELOG '/u01/ORCLMT/archivelog/2019_08_24/$arquivo'
                        }
                EOI
        done

EOF
exit 0

