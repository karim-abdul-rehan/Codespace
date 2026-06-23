if [ -z $1 ]; then
#	print_help
	echo help
	exit
fi
if [ -f $1 ] && [ -s $1 ]; then
	echo $1 is a file and greater than zero
elif [ -f $1 ]; then
	echo it is an empty file
elif [ -d $1 ]; then
	echo it is a directory
else
	echo neither file nor directory $1 is exist
fi
