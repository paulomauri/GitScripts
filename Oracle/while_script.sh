#!/bin/bash
# Test While

critVar=0
while [ $critVar -lt 5 ]; do
	critVar=$(ps -ef | grep sqlplus | grep -v grep | wc -l)
	echo "Number of sqlplus processes: $critVar"
	sleep 10 
done
echo $critVar | mailx -s "too many sqlplus processes: $critVar" paulo.mauri@gmail.com
exit 0
 
