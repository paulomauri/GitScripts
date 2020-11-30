#!/bin/bash
# Complex Conditions

BOX=$(uname -a | awk '{print $2}')
# echo $BOX

# mntlist="/ /boot /u01/"
mntlist=$(df -h | awk '{print $6}'|grep -vw "Mounted")
echo "Mounted on: $mntlist"

for ml in $mntlist
do
echo "Mount point: $ml"
usedSpc=$(echo $(df -h $ml|awk '{print $5}'|grep -v Use|cut -d "%" -f1 -))
BOX=$(uname -a |awk '{print $2}')
case $usedSpc in
[0-9])
diskstat="relax, lots of disk space usage: $usedSpc"
;;
[1-7][0-9])
diskstat="disk space okay: $usedSpc"
;;
[8][0-9])
diskstat="space getting low: $usedSpc"
;;
[9][0-9])
diskstat="warning, running out of space: $usedSpc"
echo $diskstat $ml | mailx -s "space on: $BOX" paulo.mauri@gmail.com
;;
[1][0][0])
diskstat="update resume, no space left: $usedSpc"
echo $diskstat $ml | mailx -s "space on: $BOX" paulo.mauri@gmail.com
;;
*)
diskstat="huh?: $usedSpc"
esac
# end case
echo $diskstat
done
# end for
exit 0
