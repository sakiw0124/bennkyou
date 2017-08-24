@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
for %%i in (*) do (
    set A-%%i=%%i
    echo !A-%%i:~0,-2!
)

::Z:\Picture\素材\Icon\customicondesign.com\customicondesign-cute1\PNG\96\unlock.png

set directory=iconspedia.com
set subdir_original=Archigraphs_Comic
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir_original!.txt
cd ..\Icon\!directory!\!subdir_original!\
for /R %%i IN (*.png) DO (
  set pathtemp=%%i
  echo !pathtemp!
  set macflag=false
  ::不要MAC檔案進來
  for /F "tokens=1-10 delims=\" %%i IN ("!pathtemp!") DO (
    echo %%i,%%j,%%k,%%l,%%m,%%n,%%o,%%p,%%q,%%r
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
  echo !macflag!
  IF !macflag! == false (
  echo in
  set path=!pathtemp:Z:\Picture\素材=..!
  set path=!path:\=/!
  set file=%%~nxi
  set filedata=!filedata!{"header":"!file!","path":"!path!"},
  set /A cnt=!cnt!+1
  )
)
echo !cnt!
echo [!filedata:~0,-1!] > !iconfile!
::沒辦法解決字串2047限制問題
pause

::call createfilelist.bat "!directory!" "!subdir_original!"