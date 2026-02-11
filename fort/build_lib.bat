

gendef adda_fortran.dll
dlltool -d adda_fortran.def -l libadda_fortran.a -k
copy adda_fortran.dll ..
copy libadda_fortran.dll.a ..