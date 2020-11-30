SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /home/oracle/database_creation_scripts/postScripts.log append
UPDATE sys.USER$ set SPARE6=NULL;
@/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/admin/dbmssml.sql;
execute dbms_datapump_utl.create_default_dir;
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set current_schema=ORDSYS;
@/u01/app/oracle/product/12.2.0.1/dbhome_1/ord/im/admin/ordlib.sql;
alter session set current_schema=SYS;
connect "SYS"/"&&sysPassword" as SYSDBA
create or replace directory XMLDIR as '/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/xml';
create or replace directory XSDDIR as '/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/xml/schema';
create or replace directory ORA_DBMS_FCP_ADMINDIR as '/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/admin';
create or replace directory ORA_DBMS_FCP_LOGDIR as '/u01/app/oracle/product/12.2.0.1/dbhome_1/cfgtoollogs';
connect "SYS"/"&&sysPassword" as SYSDBA
connect "SYS"/"&&sysPassword" as SYSDBA
@/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/admin/execocm.sql;
execute dbms_qopatch.replace_logscrpt_dirs;
@/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/admin/execemx.sql;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool /home/oracle/database_creation_scripts/postDBCreation.log append
create or replace directory ORACLE_HOME as '/u01/app/oracle/product/12.2.0.1/dbhome_1';
create or replace directory ORACLE_BASE as '/u01/app/oracle';
grant sysdg to sysdg;
grant sysbackup to sysbackup;
grant syskm to syskm;
