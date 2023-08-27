@echo off

echo Welcome To DeBloatKing...

echo Checking for connected ADB devices...
adb devices

echo Select the bloatware category to uninstall:
echo 1. MI Bloatware
echo 2. Samsung Bloatware
echo 3. Vivo Bloatware
echo 4. Realme Bloatware
echo 5. OnePlus Bloatware

set /p "choice=Enter your choice: "

rem Define arrays for bloatware apps
setlocal enabledelayedexpansion
set "bloatware="
if "%choice%"=="1" set "bloatware= com.mi.global.bbs com.mi.global.shop com.miui.analytics com.miui.bugreport com.miui.cleanmaster"
if "%choice%"=="2" set "bloatware= com.samsung.android.calendar com.samsung.android.email.provider com.samsung.android.game.gamehome"
if "%choice%"=="3" set "bloatware= com.vivo.easyshare com.vivo.smartmultiwindow com.vivo.vivospace"
if "%choice%"=="4" set "bloatware= com.realme.community com.coloros.soundrecorder com.facebook.appmanager"
if "%choice%"=="5" set "bloatware= com.oneplus.brickmode com.oneplus.account com.oneplus.community"

if not defined bloatware (
    echo Invalid choice.
    pause
    exit /b
)

set /a "total_uninstalled=0"
set "start_time=%time%"

for %%b in (%bloatware%) do (
    echo Uninstalling %%b...
    adb shell pm uninstall -k --user 0 %%b
    set /a "total_uninstalled+=1"
)

set "end_time=%time%"

echo Total %total_uninstalled% bloatware apps uninstalled.
echo Started at: %start_time%
echo Finished at: %end_time%

rem Calculate time difference
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
pause