## Install clFFT on Windows

- clFFT package can been downloaded here:
    https://github.com/clMathLibraries/clFFT/releases

- select the full package 
    clFFT-Full-2.12.2-Windows-x64.zip 

- copy DLLs and include headers in ./clFFT/include

- extract the import library from the dll and copy it to the root directory:
    
    - build_libclFFT.bat
    - copy libclFFT.dll.a  ..

- copy DLLs in the final *.exe directory