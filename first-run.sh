######
#
# First run script (only included if this is the first run)
# Matthew Davies, Dec 12th, 2013
# 
######

	clear
	if [[ ! $(which terminal-notifier > /dev/null) ]]; then
		echo -e "This script is most useful if you install terminal-notifier. Would you like to install it now? (Y/N) \c"
		read
		shopt -s nocasematch
		if [[ "$REPLY" =~ ^y ]]; then
			while true; do
				echo '1) Install as a Homebrew package (default)'
				echo '2) Install as a Ruby gem'
				echo '3) Cancel Install'
				read -p ': ' input
				echo $input

				if [[ "$input" == '' ]]; then
					install='Homebrew'; break;	
				else
					case $input in
					    1) install='Homebrew';break;;
					    2) install='Ruby';break;;
					    3) install='Cancel';break;;
					    *) continue;;
					esac
				fi
			done
			if [[ "$install" == 'Homebrew' ]]; then
				echo 'Installing Homebrew package terminal-notifier...'
				brew install terminal-notifier > terminal-notifier.log
				if [[ "$(tail -1 terminal-notifier.log)" == '🍺'*'/usr/local/Cellar/terminal-notifier/'*'built in'* ]]; then
					LOGMESSAGE+='terminal-notifier package successfully installed, '
				fi
			elif [[ "$intall" == 'Ruby' ]]; then
				echo 'Installing gem terminal-notifier...'
				sudo gem install terminal-notifier > terminal-notifier.log
				if [ "$(tail -1 terminal-notifier.log)" == "1 gem installed" ]; then
					LOGMESSAGE+='terminal-notifier gem successfully installed, '
				fi

			fi
		fi
	fi
	echo -e "How often do you want to be reminded?\nNumber of minutes or leave blank for default (5 minutes): "
	read
	if [[ "$REPLY" == '' ]]; then
		setSetting "Remind time" "300"
	else
		setSetting "Remind time" $((REPLY*60))
	fi