######
#
# Global functions & misc other stuff
# Matthew Davies, Dec 12th, 2013
# 
######

	#Missing message declarations
	#Set a bunch of variables
	name='BatterySaver'
	osversion=$(system_profiler SPSoftwareDataType | grep 'System Version' | awk '{print($5)}')
	os=$(echo $osversion | awk -F"." '{print $1}')
	osDot=$(echo $osversion | awk -F"." '{print $2}')
	charge=$(ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%3.1f\n", $10/$5 * 100)}')
	plugged=$(ioreg -n AppleSmartBattery | grep ExternalConnected | awk '{print($5)}')
	notify=$(which terminal-notifer > /dev/null)

	logfile='BatterySaver.log'
	configfile='settings.conf'

	LOGMESSAGE=''

	##
	# Logger, used for logging to the $LOGFILE, then exiting
	##
	die(){
		echo $(date)':	OS: '$version',	Battery: '$charge',	AC: '$plugged',	'${LOGMESSAGE%,} >> $logfile
		exit 1
	}

	##
	# Creates an array of arguements
	##

	args=()
	for i in "$@"; do
		args+=("$i")
	done
	x=0
	x2=0
	argArray=()
	for a in ${args[@]}; do
		if [[ $a =~ ^- ]]; then
			i=$(($x2+1))
			argArray+=("$a ${args[$i]}")
			let "x++"
		fi
		let "x2++"
	done

	arg(){
		for a in "${argArray[@]}"; do
			get="$@"
			b=$(echo "$a" | awk '{ printf($1) }' | cut -d "-" -f 2)
			if [ "$b" == "$get" ]; then
				echo ${a/-${get}/}
			fi
		done
	}

	readSettings(){
		i=0
		while read line; do
		  if [[ "$line" =~ ^[^#]*= ]]; then
		    a=$(echo ${line%% =*} | sed 's/ /_/g' | awk '{print tolower($0)}')
		    eval $a="${line#*= }"
		    ((i++))
		  fi
		done < $configfile
	}

	setSetting(){
		echo $1' = '$2 >> $configfile
		LOGMESSAGE+="Set $1 = $2, "
	}