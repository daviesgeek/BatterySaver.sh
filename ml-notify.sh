######
#
# Mountain Lion or later notification system (uses ruby gem terminal-notifier)
# Matthew Davies, Dec 12th, 2013
# http://osxdaily.com/2012/08/03/send-an-alert-to-notification-center-from-the-command-line-in-os-x/
######

	notify(){
		terminal-notifier -message "$1" -title "$2"
	}