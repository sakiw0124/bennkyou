@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo 變數之變數
for %%i in (*) do (
    set A-%%i=%%i
    echo !A-%%i:~0,-2!
)

echo 判斷字串是否為空
IF DEFINED total (
  echo 不是空的
) ELSE (
  echo 空的
)
pause