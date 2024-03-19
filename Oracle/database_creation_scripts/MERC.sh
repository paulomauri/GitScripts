#!/bin/sh

DB_HOME=$ORACLE_HOME
ASM_HOME=/u01/app/oracle/product/12.2.0.1/grid
ORACLE_HOME=$ASM_HOME; export ORACLE_HOME
ORACLE_SID=+ASM; export ORACLE_SID
PERL5LIB=$ORACLE_HOME/rdbms/admin:$PERL5LIB; export PERL5LIB
/u01/app/oracle/product/12.2.0.1/grid/bin/sqlplus /nolog @/home/oracle/database_creation_scripts/mkDir.sql
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
OLD_UMASK=`umask`
umask 0027
mkdir -p /u01/app/oracle
mkdir -p /u01/app/oracle/admin/MERC/adump
mkdir -p /u01/app/oracle/admin/MERC/dpdump
mkdir -p /u01/app/oracle/admin/MERC/pfile
mkdir -p /u01/app/oracle/audit
mkdir -p /u01/app/oracle/cfgtoollogs/dbca/MERC
umask ${OLD_UMASK}
PERL5LIB=$ORACLE_HOME/rdbms/admin:$PERL5LIB; export PERL5LIB
ORACLE_SID=MERC; export ORACLE_SID
PATH=$ORACLE_HOME/bin:$ORACLE_HOME/perl/bin:$PATH; export PATH
echo You should Add this entry in the /etc/oratab: MERC:/u01/app/oracle/product/12.2.0.1/dbhome_1:Y
/u01/app/oracle/product/12.2.0.1/dbhome_1/bin/sqlplus /nolog @/home/oracle/database_creation_scripts/MERC.sql
