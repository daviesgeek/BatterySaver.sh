#!/bin/bash

#while true; do
  #sleep 300
  CHARGE=$(ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%3.1f\n", $10/$5 * 100)}')
  PLUGGED=$(ioreg -n AppleSmartBattery | grep ExternalConnected | awk '{print($5)}')

  echo $(date)':	'$CHARGE'	AC:	'$PLUGGED >> battery.log
  if [ $PLUGGED == 'No' ] && [ $CHARGE < 40 ]; then
  	echo 'not plugged in, charge < 40'
  fi
#done