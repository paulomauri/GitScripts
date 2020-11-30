set verify off
ACCEPT sysPassword CHAR PROMPT 'Enter new password for SYS: ' HIDE
ACCEPT systemPassword CHAR PROMPT 'Enter new password for SYSTEM: ' HIDE
host /u01/app/oracle/product/12.2.0.1/dbhome_1/bin/srvctl add database -d MERC -o /u01/app/oracle/product/12.2.0.1/dbhome_1 -n MERC
host /u01/app/oracle/product/12.2.0.1/dbhome_1/bin/srvctl disable database -d MERC
host /u01/app/oracle/product/12.2.0.1/dbhome_1/bin/orapwd file=/u01/app/oracle/product/12.2.0.1/dbhome_1/dbs/orapwMERC force=y format=12
host /u01/app/oracle/product/12.2.0.1/grid/bin/setasmgidwrap o=/u01/app/oracle/product/12.2.0.1/dbhome_1/bin/oracle
@/home/oracle/database_creation_scripts/CloneRmanRestore.sql
@/home/oracle/database_creation_scripts/cloneDBCreation.sql
@/home/oracle/database_creation_scripts/postScripts.sql
@/home/oracle/database_creation_scripts/lockAccount.sql
@/home/oracle/database_creation_scripts/postDBCreation.sql
@/home/oracle/database_creation_scripts/customScripts.sql
