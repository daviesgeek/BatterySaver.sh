#!/bin/bash
  
  if [ "$(ioreg -l | grep system-type | awk -F'=' '{print $2}' | tr -d ' ')" != '<02>' ]; then
    echo 'Sorry, this computer is not a laptop';
    exit 0;
  fi

  source 'global.sh'

  #If there isn't a log file, assume that this is the first run
  if [[ ! -f $configfile ]] ; then
  	source 'first-run.sh' #First run script
  else
    readSettings
  fi

  if [ $os == '10' ]; then #If this is running on OS X
  	if [[ $osDot > '8' ]] && [[ $notify ]]; then
  		source 'ml-notify.sh'
  	else
  		source 'legacy-notify.sh'
  	fi
  fi

  #Here's where the actual fun happens
  if [ $plugged == 'No' ] && [[ "$charge" < 40 ]]; then
  	echo 'not plugged in'
  fi

die

## add growlnotify support
## https://github.com/indirect/growlnotify

#while true; do
  #sleep 300
#done