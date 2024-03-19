SET VERIFY OFF
set echo on
spool /home/oracle/database_creation_scripts/customScripts.log append
connect "SYS"/"&&sysPassword" as SYSDBA
@/home/oracle/database_creation_dbca/
spool off
