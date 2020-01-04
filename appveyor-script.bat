@echo off
setlocal
::
:: Set env-vars for 'MinGW' + 'mingw32-make'
::
set PATH=c:\msys64\MinGW32\bin;c:\msys64\usr\bin;%PATH%
set MAKE=make -f Makefile.Windows USE_PTHREADS=0

::
:: Tested in Makefile.Windows.
::
set USER=AppVeyor

if %1. == build. (
  %MAKE% CC=gcc all
  goto :EOF
)

echo Usage: %~dp0appveyor-script.bat "build"



