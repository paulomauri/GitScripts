#!/bin/bash
# for loop script

for a in $(ls /home/oracle)
do
	echo "$a"
done

for a in {1..10}
do
echo "$a "
done

for ((a=1; a <= 10; a++))
do
echo "$a "
done

