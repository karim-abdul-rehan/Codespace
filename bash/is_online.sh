#!/usr/bin/bash
result=$(ping -c 1 -w 1 -W 1 $1 |grep packets |awk '{print $4}')
usage="\n
        usage :\n
        ./exersice.sh <host>\n
\n"
if [[ -z $1 ]] ; then
	printf $usage
fi

if [[ $result == 1 ]]; then
	echo yes
else
	echo no
fi

