echo check file...
until [ -f "$1" ]; do
	echo not create now
	sleep 2
done
echo file exist
