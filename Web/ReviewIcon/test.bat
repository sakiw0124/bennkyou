@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo 試跑產生一個website+style檔案清單
set directory=customicondesign.com
::iconspedia.com
set subdir_original=customicondesign-flatastic4
::Archigraphs_Comic
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir_original!.txt
cd ..\Icon\!directory!\!subdir_original!\
::這樣的算法會加入MACOSX內的檔案
::for /f "tokens=1" %%i in ('dir *.png/s^|find "個檔案"') do set total=%%i
::兩次迴圈預測很慢
for /R %%i IN (*.png) DO (
  set pathtemp=%%~si
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
echo Total:!totalcnt!

set /A directcnt=!totalcnt!-50
echo !directcnt!

echo [ > !iconfile!
for /R %%i IN (*.png) DO (
  set pathtemp=%%~si
  echo !pathtemp!

  ::不要MAC檔案進來, 原本好白癡呢
  set macflag=false
  for /F "usebackq tokens=1" %%i IN (`dir "!pathtemp!"^|find "__MACOSX"`) DO (
      set key=%%i
      echo !key!
      IF DEFINED key (
         set macflag=true
      )
  )
  echo !macflag!
  IF !macflag! == false (
    set filepath=!pathtemp:Z:\Picture\素材=..!
    set filepath=!filepath:\=/!
    set file=%%~nxi
    IF !cnt! LEQ !directcnt! (
      echo {"header":"!file!","path":"!filepath!"}, >> !iconfile!
    ) ELSE (
      ::不可以用path, 採到環境變數的雷了
      set filedata=!filedata!{"header":"!file!","path":"!filepath!"},
    )
    set /A cnt=!cnt!+1
  )
)
IF DEFINED filedata (
  echo !filedata:~0,-1! >> !iconfile!
)
echo !cnt!
echo ] >> !iconfile!
::沒辦法解決字串2047限制問題
pause