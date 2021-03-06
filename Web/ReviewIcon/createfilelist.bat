@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set directory=%1
set subdir_original=%2
::echo !directory! !subdir_original!
set subdir=!subdir_original: =_!
set iconfile=..\..\..\ReviewIcon\filelist\!directory!\!subdir!.json
cd ..\Icon\!directory!\!subdir_original!\

::第一圈算出有多少檔案,才能分開直接寫與50個以內組字串寫
for /F "usebackq tokens=1" %%i IN (`dir /S/B *.png^|find /V "__MACOSX"`) DO (
  set /A totalcnt=!totalcnt!+1
)
set /A directcnt=!totalcnt!-50

echo [ > !iconfile!
for /F "usebackq delims=" %%i IN (`dir /S/B *.png^|find /V "__MACOSX"`) DO (
  ::在D槽下為啥就不能用短路徑呢
  set pathtemp=%%~si
  ::不可以用path, 採到環境變數的雷了，下面的路徑複製到哪就必須修改
  set filepath=!pathtemp:D:\Saki\Pictures\素材=..!
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

IF DEFINED filedata (
  echo !filedata:~0,-1! >> !iconfile!
)
echo ] >> !iconfile!
::以上可以解決字串2047限制問題（分大小用不同方式寫入json）