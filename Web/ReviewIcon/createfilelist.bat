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
  ::不要MAC檔案進來
  set macflag=false
  for /F "tokens=1-10 delims=\" %%i IN ("!pathtemp!") DO (
    IF %%i == __MACOSX set macflag=true
    IF %%j == __MACOSX set macflag=true
    IF %%k == __MACOSX set macflag=true
    IF %%l == __MACOSX set macflag=true
    IF %%m == __MACOSX set macflag=true
    IF %%n == __MACOSX set macflag=true
    IF %%o == __MACOSX set macflag=true
    IF %%p == __MACOSX set macflag=true
    IF %%q == __MACOSX set macflag=true
    IF %%r == __MACOSX set macflag=true
  )
  IF !macflag! == false (
    set path=!pathtemp:Z:\Picture\素材=..!
    set path=!path:\=/!
    set file=%%~nxi
    set filedata=!filedata!{"header":"!file!","path":"!path!"},
    set /A cnt=!cnt!+1
  )
)
echo [!filedata:~0,-1!] > !iconfile!
echo !cnt!
::沒辦法解決字串2047限制問題