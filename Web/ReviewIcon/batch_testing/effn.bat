@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo 取得目錄有多少符合顯示的檔案數量, 新方法花費時間與正確性
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
for /F "usebackq tokens=1" %%i IN (`dir /S/B *.png^|find /V "__MACOSX"`) DO (
  set pathtemp=%%~si
  echo !pathtemp!
  set /A totalcnt=!totalcnt!+1
)
set endtime=%time%
echo End:!endtime!
echo Total:!totalcnt!
pause