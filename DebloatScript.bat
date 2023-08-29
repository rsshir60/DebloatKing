@echo off
setlocal enabledelayedexpansion

echo Welcome To DeBloatKing...

rem Check for connected ADB devices
echo Checking for connected ADB devices...
adb devices

rem Define bloatware arrays
set "mi_bloatware= com.mi.global.bbs com.mi.global.shop com.miui.analytics com.miui.bugreport com.miui.cleanmaster"
set "samsung_bloatware= com.samsung.android.calendar com.samsung.android.email.provider com.samsung.android.game.gamehome"
set "vivo_bloatware= com.vivo.easyshare com.vivo.smartmultiwindow com.vivo.vivospace"
set "realme_bloatware= com.realme.community com.coloros.soundrecorder com.facebook.appmanager"
set "oneplus_bloatware= com.oneplus.brickmode com.oneplus.account com.oneplus.community"
set "oppo_bloatware= com.coloros.wallet com.oppo.reader com.oppo.community"
set "google_bloatware= com.google.android.apps.docs com.google.android.apps.maps com.google.android.apps.photos"
set "microsoft_bloatware= com.microsoft.office.excel com.microsoft.office.powerpoint com.microsoft.office.word"

rem Display bloatware menu
echo Select the bloatware category to uninstall:
echo 1. MI Bloatware
echo 2. Samsung Bloatware
echo 3. Vivo Bloatware
echo 4. Realme Bloatware
echo 5. OnePlus Bloatware
echo 6. Oppo Bloatware
echo 7. Google Bloatware
echo 8. Microsoft Bloatware

set /p "choice=Enter your choice: "

rem Validate user's choice
if "%choice%"=="1" set "bloatware=%mi_bloatware%"
if "%choice%"=="2" set "bloatware=%samsung_bloatware%"
if "%choice%"=="3" set "bloatware=%vivo_bloatware%"
if "%choice%"=="4" set "bloatware=%realme_bloatware%"
if "%choice%"=="5" set "bloatware=%oneplus_bloatware%"
if "%choice%"=="6" set "bloatware=%oppo_bloatware%"
if "%choice%"=="7" set "bloatware=%google_bloatware%"
if "%choice%"=="8" set "bloatware=%microsoft_bloatware%"

rem Confirm user's choice
if not defined bloatware (
    echo Invalid choice.
    pause
    exit /b
)

echo Are you sure you want to proceed with uninstalling the selected bloatware category? (y/n)
set /p "confirmation="

if /i "%confirmation%"=="y" (
    set /a "total_uninstalled=0"
    set "start_time=%time%"

    rem Uninstall selected bloatware apps
    echo Uninstalling selected bloatware apps...
    for %%b in (!bloatware!) do (
        set /a "total_uninstalled+=1"
        adb shell pm uninstall -k --user 0 %%b >nul
    )

    set "end_time=%time%"

    echo Total %total_uninstalled% bloatware apps uninstalled.
    echo Started at: %start_time%
    echo Finished at: %end_time%

    rem Calculate elapsed time
    for /f "tokens=1-4 delims=:." %%a in ("%start_time%") do (
        set /a "start_seconds=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100"
    )
    for /f "tokens=1-4 delims=:." %%a in ("%end_time%") do (
        set /a "end_seconds=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100"
    )

    set /a "elapsed_seconds=%end_seconds%-%start_seconds%"
    set /a "elapsed_minutes=%elapsed_seconds% / 60"
    set /a "remaining_seconds=%elapsed_seconds% %% 60"

    echo Elapsed time: %elapsed_minutes% minutes and %remaining_seconds% seconds

    echo Thank you for using the script!
) else if /i "%confirmation%"=="n" (
    echo Bloatware uninstallation cancelled.
) else (
    echo Invalid input. Please enter 'y' or 'n'.
)

pause