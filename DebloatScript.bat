@echo off

REM List of package names for the apps you want to remove
set "APPS=com.facebook.katana com.instagram.android com.google.android.apps.maps net.one97.paytm"

REM Variable to keep track of the number of apps removed
set "removed_count=0"

REM Loop through the list of apps and uninstall each one
for %%a in (%APPS%) do (
    REM Check if the app is installed before attempting to uninstall
    adb shell pm list packages | findstr /i "%%a" > nul
    if %errorlevel%==0 (
        REM App is installed, attempt to uninstall
        adb shell pm uninstall --user 0 "%%a"
        
        REM Check the exit status of the uninstall command
        if %errorlevel%==0 (
            echo Uninstalled: %%a
            set /a "removed_count+=1"
        ) else (
            echo Unable to uninstall: %%a
        )
    ) else (
        echo %%a is not present on the device
    )
)

echo Bloatware removal complete!
echo Total apps removed: %removed_count%