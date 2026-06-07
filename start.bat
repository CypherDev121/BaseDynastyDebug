@echo off
echo Démarrage de txAdmin...
cd /d %~dp0
"server\FXServer.exe" +set serverProfile "default"
pause
