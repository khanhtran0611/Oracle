@echo off
cd C:\app09\oracle\base\product\21.0.0\clienthome_1\bin
set PATH=C:\app09\oracle\base\product\21.0.0\clienthome_1\bin;%PATH%
call C:\Windows\system32\regsvr32.exe /s %1
exit /B %ERRORLEVEL%
