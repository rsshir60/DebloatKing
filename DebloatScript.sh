#!/bin/bash

# List of package names for the apps you want to remove
APPS=("com.facebook.katana" "com.instagram.android" "com.google.android.apps.maps" "net.one97.paytm")

# Variable to keep track of the number of apps removed
removed_count=0

# Loop through the list of apps and uninstall each one
for app in "${APPS[@]}"; do
    # Check if the app is installed before attempting to uninstall
    if adb shell pm list packages | grep -q "$app"; then
        # App is installed, attempt to uninstall
        adb shell pm uninstall --user 0 "$app"
        
        # Check the exit status of the uninstall command
        if [ $? -eq 0 ]; then
            echo "Uninstalled: $app"
            ((removed_count++))
        else
            echo "Unable to uninstall: $app"
        fi
    else
        echo "$app is not present on the device"
    fi
done

echo "Bloatware removal complete!"
echo "Total apps removed: $removed_count"