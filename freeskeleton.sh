#!/bin/bash

#################################################################################
################### FREE - Skeleton Version 0.3 - under GPLv3 ###################
################### by Mathias Gut, Netchange Informatik GmbH ###################
################### From the freecybersecurity.org Project    ###################
################### Thanks to the community for the ideas     ###################
################### integrated into this skeleton.            ###################
#################################################################################

##########################################################
#  INFORMATIONS                                          #
#   your info...                                         #
#   your info...                                         #
##########################################################

#######################
### Preparing tasks ###
#######################

#Check root rights (sudo) before execution.
if [ $(id -u) -ne 0 ]; then
	echo "You need root rights (sudo)."
	exit
fi

#Check if a program is installed.
program=(python3 vi emacs)
for i in "${program[@]}"; do
	if [ -z $(command -v ${i}) ]; then
		echo "${i} is not installed."
		count=1
	fi
	
	if [[ $count -eq 1 ]]; then
		exit
	fi
done
unset program
unset count

#Check if a program is installed via an input file.
while read line
do
	program=$(echo "$line" | awk -F ';;' '{print $1}')
	proginst=$(echo "$line" | awk -F ';;' '{print $2}')

	if [ -z $(command -v ${program}) ]; then
		echo "${program} is not installed. Installation: ${proginst}"
		count=1
	fi

	unset program
	unset proginst

done <./commandcheck.txt

if [[ $count -eq 1 ]]; then
	unset count
	exit
fi

#Read current date and time in hours and minutes into variable.
time=$(date +%d.%m.%Y-%H:%M)

#Check if a folder exists and create otherwise.
if ! [ -d "./inputs/temp" ]; then
	mkdir ./inputs/temp
fi


############################
### Integrated functions ###
############################

#. libraries/


###############################
### EXAMPLE TOOL USAGE TEXT ###
###############################

usage() {
	echo "From the Free OCSAF project"
	echo "Free OCSAF SKELETON 0.3 - GPLv3 (https://freecybersecurity.org)"
	echo "Use only with legal authorization and at your own risk!"
       	echo "ANY LIABILITY WILL BE REJECTED!"
       	echo ""
	echo "USAGE:"
	echo "  ./freesekeleton.sh -m <argument1>"
       	echo "  ./freeskeleton.sh -l <argument2>"
       	echo ""
	echo "EXAMPLE:"
       	echo "  ./freeskeleton.sh -d freecybersecurity.org"
       	echo ""
	echo "OPTIONS:"
	echo "  -h, help - this beautiful text"
	echo "  -d <argument1> - description"
	echo "  -l <argument2> - description"
	echo "  -c, no color scheme set"
       	echo ""
	echo "NOTES:"
	echo "#See also the MAN PAGE - https://freecybersecurity.org"
}


###############################
### GETOPTS - TOOL OPTIONS  ###
###############################

while getopts "d:l:hc" opt; do
	case ${opt} in
		h) usage; exit 1;;
		d) input1="$OPTARG"; opt_arg1=1;;
		l) input2="$OPTARG"; opt_arg2=1;;
		c) nocolor=1;;
		\?) echo "**Unknown option**" >&2; echo ""; usage; exit 1;;
        	:) echo "**Missing option argument**" >&2; echo ""; usage; exit 1;;
		*) usage; exit 1;;
  	esac
  	done
	shift $(( OPTIND - 1 ))

#Check if opt_arg1 or/and opt_arg2 is set
if [ "$opt_arg1" == "" ] && [ "$opt_arg2" == "" ]; then
	echo "**No argument set**"
	echo ""
	usage
	exit 1
fi


###############
### COLORS  ###
###############

#Colors directly in the script.
if [[ $colors -eq 1 ]]; then
	cOFF=''
	rON=''
	gON=''
	yON=''
else
	cOFF='\e[39m'	  #color OFF / Default color
	rON='\e[31m'	  #red color ON
	gON='\e[32m'	  #green color ON
	yON='\e[33m'	  #yellow color ON
fi


#As color library.
. colors.sh


############################
#### your cool functions ###
############################

# My function for ...
# Naming convention for functions funcFunctionname() - z.B. funcMycheck()

funcMyfuction() {

	local variable1   #Always use local functions and define them at the beginning.
	local variable2   #Always use local functions and define them at the beginning.

	if...
}


############
### MAIN ###
############

echo ""
echo "##########################################"
echo "####  FREE OCSAF BASH SKELETON GPLv3  ####"
echo "####  https://freecybersecurity.org   ####"
echo "##########################################"
echo ""

if [ "$opt_arg1" == "1" ]; then        #For one argument
	funcMyfunction $input1
	echo ""
elif [ "$opt_arg2" == "1" ]; then      #For a list of arguments
	while read line
	do
		funcMyfunction $input2
		unset line
	done <$list
	echo ""
fi

################### END ###################
