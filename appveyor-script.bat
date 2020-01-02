@echo off
setlocal
if "%APPVEYOR_BUILD_FOLDER%" == "" set APPVEYOR_BUILD_FOLDER=%~dp0

set PATH=%PATH%;c:\MinGW\bin
set PORTAUDIO_ROOT=./windows/portaudio
set PORTAUDIO_LIB=./windows/Release/bin/libportaudio_x86.a
set LIBSAMPLERATE_ROOT=./windows
set SAMPLERATE_LIB=./windows/Release/bin/libsamplerate_x86.a

if %1. == build. (
  cd %APPVEYOR_BUILD_FOLDER%\src
  mingw32-make -f Makefile.Windows USE_MP_COMPILE=0 USE_PTHREADS=0 CC=gcc all
) else (
  echo Usage: %~dp0appveyor-script.bat "build"
)



