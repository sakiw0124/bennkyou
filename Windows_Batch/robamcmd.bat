route print|find "10.0.2"
route print|find "老板電器"
::我不知道怎?把執行結果放入變數，只好顯示出來給你key
set /p i=請輸入interface:
set /p g=請輸入gateway:
echo route delete 10.0.0.0 > "D:\Saki\Documents\My Work\19. 微服務\老闆電器\99. 開發環境\robamroute.bat"
echo route add 172.18.0.0 mask 255.255.0.0 %g% if %i% metric 59 >> "D:\Saki\Documents\My Work\19. 微服務\老闆電器\99. 開發環境\robamroute.bat"
echo pause >> "D:\Saki\Documents\My Work\19. 微服務\老闆電器\99. 開發環境\robamroute.bat"
pause