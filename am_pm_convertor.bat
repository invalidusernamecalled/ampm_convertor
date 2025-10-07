@echo off

REM AM/PM CONVERTOR

set "time_str=%*"
(for /f "delims=" %%i in ('if %time_str% NEQ "" echo HELL') do if "%%i"=="HELL" goto continue) 2>NUL
(for /f "delims=" %%i in ('if "%time_str%" NEQ "" echo HELL') do if "%%i"=="HELL" goto continue) 2>NUL
echo:Encountered format error
goto :eof
:continue
for /f "delims=" %%i in ("%time_str%") do echo %%~i|findstr /rc:"^[0-9][0-9]*[:][0-9][0-9]* [AaPp][Mm]$" >NUL&&goto process_am
for /f "delims=" %%i in ("%time_str%") do echo %%~i|findstr /rc:"^[0-9][0-9]*[:][0-9][0-9]*$" >NUL&&goto process_num
:process_num
REM echO HEE HEE
for /f "tokens=1,2,3 delims=:" %%i in ("%time_str%") do set time_hour=%%i&set time_min=%%j
set time_hour=%time_hour:~-2%
set time_min=%time_min:~0,2%
if "%time_hour:~0,1%"=="0" set time_hour=%time_hour:~1,2%
if %time_hour% LEQ 11 set x=AM&goto print_time
set x=PM
if %time_hour% GTR 12 set /a time_hour=time_hour-12
:print_time
if %time_hour% LSS 10 (echo 0%time_hour%:%time_min% %x%) else (echo %time_hour%:%time_min% %x%)
goto :eof
:process_am
for /f "tokens=1,2,3 delims=: " %%i in ("%time_str%") do set time_hour=%%i&set time_min=%%j&set ampm=%%k
set time_hour=%time_hour:~-2%
set time_min=%time_min:~0,2%
if "%time_hour:~0,1%"=="0" set time_hour=%time_hour:~1,2%
if /i "%ampm%"=="Pm" set /a time_hour=time_hour+12
echo %time_hour%:%time_min%
goto :eof
