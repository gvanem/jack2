@echo off
setlocal
if "%APPVEYOR_BUILD_FOLDER%" == "" set APPVEYOR_BUILD_FOLDER=%~dp0

SET PATH=%PATH%;c:\MinGW\bin;"c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin"

if %1. == build. (
  cd %APPVEYOR_BUILD_FOLDER%\src
  mingw32-make -f Makefile.Windows USE_MP_COMPILE=0 USE_PTHREADS=0 CC=cl all
) else (
  echo Usage: %~dp0appveyor-script.bat "build"
)



