@echo off
setlocal
if "%APPVEYOR_BUILD_FOLDER%" == "" set APPVEYOR_BUILD_FOLDER=%~dp0

if %1. == build. (
  cd %APPVEYOR_BUILD_FOLDER%\src
  mingw32-make -f Makefile.Windows CC=clang-cl all
) else (
  echo Usage: %~dp0appveyor-script.bat "build"
)



