@echo off
setlocal
if "%APPVEYOR_BUILD_FOLDER%" == "" set APPVEYOR_BUILD_FOLDER=%~dp0

if %1. == build. (
  cd %APPVEYOR_BUILD_FOLDER%\src
  c:\MinGW\bin\mingw32-make -f Makefile.Windows USE_MP_COMPILE=0 CC=cl all
) else (
  echo Usage: %~dp0appveyor-script.bat "build"
)



