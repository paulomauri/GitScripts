#!/bin/bash

source /home/oracle/db_env

newobjs=$(sqlplus -s / as sysdba <<EOF
select object_name 
from dba_objects 
where created > sysdate - 7 and owner not in('SYS','SYSTEM');
EOF)
echo $newobjs
