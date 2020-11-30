#!/bin/bash
PRG=$(basename $0)
#
# validate parameters
LOCK_FILE=/home/oracle/scripts/db_orcl_lock.lock
if [ -f $LOCK_FILE ]; then
	echo "Lock file exists, exiting..."
	exit 1
else
	echo "DO NOT REMOVE, LOCK FILE" > $LOCK_FILE
fi
USAGE="Usage: ${PRG} <database name>"
if [ $# -ne 1 ]; then
	echo ${USAGE}
	exit 1
fi
#
# set the variables used in script
SID=${1}
CONSTR=' / as sysdba'
MAILX='/bin/mailx'
MAIL_LIST='paulo.mauri@gmail.com'
LOG_DIR='/home/oracle/scripts'
DAY=$(date +%F)
LOG_FILE=${LOG_DIR}/${PRG}.${DAY}.$$.log
LOC_SID=ORCL
BOX=$(uname -a | awk '{print$2}')
#
# source oracle variables
source /home/oracle/db_env
#
# attempt to connect to database via SQLPlus
crit_var=$(sqlplus -s <<EOF
$CONSTR
SET HEAD OFF FEED OFF
SELECT 'SUCESS' FROM DUAL;
EOF)
#
# write output to logfile
echo ${crit_var} > $LOG_FILE
#
# send status
echo $crit_var | grep sucess 2>&1 >/dev/null
if [[ $? -ne 0 ]]; then
	$MAILX -s "Problem with ${SID} on ${BOX}" $MAIL_LIST <$LOG_FILE
else
	echo "SUCESS: ${SID} on ${BOX}" | \
	$MAILX -s "SUCESS ${SID} okay on ${BOX}" $MAIL_LIST
fi
#

if [ -f $LOCK_FILE ]; then
	rm $LOCK_FILE
fi

