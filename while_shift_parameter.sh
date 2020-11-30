#!/bin/bash
# Test While loop

while [ $# -ne 0 ]; do
	echo $1
	shift 1
done
