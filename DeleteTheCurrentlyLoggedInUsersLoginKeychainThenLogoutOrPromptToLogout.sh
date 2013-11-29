#!/bin/sh
####################################################################################################
#
# More information: http://macmule.com/2013/11/29/delete-the-currently-logged-in-users-login-keychain-then-logout-or-prompt-to-logout
#
# GitRepo: https://github.com/macmule/DeleteTheCurrentlyLoggedInUsersLogin.KeychainThenLogoutOrPromptToLogout
#
# License: http://macmule.com/license/
#
####################################################################################################

# HARDCODED VALUES ARE SET HERE

# If Y then prompts user to logout, else kills the loginwindow forcing a logout.
logoutPrompt=""

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 4 AND, IF SO, ASSIGN TO "caCertLocation"
if [ "$4" != "" ] && [ "$logoutPrompt" == "" ];then
    logoutPrompt=$4
fi

###
# Get the Username of the logged in user
###
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`

##
# Delete the logged in users login.keychain
##
sudo rm -rf /Users/"$loggedInUser"/Library/Keychain/login.keychain
echo "Deleted the Login Keychain for "$loggedInUser"..."

##
# If logoutPrompt = Y then, prompt the user to logout, else kill the loginwindow
##

if [ "$logoutPrompt" == "Y" ]; then
	echo "Nice logout chosen.. prompting user "$loggedInUser"..."
	(osascript -e 'tell application "System Events" to log out')
else
	echo "Nice logout not chosen.. Killing loginwindow..."
	sudo killall loginwindow
fi
