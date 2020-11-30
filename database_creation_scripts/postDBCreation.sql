SET VERIFY OFF
spool /home/oracle/database_creation_scripts/postDBCreation.log append
host /u01/app/oracle/product/12.2.0.1/dbhome_1/OPatch/datapatch -skip_upgrade_check -db MERC;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='+DATA' FROM pfile='/home/oracle/database_creation_scripts/init.ora';
connect "SYS"/"&&sysPassword" as SYSDBA
select 'utlrp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
@/u01/app/oracle/product/12.2.0.1/dbhome_1/rdbms/admin/utlrp.sql;
select 'utlrp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
select comp_id, status from dba_registry;
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
shutdown immediate;
host /u01/app/oracle/product/12.2.0.1/dbhome_1/bin/srvctl enable database -d MERC;
host /u01/app/oracle/product/12.2.0.1/dbhome_1/bin/srvctl start database -d MERC;
connect "SYS"/"&&sysPassword" as SYSDBA
spool off
