#!/bin/bash

# List of package names for the apps you want to remove
APPS=("com.miui.analytics" "com.xiaomi.ab" "com.google.android.apps.maps" "com.xiaomi.ab" "com.xiaomi.miplay_client" "com.android.bips" "com.android.bookmarkprovider" "com.android.browser" "com.android.calendar" "com.android.emergency" "com.android.wallpaper.livepicker" "com.google.android.apps.docs" "com.google.android.apps.maps" "com.google.android.apps.maps" "com.google.android.apps.meetings" "com.google.android.apps.wellbeing" "com.google.android.feedback" "com.google.android.gms.location.history" "com.google.android.marvin.talkback" "com.google.android.music" "com.google.android.printservice.recommendation" "com.google.android.videos" "com.mi.health" "com.mi.globalTrendNews" "com.mi.webkit.core" "com.mipay.wallet.id" "com.mipay.wallet.in" "com.miui.bugreport" "com.miui.compass" "com.miui.fm" "com.miui.huanji" "com.miui.hybrid" "com.miui.mishare.connectivity" "com.miui.notes" "com.miui.player" "com.miui.weather2" "com.xiaomi.glgm" "com.xiaomi.joyose" "com.xiaomi.mipicks" "com.xiaomi.scanner" "cn.wps.xiaomi.abroad.lite" "com.autonavi.minimap" "com.duokan.phone.remotecontroller" "in.amazon.mShop.android.shopping" "com.netflix.partner.activation" "com.netflix.mediaclient" "com.opera.app.news" "com.opera.branding" "com.sec.android.app.chromecustomizations" "com.google.android.apps.tachyon" "com.google.android.printservice.recommendation" "com.google.ar.lens" "com.sec.android.easyonehand" "com.samsung.android.drivelink.stub" "com.sec.android.app.sbrowser" "com.samsung.ecomm.global" "com.samsung.android.widgetapp.yahooedge.sport" "com.samsung.android.samsungpassautofill" "com.samsung.android.spay" "com.samsung.android.wellbeing" "com.samsung.android.kidsinstaller" )

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