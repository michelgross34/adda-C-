
gendef libfftw3-3.dll
dlltool -d libfftw3-3.def -l libfftw3-3.dll.a

copy libfftw3-3.dll ..
copy libfftw3-3.dll.a ..