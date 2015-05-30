#!/bin/sh

 ##### Begin Declare Variables Used by Script #####

# Declare '$defaults'.
defaults="/usr/bin/defaults"
# Define 'kickstart' and'systemsetup' variables, built in OS X script that activates and sets options for ARD.
systemsetup="/usr/sbin/systemsetup"
kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
# Define '$networksetup'.
networksetup="/usr/sbin/$networksetup"

##### End Declare Variables Used by Script #####

# Announce Firstboot script is running
osascript -e "set Volume 10"
say "Firstboot script running"
 
##### Begin Preference Setting #####

# Display login window message
VersionCheck=$(sw_vers -productVersion | cut -c 1-4)
VERSION=10.7
if [[ "$VERSION" == "$VersionCheck" ]]
	then
$defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText -string "Property of Palo Alto Unified School District"
    else
$defaults write /Library/Preferences/com.apple.loginwindow.plist LoginwindowText "Property of Palo Alto Unified School District"
fi

# Display additional information on the loginscreen
$defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Check for Wi-Fi BSD name
AIRPORT=$($networksetup -listallhardwareports | grep -A1  "Wi-Fi" | grep "Device" | cut -c 8-12)

# Set up Wifi connection
$networksetup -setairportnetwork $AIRPORT PAUSDGEN Gr@n1te!

# Set time zone and time server.
$systemsetup -setusingnetworktime on
$systemsetup -settimezone America/Los_Angeles -setnetworktimeserver time.apple.com
 
#Update NTP
ntpdate -bvs time.apple.com
 
# Activate WakeOnLAN.
$systemsetup -setwakeonnetworkaccess on
 
#Firewall Settings | 0 = Off | 1 = On For Specific Services | 2 = On For Essential Services
$defaults write /Library/Preferences/com.apple.alf globalstate -int 0
 
#Set System Sleep Preferences | 0 = Off | 15 = 15 Min | 20 = 20 Min | etc | 
pmset sleep 30
 
# Removes Time Machine from the menu
$defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup 1

# Disables Gatekeeper
/usr/sbin/spctl --master-disable
 
# Hide users with a UID below 500 from User Accounts under System Preferences.
$defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool TRUE

# Get "Wi-Fi" or "Airport" based on your OS
wservice=`/usr/sbin/$networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)'`

# Get port (usually en1)
whwport=`/usr/sbin/$networksetup -listallhardwareports | awk "/$wservice/,/Ethernet Address/" | awk 'NR==2' | cut -d " " -f 2`

# Set admin password to change Wi-Fi settings
/usr/libexec/airportd "$whwport" prefs DisconnectOnLogout=No JoinMode=Automatic JoinModeFallback=DoNothing RememberRecentNetworks=Yes RequireAdminIBSS=Yes RequireAdminNetworkChange=Yes RequireAdminPowerToggle=Yes

# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)
 
# Determine OS build number
 
sw_build=$(sw_vers -buildVersion)
 
# Checks first to see if the Mac is running 10.7.0 or higher. 
# If so, the script checks the system default user template
# for the presence of the Library/Preferences directory. Once
# found, the iCloud and Diagnostic pop-up settings are set 
# to be disabled.
 
if [[ ${osvers} -ge 7 ]]; then
 
 for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    $defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
    $defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    $defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
    $defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"      
  done
  
  
 # Checks first to see if the Mac is running 10.7.0 or higher.
 # If so, the script checks the existing user folders in /Users
 # for the presence of the Library/Preferences directory.
 #
 # If the directory is not found, it is created and then the
 # iCloud and Diagnostic pop-up settings are set to be disabled.
 
 for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ]; then
      if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
        /bin/mkdir -p "${USER_HOME}"/Library/Preferences
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]; then
        $defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
        $defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
        $defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
        $defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
      fi
    fi
  done
fi

# Adds admin group to SSH list
dseditgroup -o create -q com.apple.access_ssh
dseditgroup -o edit -a admin -t group com.apple.access_ssh

# enables SSH
launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# ARD Configuration
#Enable ARD for localadmin
$kickstart -configure -allowAccessFor -specifiedUsers
$kickstart -activate -configure -access -on -users "techsupport" -privs -all -restart -agent

# Start default installations policy
jamf policy -trigger default

#osascript -e "set Volume 10"
say "Firstboot script done."

#!/bin/sh

# Standard settings for images.
# Script is meant to be run as a postflight script in a .pkg file. Also installs startup settings script as a Launchd item which is inside the package /Contents/Resources directory.

# Checks the system default user template for the presence of 
# the Library/Preferences directory. If the directory is not found, 
# it is created.

for USER_TEMPLATE in "/System/Library/User Template"/*
  do
     if [ ! -d "${USER_TEMPLATE}"/Library/Preferences ]
      then
        mkdir -p "${USER_TEMPLATE}"/Library/Preferences
     fi
     if [ ! -d "${USER_TEMPLATE}"/Library/Preferences/ByHost ]
      then
        mkdir -p "${USER_TEMPLATE}"/Library/Preferences/ByHost
     fi
  done

# Checks the existing user folders in /Users for the presence of
# the Library/Preferences directory. If the directory is not found, 
# it is created.

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
     then 
      if [ ! -d "${USER_HOME}"/Library/Preferences ]
       then
        mkdir -p "${USER_HOME}"/Library/Preferences
        chown "${USER_UID}" "${USER_HOME}"/Library
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ ! -d "${USER_HOME}"/Library/Preferences/ByHost ]
       then
        mkdir -p "${USER_HOME}"/Library/Preferences/ByHost
        chown "${USER_UID}" "${USER_HOME}"/Library
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
	chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/ByHost
      fi
      if [ -d "${USER_HOME}"/Library/Preferences/ByHost ]
       then
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/.GlobalPreferences.*
      fi
    fi
  done

##### Begin Declare Variables Used by Script #####

# Declare 'defaults'.
defaults="/usr/bin/defaults"
# Declare directory variables.
PKG_DIR="$1/Contents/Resources"
SCRIPTS_DIR="$3/Library/Scripts/PAUSD"
LAUNCHD_DIR="$3/Library/LaunchDaemons"
PRIVETC_DIR="$3/private/etc"
PREFS_DIR="$3/Library/Preferences"
USERPREFS_DIR="$3/System/Library/User Template/English.lproj/Library/Preferences"
NONLOC_USERPREFS_DIR="$3/System/Library/User Template/Non_localized/Library/Preferences"
ROOT="$3/"
UPDATE_DYLD="$3/usr/bin/update_dyld_shared_cache" # Set variable to location of update_dyld_shared_cache command on target volume.

##### End Declare Variables Used by Script #####
 
##### Begin Preference Setting #####
 
# These settings can be set on the target volume before startup.
 
# Run update_dyld_shared_cache
$UPDATE_DYLD -universal_boot -root $ROOT
 
# Display login window as Name and Password.
$defaults write "${PREFS_DIR}/com.apple.loginwindow" SHOWFULLNAME -bool false
 
#Starts the Flurry screensaver over the login window when idle for 60 seconds
$defaults write "${PREFS_DIR}/com.apple.screensaver" loginWindowIdleTime -int 60
$defaults write "${PREFS_DIR}/com.apple.screensaver" loginWindowModulePath "/System/Library/Screen Savers/Flurry.saver"
 
# Set Safari Preferences.
$defaults write "${USERPREFS_DIR}/com.apple.Safari" HomePage "http://www.pausd.org/"
$defaults write "${USERPREFS_DIR}/com.apple.Safari" ShowStatusBar -bool YES
 
# Set Finder Preferences.
$defaults write "${USERPREFS_DIR}/com.apple.finder" ShowMountedServersOnDesktop -bool YES
$defaults write "${USERPREFS_DIR}/com.apple.finder" ShowHardDrivesOnDesktop -bool YES
$defaults write "${USERPREFS_DIR}/com.apple.finder" ShowStatusBar -bool YES

# Enables Double Click Title bar to Minimize Window
$defaults write "${NONLOC_USERPREFS_DIR}/.GlobalPreferences" AppleMiniaturizeOnDoubleClick -bool TRUE
 
# No .ds-store files on Network Shares
$defaults write "${PREFS_DIR}/com.apple.desktopservices" DSDontWriteNetworkStores true
 
# Globally Set Expanded Print Dialogue Box.
$defaults write "${PREFS_DIR}/.GlobalPreferences" PMPrintingExpandedStateForPrint -bool TRUE

# Globally Set Always Show Scroll Bars.
$defaults write "${PREFS_DIR}/.GlobalPreferences" AppleShowScrollBars -string Always

# Disable Mouse reverse scrolling.
# $defaults write "${USERPREFS_DIR}/.GlobalPreferences" com.apple.swipescrolldirection -bool false

# Set Dark UI
VersionCheck=$(sw_vers -productVersion | cut -c 1-5)
VERSION=10.10
if [[ "$VERSION" == "$VersionCheck" ]]
	then
$defaults write "${USERPREFS_DIR}/.GlobalPreferences" AppleInterfaceStyle -string Dark
fi
 
# Disable Time Machine Offers.
$defaults write "${PREFS_DIR}/com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool YES
 
# Disable Time Machine AutoBackup
$defaults write "${PREFS_DIR}/com.apple.TimeMachine" AutoBackup 0

# Firewall Settings | 0 = Off | 1 = On For Specific Services | 2 = On For Essential Services
$defaults write "${PREFS_DIR}/com.apple.alf" globalstate -int 0
