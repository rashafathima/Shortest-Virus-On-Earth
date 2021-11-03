@echo off
  @title Buscaminas
  @mode con cols=18 lines=13
  @::MineSweeper v 1
  @::Batch Game
  @::Coded by ::SmartGenius::



:load
setlocal enabledelayedexpansion
set LimX=9
set LimY=9
set IniX=0
set IniY=0
set MovX=0
set MovY=0

:init
for /l %%a in (0,1,%LimX%) do (
for /l %%b in (0,1,%LimY%) do (
set X%%aY%%b=Û
))
for /l %%m in (0,1,9) do (set M%%m=X!random:~-1!Y!random:~-1!)
set X0Y0=
set Last=Û
set Curpos=X0Y0
Goto :First

:Graphic
Call :Clear
:First
for /l %%d in (0,1,%LimY%) do (
for /l %%e in (0,1,%LimX%) do (
set Lin_%%d=!Lin_%%d!!X%%eY%%d!
))
echo.
echo. MineSweeper v 1
echo.
for /l %%f in (0,1,%LimY%) do (echo.   !Lin_%%f!)
if "%EOG%"=="True" Goto :End
keyboard
if "%errorlevel%"=="77" (call :MovX+ "%CurPos%")
if "%errorlevel%"=="75" (call :MovX- "%CurPos%")
if "%errorlevel%"=="80" (call :MovY+ "%CurPos%")
if "%errorlevel%"=="72" (call :MovY- "%CurPos%")
if "%errorlevel%"=="13" (call :Check "%CurPos%")
if "%errorlevel%"=="88" (msg * Thx for Playing MineSweeper v1 by SmartGenius&exit)
if "%errorlevel%"=="120" (msg * Thx for Playing MineSweeper v1 by SmartGenius&exit)
Goto :Graphic

:MovX+
for /f "tokens=1,2 delims=X,Y" %%p in ("%~1") do (
if "%%p"=="%LimX%" Goto :Eof
if !%~1!== set %~1=%Last%
set /a MovX=%%p+1
call set Last=%%X!MovX!Y%%q%%
set X!MovX!Y%%q=
set CurPos=X!MovX!Y%%q
)
Goto :Eof

:MovX-
for /f "tokens=1,2 delims=X,Y" %%p in ("%~1") do (
if "%%p"=="%IniX%" Goto :Eof
if !%~1!== set %~1=%Last%
set /a MovX=%%p-1
call set Last=%%X!MovX!Y%%q%%
set X!MovX!Y%%q=
set CurPos=X!MovX!Y%%q
)
Goto :Eof

:MovY+
for /f "tokens=1,2 delims=X,Y" %%p in ("%~1") do (
if "%%q"=="%LimY%" Goto :Eof
if !%~1!== set %~1=%Last%
set /a MovY=%%q+1
call set Last=%%X%%pY!MovY!%%
set X%%pY!MovY!=
set CurPos=X%%pY!MovY!
)
Goto :Eof

:MovY-
for /f "tokens=1,2 delims=X,Y" %%p in ("%~1") do (
if "%%q"=="%IniY%" Goto :Eof
if !%~1!== set %~1=%Last%
set /a MovY=%%q-1
call set Last=%%X%%pY!MovY!%%
set X%%pY!MovY!=
set CurPos=X%%pY!MovY!
)
Goto :Eof

:Check
for /l %%h in (0,1,9) do (
if "%~1"=="!M%%h!" (
set %~1=
set EOG=True
Goto :Eof
))
set %~1=°
Goto :Eof

:End
msg * You Lost !
pause>nul
exit

:Clear
for /l %%m in (0,1,%LimY%) do (set Lin_%%m=)
Goto :Eof

:NoKey
cls
echo.
echo  A file needed for the correct function
echo  of this Script is missing....
echo.
echo  It will be created...
call :keyboard
echo.
echo  Restart this Script !
echo.
pause
exit

:keyboard
(
echo n keyboard.dat
echo e 0000 4D 5A 2E 00 01 00 00 00 02 00 00 10 FF FF F0 FF
echo e 0010 FE FF 00 00 00 01 F0 FF 1C 00 00 00 00 00 00 00
echo e 0020 B4 08 CD 21 3C 00 75 02 CD 21 B4 4C CD 21
echo rcx
echo 002E
echo w0
echo q
echo.
)>keyboard.dat
type keyboard.dat|debug>NUL 2>&1
del /f/q/a "keyboard.exe">NUL 2>&1
ren keyboard.dat "keyboard.exe"
Goto :Eof