@echo off
setlocal ENABLEDELAYEDEXPANSION

REM =========================
REM CONFIGURATION
REM =========================

set FC=gfortran
set FFLAGS=-O3 -fPIC
set LDFLAGS=-shared -Wl,--out-implib,libadda_fortran.dll.a

set LIBNAME=adda_fortran
set DLL=%LIBNAME%.dll
set BUILDDIR=build

REM =========================
REM SOURCES
REM =========================

set SRC=^
cfft99D.f ^
d07hre.f ^
d09hre.f ^
d113re.f ^
d132re.f ^
dadhre.f ^
dchhre.f ^
dcuhre.f ^
dfshre.f ^
dinhre.f ^
drlhre.f ^
dtrhre.f ^
propaesplibreintadda.f ^
bessel.f90

REM =========================
REM BUILD
REM =========================

if not exist %BUILDDIR% mkdir %BUILDDIR%

echo === Compilation des objets ===

for %%F in (%SRC%) do (
    echo Compiling %%F
    %FC% %FFLAGS% -c %%F -o %BUILDDIR%\%%~nF.o
    if errorlevel 1 exit /b 1
)

echo === Edition de liens DLL ===

%FC% %LDFLAGS% -o %DLL% %BUILDDIR%\*.o
if errorlevel 1 exit /b 1

echo === Build OK ===
echo DLL     : %DLL%
echo Import  : libadda_fortran.dll.a


copy adda_fortran.dll ..
copy libadda_fortran.dll.a ..

endlocal