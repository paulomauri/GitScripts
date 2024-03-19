#!/bin/bash
# simple backup with parameters 

PRG=$(basename $0)
USAGE="Usage $PRG -s SID [-c compress] [-h]"
if [ $# -eq 0 ]; then
	echo $USAGE
	exit 1
fi
#
# In the OPTSTRING variable, if the first character is a :, the surpress system
# generated messages. If a char is followed by :, then as argument is expected to be
# passed in for a given option. The OPTARG enviroment variable contains the 
# argument passed in for a given option.
#
OPTSTRING=":s:c:h"
while getopts "$OPTSTRING" ARGS; do
	case $ARGS in	
	s) ORACLE_SID=${OPTARG}
	;;
	c)COMP_SWITCH=$(echo ${OPTARG} | tr '[A-Z]' '[a-z]')
		if [ $COMP_SWITCH = "compress" ]; then
			COMP_MODE="as compressed backupset"
		else
			echo "$USAGE"
			exit 1
		fi
	;;
	h)echo "$USAGE"
	  exit 1
	;;
	*)echo "Error: Not a valid switch or missing argument."
	  echo "$USAGE"
	  exit 1
	;;
	esac
done
#
echo "RMAN BACKUP"
rman target / << EOF
backup $COMP_MODE database;
EOF
#
exit 0




