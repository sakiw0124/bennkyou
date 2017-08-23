@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set directory=%1
set subdir_original=%2
echo !directory! !subdir_original!
set subdir=!subdir_original: =_!
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir!.txt
cd ..\Icon\!directory!\!subdir_original!\
for /R %%i IN (*.png) DO (
  set pathtemp=%%i
  set path=!pathtemp:Z:\Picture\素材=..!
  set path=!path:\=/!
  set file=%%~nxi
  set filedata=!filedata!{"header":"!file!","path":"!path!"},
)
echo [!filedata:~0,-1!] > !iconfile!
::沒辦法解決字串2047限制問題