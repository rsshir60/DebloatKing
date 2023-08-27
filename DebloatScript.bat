@echo off

echo Welcome To DeBloatKing...

echo Checking for connected ADB devices...
adb devices

rem List of apps to uninstall
set "apps_to_uninstall="
set "apps_to_uninstall=%apps_to_uninstall% com.vishal2376.gitcoach
"
set "apps_to_uninstall=%apps_to_uninstall% ml.docilealligator.infinityforreddit"

rem Add more package names if needed

set /a "total_uninstalled=0"
set "start_time=%time%"

for %%a in (%apps_to_uninstall%) do (
    echo Uninstalling %%a...
    adb shell pm uninstall -k --user 0 %%a
    set /a "total_uninstalled+=1"
)

set "end_time=%time%"

echo Total %total_uninstalled% apps uninstalled.
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