#!/bin/ksh
export HP_SIZE_MB=1
DEFAULT_HP_PERCENTAGE=60

if [ "HP_SIZE_MB" = "" ]; then
	echo "HugePage value not specified in the comand-line options."
	echo "We will set the HugePages value based on $DEFAULT_HP_PERCENTAGE % of physical memory."
	SERVER_MEMORY_KB=$(grep ^MemTotal /proc/meminfo |sed -e 's/[^0-9]*//g' -e 's/ //g')
	let SERVER_MEMORY_MB=$SERVER_MEMORY_KB/1024
	echo "Server Memory: $SERVER_MEMORY_MB"

	let DEFAULT_HP_SIZE=$SERVER_MEMORY_MB*$DEFAULT_HP_PERCENTAGE/100
	echo "Default HugePage size based on $DEFAULT_HP_PERCENTAGE %: $DEFAULT_HP_SIZE"
 
	export HP_SIZE_MB=$DEFAULT_HP_SIZE
fi

LINUX_VER=$(cat /etc/redhat-release |sed -e 's/[^0-9]*//g' -e 's/ //g')
echo "Linux Version is:$LINUX_VER"
echo ""

echo "Checking if HugePages is already set"
grep -i vm.nr_hugepages /etc/sysctl.conf
RC=$?
echo ""

function calc_hp {
let HP_KB=$HP_SIZE_MB*1024
echo "HugePages KB = $HP_KB"
let HP_PRESETTING=$HP_KB/2048
let HP_SETTING=$HP_PRESETTING+6
echo "HP Settings: $HP_PRESETTING $HP_SETTING"
echo "New HugePage Setting for /etc/sysctl.conf"
echo "vm.nr_hugepages=$HP_SETTING" 
}
calc_hp

export TMP_SYSCTL=/tmp/sysctl.conf.tmp
if [ "$RC" -eq 1 ]; then
	echo "Return Code for HugePages: $RC"
	echo "HugePages is not set!"
	echo "# -- HugePage Setting for Oracle Database -- #" >>/etc/sysctl.conf
	echo "vm.nr_hugepages=$HP_SETTING" >>/etc/sysctl.conf

elif [ "$RC" -eq 0 ] ; then
	echo "HugePage is set..."
	cp /etc/sysctl.conf /tmp/sysctl.conf$$
	cat /etc/sysctl.conf |grep -v "vm.nr_hugepages" >$TMP_SYSCTL
	echo "vm.nr_hugepages=$HP_SETTING" >>$TMP_SYSCTL
	cp $TMP_SYSCTL /etc/sysctl.conf
fi




let MEMLOCK__VALUE=$HP_SETTING*2048
cat /etc/security/limits.conf |grep -v ^# |grep -i memlock |grep -v grep 2>/dev/null
export MEMLOCK_RC=$?
if [ "$MEMLOCK_RC" -eq 0 ]; then
	export SECURITY_LIMITS_FILE=/etc/security/limits.conf
else
	export SECURITY_LIMITS_FILE=$(grep -il memlock /etc/security/limits.d/*.conf)
fi

# -- MEMLOCK has never been set so we need to find the limits.conf file
cat /etc/security/limits.conf |egrep -v "^#" |grep nproc
export NPROC_RC=$?
if [ "$SECURITY_LIMITS_FILE" = "" ]; then
	if [ "$NPROC_RC" -eq 0 ]; then
		export SECURITY_LIMITS_FILE=/etc/security/limits.conf
	else	
	# -- We need to find the limits file for RHEL 6 directory structure
		export SECURITY_LIMITS_FILE=$(grep -i nproc /etc/security/limits.d/* |awk -F ":"
		{'print $1'} |tail -1)
		[ "$SECURITY_LIMITS_FILE" = "" ] && export SECURITY_LIMITS_FILE=/etc/security/
		limits.d/90-memlock.conf
	fi
fi

export TMP_LIMITS_FILE=/tmp/limits.conf.tmp
#echo "Security Limits File: $SECURITY_LIMITS_FILE"
cp $SECURITY_LIMITS_FILE /tmp/limits.conf.$$
cat $SECURITY_LIMITS_FILE |egrep -v "memlock" >$TMP_LIMITS_FILE
 
echo ""
echo "# -- HugePage Setting for Oracle Databases -- #" >>$TMP_LIMITS_FILE
echo "# -- Here's the changes that were made to the $SECURITY_LIMITS_FILE"
echo "oracle soft memlock $MEMLOCK_VALUE" >>$TMP_LIMITS_FILE
echo "oracle hard memlock $MEMLOCK_VALUE" >>$TMP_LIMITS_FILE
cp $TMP_LIMITS_FILE $SECURITY_LIMITS_FILE
grep -i memlock $SECURITY_LIMITS_FILE


echo ""
echo "# ------------------------------------------------------- #"
echo "# Your system has been set for hugepages. "
echo "# Please reboot your server to see the changes!"
echo ""


