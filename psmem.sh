ps -e -o pmem,pid,user,tty,args | grep -i oracle | sort -n -k 1 -r | head

