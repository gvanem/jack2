@echo off
setlocal
::
:: Set env-vars for 'MinGW' + 'mingw32-make'
::
set PATH=c:\msys64\MinGW32\bin;c:\msys64\usr\bin;%PATH%

::
:: Build with the bundled 'portaudio'
::
set PORTAUDIO_ROOT=./windows/portaudio
set PORTAUDIO_LIB=./windows/Release/bin/libportaudio_x86.a

::
:: Build with the bundled 'libsamplerate'
::
set SAMPLERATE_ROOT=./windows
set SAMPLERATE_LIB=./windows/Release/bin/libsamplerate_x86.a

::
:: Do not build for Pthreads
::
set MAKE=make -f Makefile.Windows USE_PTHREADS=0

if %1. == build. (
  gcc -v
  %MAKE% CC=gcc all
  goto :EOF
)

echo Usage: %~dp0appveyor-script.bat "build"



