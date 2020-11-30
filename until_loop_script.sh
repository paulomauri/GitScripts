#!/bin/bash

crit_var=0
until [ $crit_var -ge 300 ]; do
crit_var=$(ps -ef | grep sqlplus | grep -v grep | wc -l)
echo "Number of sqlplus processes: $crit_var"
sleep 15
done
echo $crit_var | mailx -s "too many sqlplus procs" dba@gmail.com
exit 0

