#!/bin/bash
PRG=$(basename $0)
#
# validate parameters
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
set -o xtrace
crit_var=$(sqlplus -s <<EOF
$CONSTR
SET HEAD OFF FEED OFF
SELECT 'SUCESS' FROM DUAL;
EOF)
set +o xtrace
#
# write output to logfile
echo ${crit_var} > $LOG_FILE
#
# send status
set -o xtrace
echo $crit_var | grep SUCESS 2>&1 >/dev/null
if [[ $? -ne 0 ]]; then
	$MAILX -s "Problem with ${SID} on ${BOX}" $MAIL_LIST <$LOG_FILE
else
	echo "SUCESS: ${SID} on ${BOX}" | \
	$MAILX -s "SUCESS ${SID} okay on ${BOX}" $MAIL_LIST
fi
set +o xtrace
#



