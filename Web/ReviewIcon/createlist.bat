@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
::不加上面的東西，底下變數處理會壞掉，變數要改為!!
set file=pathlist\website.txt
echo [ > %file%
for /d %%i IN (filelist\*) DO (
  set A=%%i
  set directory=..\Icon\!A:~9!\*
  echo !directory!
  for /d %%i IN (!directory!) DO (
    set subdirtemp=%%i
    echo !subdirtemp!
    for /F "tokens=1-5 delims=\" %%i IN ('echo !subdirtemp!') DO set subdir=%%l
    set subdir=!subdir: =_!
    set iconfile=filelist\!A:~9!\!subdir!.txt
    echo [{"header":"add1.png","path":"../Icon/customicondesign.com/customicondesign-office1-reflection/png/add1.png","classid":"col_img_size256"}] > !iconfile!
    set styles=!styles!{"style":"!subdir!"},
  )
  set total=!total!{"website":"!A:~9!","styles": [!styles:~0,-1!]},
  ::要清除延遲變數，不然會一直加加加上去
  set styles=!styles:~0,0!
)
echo !total:~0,-1! >> %file%
echo ] >> %file%
::怎只有三個啦，我懷疑是字串有限制，customicondesign.com裡面太多東西了
pause