#!/bin/bash
# Check a existence of file
# File Operator Description
# -a True if file exists
# -b True if file is a block device file
# -c True if file is a character device file
# -d True if file is a directory
# -e True if file exists
# -f True if file exists and is a regular file
# -g True if file has set-group-id permission set
# -h True if file is a symbolic link
# -L True if file is a symbolic link
# -k True if file’s sticky bit is set
# -p True if file is a named pipe
# -r True if the file is readable (by current user)
# -s True if file exists and is not empty
# -S True if file is socket
# -u True if file is set-user-id
# -w True if file is writable (by current user)
# -x True if file is executable
# -O True if file is effectively owned by current user
# -G True if file is effectively owned by current user’s group
# -N True if file has been modified since it was last read
# file1 -nt file2 True if file1 is newer than file2
# file1 -ot file2 True if file1 is older than file2
# file1 -ef file2 True if file1 is a hard link to file2


checkFile=/home/trace/error.log
if [ -e $checkFile ]; then
	mail -s "error.log exists" paulo.mauri@gmail.com <$checkFile
else
	"$checkFile does not exist."
fi
exit 0

# checkFile=/home/oracle/error.log
# if [ -e $checkFile ]; then
# : < nao faz nada
# else
# echo "$checkFile does not exist"
# fi
# exit 0

