@echo off
setlocal
set PATH=%PATH%;c:\MinGW\bin
set PORTAUDIO_ROOT=./windows/portaudio
set PORTAUDIO_LIB=./windows/Release/bin/libportaudio_x86.a
set LIBSAMPLERATE_ROOT=./windows
set SAMPLERATE_LIB=./windows/Release/bin/libsamplerate_x86.a
set REGEX_ROOT=c:/MinGW/include

if %1. == build. (
  gcc -v
  mingw32-make -f Makefile.Windows USE_MP_COMPILE=0 USE_PTHREADS=0 CC=gcc all
) else (
  echo Usage: %~dp0appveyor-script.bat "build"
)



