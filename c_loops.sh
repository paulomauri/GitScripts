#!/bin/bash
# loops written in C language
####################################

((a = 1))
while (( a <= 10 ))
do
echo "$a "
((a += 1))
done

#####################################

a=0
condition ()
{
((a++))
if [ $a -lt 11 ]
then
return 0 # true
else
return 1
fi
# false
}
while condition
do
echo "$a"
done

#####################################

a=1
until (( a > 10 ))
do
echo "$a"
(( a++ ))
done


