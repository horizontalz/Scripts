#!/bin/sh

# delete MacKeeper files

# Files Outside Home Folder

rm -rf /Applications/MacKeeper.app
rm- rf /Library/Preferences/.3FAD0F65-FC6E-4889-B975-B96CBF807B78
rm -rf /private/var/folders/mh/yprf0vxs3mx_n2lg3tjgqddm0000gn/T/MacKeeper*
rm -rf /private/tmp/MacKeeper*

# Files inside home folder
rm -rf /Users/$3/Library/Application\ Support/MacKeeper\ Helper
rm -rf /Users/$3/Library/Launch\ Agents/com.zeobit.MacKeeper.Helper.plist
rm -rf /Users/$3/Library/Logs/MacKeeper.log
rm -rf /Users/$3/Library/Logs/MacKeeper.log.signed
rm -rf /Users/$3/Library/Logs/SparkleUpdateLog.log
rm -rf /Users/$3/Library/Preferences/.3246584E-0CF8-4153-835D-C7D952862F9D
rm -rf /Users/$3/Library/Preferences/com.zeobit.MacKeeper.Helper.plist
rm -rf /Users/$3/Library/Preferences/com.zeobit.MacKeeper.plist
rm -rf /Users/$3/Library/Saved\ Application\ State/com.zeobit.MacKeeper.savedState
rm -rf /Users/$3/Downloads/MacKeeper*
rm -rf /Users/$3/Documents/MacKeeper*

done
