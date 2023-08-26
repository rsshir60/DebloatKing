@echo off
echo Checking for connected devices...
adb devices > temp.txt
set /p adb_output=<temp.txt

if "%adb_output%"=="List of devices attached" (
    echo No devices found.
    pause
) else (
    echo Device found.

    set /p remove_apps=Do you want to remove bloatware / system apps? (y/n)
    
    if /i "%remove_apps%"=="y" (
        echo Removing apps...

        setlocal enabledelayedexpansion

        set apps_to_remove=
        set "apps_to_remove=!apps_to_remove! com.android.chrome com.google.android.apps.docs com.google.android.videos com.google.android.music com.google.android.apps.books com.google.android.play.games com.google.android.apps.tachyon com.google.android.apps.magazines com.google.android.apps.fitness com.google.android.apps.plus com.google.android.videos com.google.android.apps.photos com.google.android.apps.artsandculture com.google.android.apps.googleassistant com.google.android.earth com.google.android.apps.finance com.google.android.apps.maps com.google.android.apps.translate"
        
        set apps_to_remove=!apps_to_remove! "com.mi.global.bbs" "com.mi.global.shop" "com.mi.globalTrendNews" "com.xiaomi.midrop" "com.mi.globalbrowser" "com.xiaomi.micloudsync" "com.xiaomi.payment" "com.miui.videoplayer" "com.miui.videoplayer.overlay" "com.miui.contentcatcher" "com.xiaomi.ab" "com.xiaomi.joyose" "com.miui.analytics" "com.miui.systemAdSolution" "com.xiaomi.joyoseService" "com.miui.yellowpage" "com.miui.msa.global" "com.miui.hybrid" "com.miui.personalassistant" "com.miui.cleanmaster" "com.miui.weather2" "com.miui.bugreport" "com.miui.daemon" "com.miui.fm" "com.miui.virtualsim" "com.mipay.wallet.id" "com.xiaomi.smarthome" "com.xiaomi.o2o" "com.xiaomi.tinyappclient" "com.xiaomi.scanner" "com.xiaomi.pass" "com.miui.newhome" "com.miui.yellowpage"
        set apps_to_remove=!apps_to_remove! "com.vivo.appcloner" "com.vivo.imanager" "com.vivo.musicparty" "com.vivo.vchat" "com.kingsoft.office.ksoviewer" "com.vivo.cloud" "com.vivo.music" "com.vivo.video"
        set apps_to_remove=!apps_to_remove! "com.samsung.android.arzone" "com.samsung.android.bixby" "com.samsung.android.game.gamelaunchr" "com.sec.android.app.samsungapps" "com.sec.android.app.samsungapps.galaxystore" "com.samsung.android.providers.downloads.ui" "com.samsung.android.health" "com.samsung.android.samsungpay"
        set apps_to_remove=!apps_to_remove! "com.oneplus.applocker" "com.oneplus.camera" "com.oneplus.gallery" "com.oneplus.switch" "com.oneplus.weather" "com.oneplus.shelf" "com.oneplus.zenmode"
        set apps_to_remove=!apps_to_remove! "com.realme.gamespace" "com.heytap.cloud" "com.heytap.launcher" "com.heytap.security" "com.heytap.theme" "com.realme.music" "com.realme.recorder" "com.realme.videoeditor"
        
        set "apps_to_remove=!apps_to_remove! com.microsoft.office.outlook com.microsoft.skydrive com.microsoft.office.word com.microsoft.office.excel com.microsoft.office.powerpoint com.microsoft.office.onenote com.microsoft.teams com.microsoft.office.outlook com.microsoft.office.excel com.microsoft.office.powerpoint com.microsoft.office.onenote"
        
        set total_apps_removed=0
        set start_time=!time!
        
        for %%a in (!apps_to_remove!) do (
            echo %%a | findstr /i /c:"%%~a" > nul
            if not errorlevel 1 (
                adb shell pm uninstall -k --user 0 %%a
                if not errorlevel 1 (
                    echo Removed: %%a
                    set /a total_apps_removed+=1
                ) else (
                    echo Unable to remove: %%a
                )
            )
        )
        
        set end_time=!time!
        setlocal disabledelayedexpansion

        echo Total apps removed: %total_apps_removed%
        echo Start Time: %start_time%
        echo End Time: %end_time%

        echo Thank you for using this script to support open source projects!
    ) else (
        echo Bloatware removal cancelled.
    )
    
    pause
)