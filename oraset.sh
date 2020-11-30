#!/bin/bash
# Sets the Oracle enviroment variables
# Setup: 1.Put oraset file in /etc (Linux), in /var/opt/oracle (Solaris)
# 	 2.Ensure /etc or /var/opt/oracle is in $PATH
# Usage: batch mode: . oraset <SID>
# 	 menu mode:  . oraset

#=====================================================
if [ -f /etc/oratab ]; then
	OTAB=/etc/oratab
elif [ -f /var/opt/oracle/oratab ]; then
	OTAB=/var/opt/oracle/oratab
else
	echo 'oratab file not found'
	exit 
fi
######
if [ -z $1 ]; then
	SIDLIST=$(egrep -v '#|\*' ${OTAB} | cut -f1 -d:)
	PS3='SID? '
	select sid in ${SIDLIST}; do
		if [ -n $sid ]; then
			HOLD_SID=$sid
			break
		fi
	done
else
	if egrep -v '#|\*' ${OTAB} | grep -w "${1}:">/dev/null; then
		HOLD_SID=$1
	else
		echo "$SID: $1 not found in $OTAB"
	fi
	shift
fi
######

echo "OTAB: $OTAB"
echo "sid: $sid"
echo "HOLD_SID: $HOLD_SID"

# These lines below are commented, because we do not want to change de enviroment variables
#
# export ORACLE_SID=$HOLD_SID
# export ORACLE_HOME=$(egrep -v '#|\*' $OTAB | grep -w $ORACLE_SID: | cut -f2 -d:)
# export ORACLE_BASE=${ORACLE_HOME%%/product*}
# export TNS_ADMIN=$ORACLE_HOME/network/admin
# export ADR_BASE=$ORACLE_BASE/diag
# export PATH=$ORACLE_HOME/bin:/usr/ccs/bin:/opt/SENSsshc/bin/:/bin:/usr/bin:.:/var/opt/oracle:/usr/sbin:/etc
# export LD_LIBRARY_PATH=/usr/lib:$ORACLE_HOME/lib

