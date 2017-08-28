@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
::產生一個website+style檔案清單，但前提是這個style已經存在000_directory.txt裡面

set directory=VistaIcons.com
set subdir_original=AeroVista
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir_original!.txt
cd ..\Icon\!directory!\!subdir_original!\
::第一圈算出有多少檔案,才能分開直接寫與50個以內組字串寫
for /R %%i IN (*.png) DO (
  set pathtemp=%%~si
  set macflag=false
  for /F "usebackq tokens=1" %%i IN (`dir "!pathtemp!"^|find "__MACOSX"`) DO (
      set key=%%i
      IF DEFINED key (
         set macflag=true
      )
  )
  IF !macflag! == false (
    set /A totalcnt=!totalcnt!+1
  )
)
set /A directcnt=!totalcnt!-50

echo [ > !iconfile!
for /R %%i IN (*.png) DO (
  set pathtemp=%%~si

  ::不要MAC檔案進來, 原本好白癡呢
  set macflag=false
  for /F "usebackq tokens=1" %%i IN (`dir "!pathtemp!"^|find "__MACOSX"`) DO (
      set key=%%i
      echo !key!
      IF DEFINED key (
         set macflag=true
      )
  )
  IF !macflag! == false (
    ::不可以用path, 採到環境變數的雷了
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
echo ] >> !iconfile!
::沒辦法解決字串2047限制問題
pause