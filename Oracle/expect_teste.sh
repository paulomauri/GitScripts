#!/bin/bash
#!/usr/bin/expect -f

expect -c 'spawn ssh oracle@nerv07 "[ -d /u01/ORCLMT/archivelog/ ] && echo "Dir existe""; expect "assword:"; send "Nerv2019\r"; interact'
