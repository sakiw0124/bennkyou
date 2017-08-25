@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set total=
echo !total!
IF DEFINED total (
  echo 不是空的
) ELSE (
  echo 空的
)
pause