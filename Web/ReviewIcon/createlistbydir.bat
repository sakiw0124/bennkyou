@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
::用來產生新的一個網站資料夾內所有series的檔案清單，要先把website資料夾建立起來
::為了website.json這個檔，還是需要跑dirpath的迴圈，假使用website2.json就可以不跑省時間

set dodirectory=Collection

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
    IF !directory! == !dodirectory! (
      call createfilelist.bat "!directory!" "!subdir_original!"
    )
  )

  set total=!total!{"website":"!directory!","series": [!series:~0,-1!]},
  set total2=!total2!{"website":"!directory!"},
  IF DEFINED series (
    echo [!series:~0,-1!] > !dirlist!
    ::要清除延遲變數，不然會一直加加加上去
    set series=!series:~0,0!
  ) ELSE echo [] > !dirlist!
)
IF DEFINED total (
  echo [!total:~0,-1!] > pathlist\website.json
) ELSE echo [] > pathlist\website.json
IF DEFINED total2 (
  echo [!total2:~0,-1!] > pathlist\website2.json
) ELSE echo [] > pathlist\website2.json
::沒辦法解決字串2047限制問題
pause