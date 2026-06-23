result=$( echo "$@" | bc -l 2>error_log)
if [ "$?" -ne 0 ] || [ -s error_log ]; then
	echo " invalid input"
else
	echo $result
fi

