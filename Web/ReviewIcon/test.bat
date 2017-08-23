@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
for %%i in (*) do (
    set A-%%i=%%i
    echo !A-%%i:~0,-2!
)

::Z:\Picture\素材\Icon\customicondesign.com\customicondesign-cute1\PNG\96\unlock.png

set directory=Double-JDesign
set subdir_original=Button Fest
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir_original!.txt
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
pause

call createfilelist.bat "!directory!" "!subdir_original!"