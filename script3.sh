#!/bin/bash
# test command
# command substitution
# variable=(shell commands)


echo "Number of parameters: " $#
Pgm=$(basename $0)
if [ $# -ne 1 ]; then
	echo "wrong number of paramters passed to script."
	echo "Usage: $Pgm ORACLE_SID"
	exit 1 
else
	echo "Parameter $1 passed to the script."
fi
exit 0
