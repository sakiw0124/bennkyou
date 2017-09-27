@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo 取得目錄有多少符合顯示的檔案數量, 舊方法花費時間
set directory=iconshock.com
::iconshock.com
set subdir_original=MATERIAL
::MATERIAL
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir_original!.txt
cd ..\Icon\!directory!\!subdir_original!\
::這樣的算法會加入MACOSX內的檔案
::for /f "tokens=1" %%i in ('dir *.png/s^|find "個檔案"') do set total=%%i

set starttime=%time%
echo Start:!starttime!
for /R %%i IN (*.png) DO (
  set pathtemp=%%~si
  echo !pathtemp!
  set macflag=false
  for /F "usebackq tokens=1" %%i IN (`dir "!pathtemp!"^|find "__MACOSX"`) DO (
      set key=%%i
      echo !key!
      IF DEFINED key (
         set macflag=true
      )
  )
  IF !macflag! == false (
    set /A totalcnt=!totalcnt!+1
  )
)
set endtime=%time%
echo End:!endtime!
echo Total:!totalcnt!
pause