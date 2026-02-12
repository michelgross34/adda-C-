
## Install clBLAS on Windows  

- Download clBLAS package  here 
    https://github.com/clMathLibraries/clBLAS/releases/download/v2.12/clBLAS-2.12.0-Windows-x64.zip

- copy headers in ./clBLAS/include sub directory 

- copy clBLAS.dll in ./clBLAS   ./clBLAS sub directory 

- Extract the import library and copy it to project's root directory 
    build_libclBLAS.bat
    copy libclBLAS.dll.a ..

- copy clBLAS.dll in the final *.exe directory
