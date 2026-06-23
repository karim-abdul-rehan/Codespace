red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
default=$(tput sgr0)
B0="--------------------------------------------------------------------------------"
B1="OOOOOO  OOOOOO O      OOOOOO O    O O      OOOOOO OOOOOO OOOOOO OOOOO           "
B2="O       O    0 O      O      O    O O      O    O   O    O    O O   O           "
B3="O       OOOOOO O      O      O    O O      OOOOOO   O    O    O OOOOO           "
B4="O       O    O O      O      O    O O      O    O   O    O    O O  O            "
B5="OOOOOO  O    O OOOOOO OOOOOO OOOOOO OOOOOO O    O   O    OOOOOO O   O V.10.4.26 "
B6="--------------------------------------------------------------------------------"
B7="              github: k.a.rehan-zx"
B8="select: \n
	[1] Addition \n
	[2] Substraction \n
	[3] Multiplication \n
	[4] Division \n
	[q] Exit \n"
num_regex="^-?[0-9]*\.?[0-9]+$"
print_banner(){
	clear
	echo "${green}$B0"
	printf "${cyan}$B1 \n"
	printf "$B2 \n"
	printf "$B3 \n"
	printf "$B4 \n"
	printf "$B5 \n"
	echo "${green}$B6"
	printf "${yellow}$B7 \n"
}
print_opt(){
	printf "${green}${B8} \n"
}
input1(){
	clear
	print_banner
	print_opt
	read -p "${red} --> " get
	if [ $get == "1" ] ; then
		addition
	elif [ $get == "2" ] ; then
		substraction
	elif [ $get = "3" ] ; then
		multiplication
	elif [ $get = "4" ] ; then
		division
	elif [ $get = "q" ] ; then
		echo ${default} !!!! byee !!!!
		exit
	else
		input_err
		input1
	fi
}
input2(){
	print_banner
	read -p "${cyan} first number >> " frst
	read -p " second number >> " scnd
	if [ $frst =~ $num_regex ] || [ $scnd =~ $num_regex ] ; then
		print_banner
		input_err
		input2
	fi
	if [ $get -eq 4 ] && [ $scnd -eq 0 ];then
		print_banner
		input_err
		input2
	fi
	if [ $frst -eq 0 ] && [ $scnd -eq 0 ];then
		print_banner
		input_err
		input2
	else
		echo ...
	fi
}
input_err(){
# show error during get secnd input
	echo " "
	echo "invalid input !!!"
	echo " "
	read -p "[ENTER]" ext1
}
addition(){
	input2
	result=$( echo $frst + $scnd | bc -l )
}
substraction(){
	input2
	result=$( echo $frst - $scnd | bc -l )
}
multiplication(){
	input2
	result=$( echo $frst * $scnd | bc -l )
}
division(){
	input2
	result=$( echo $frst / $scnd | bc -l )
}
main(){
	input1
	echo ${cyan} " result -->> " ${result}
	read -p "[ENTER] " ext2
}
while true ; do
	main
done
