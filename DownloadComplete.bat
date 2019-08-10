@echo off
set Path=%path%;C:\Windows\system32

::%1 = Movie name, %2 tag
echo %1 
echo %2 
echo %3
echo "starting powershell"
PowerShell.exe -ExecutionPolicy Bypass -File "C:\Users\Media\GitProjects\MediaManager\MediaManager.ps1" %1 %2 %3
exit