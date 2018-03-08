@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
::不加上面的東西，底下變數處理會壞掉，變數要改為!!
::此bat編碼一定要是ANSI，但產生的txt也會是ANSI，內文若非英數，會造成亂碼

for /d %%i IN (filelist\*) DO (
  set directory=%%i
  set directory=!directory:~9!
  echo !directory!
  set dirlist=filelist\!directory!\000_directory.json
  set dirpath=..\Icon\!directory!\*
  ::echo !dirpath!
  for /d %%i IN (!dirpath!) DO (
    set subdirtemp=%%i
    ::echo !subdirtemp!
    for /F "tokens=1-5 delims=\" %%i IN ('echo !subdirtemp!') DO set subdir_original=%%l
    set subdir=!subdir_original: =_!
    set series=!series!{"series":"!subdir!"},


    call createfilelist.bat "!directory!" "!subdir_original!"

  )
  set total=!total!{"website":"!directory!","series": [!series:~0,-1!]},
  set total2=!total2!{"website":"!directory!"},
  echo [!series:~0,-1!] > !dirlist!
  ::要清除延遲變數，不然會一直加加加上去
  set series=!series:~0,0!
)
IF DEFINED total (
  echo [!total:~0,-1!] > pathlist\website.json
) ELSE echo [] > pathlist\website.json
IF DEFINED total2 (
  echo [!total2:~0,-1!] > pathlist\website2.json
) ELSE echo [] > pathlist\website2.json
::沒辦法解決字串2047限制問題
pause