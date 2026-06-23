dir=$( echo $PATH | sed 's/:/ /g' )
for lst in $dir ;do
	echo "-----------------------------[ $lst ]-----------------------------"
	ls $lst |grep $1
done
