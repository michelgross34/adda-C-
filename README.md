# ADDA C++ Port (Automated C99 → C++ Conversion)

This repository is a fork of the original ADDA project. It provides an
automated and reproducible C99-to-C++ conversion layer designed to:

-   Enable compilation with C++ compilers such as `g++`
-   Enable compilation with Microsoft toolchains (MSVC)
-   Avoid manual code edits that would complicate future synchronization
    with upstream ADDA
-   Maintain structural compatibility with future official ADDA releases

The conversion process is deterministic and script-driven to minimize
divergence from upstream sources.

------------------------------------------------------------------------

## Repository Structure

    /
    ├── src_cc/              # Original ADDA C99 source files
    ├── src_cxx/             # Automatically converted C++ sources
    ├── fort/                # Fortran sources + build scripts
    ├── fftw/                # Windows import library generation for FFTW and FFTW header
    ├── clff/                # Windows import library generation for clFFT and cFFT headers (/include)
    ├── clBLAS/              # Windows import library generation for clBLAS and clBLAS headers (/include)
    ├── opencl/              # Windows import library generation for OpenCl and OpenCl headers (/CL) 
    ├── converting_tools/    # Python conversion script + compatibility header
    ├── Makefile(s)          # Linux and Windows build configurations
    ├── Visual Studio project
    ├── FFTW and ADDA fortran DLLs and import libraries (*dll.a)
    ├── .../                 # other official ADDA sub-directories 

------------------------------------------------------------------------

## Conversion Strategy

The C → C++ conversion is performed automatically to ensure:

-   No manual rewriting of logic
-   Minimal maintenance overhead
-   Compatibility with future ADDA updates

### Conversion Workflow

1.  Copy `*.c` files from `src_cc/`
2.  Rename to `*.cpp`
3.  Run the Python conversion script:

```{=html}
<!-- -->
```
    converting_tools/fix_macro.py

4.  Include the compatibility header:

```{=html}
<!-- -->
```
    converting_tools/cxx.h

The header `cxx.h` resolves C/C++ incompatibilities (macros, symbol
linkage, etc.) required for clean C++ compilation.

No semantic rewriting of ADDA is performed.

------------------------------------------------------------------------

## Directory Details

### `/src_cc`

Contains the original C99 ADDA source files.

These remain untouched to allow straightforward synchronization with
upstream ADDA.

------------------------------------------------------------------------

### `/src_cxx`

Contains the automatically converted C++ source files generated from
`src`.

These are intended for: - `g++` compilation on Linux - MSVC compilation
on Windows

------------------------------------------------------------------------

### `/fort`

Contains the Fortran source code required by ADDA.

Includes:

-   Linux Makefile to build a static Fortran library
-   Windows `.bat` script to build:
    -   Fortran DLL
    -   Associated import library `.dll.a` 

This allows linking from both GCC/G++ and MSVC environments.

------------------------------------------------------------------------

### `/fftw` `/opencl`  `/clFFT `  `/clBLAS `

Theses directories contains Windows batch scripts that generate GNU import libraries (*.dll.a) from the official DLL distributions of FFTW, OpenCL, clFFT, and clBLAS.

Since the Windows binaries of FFTW are distributed as DLLs without accompanying MSVC import libraries, these scripts create the required .dll.a files for linking with GCC/MinGW/MSVC and compatible toolchains on Windows.

These subdirectories also serve as placeholders for the corresponding header directories (/include and /CL).

------------------------------------------------------------------------

### `/converting_tools`

Contains:

-   `fix_macro.py` --- automated C → C++ conversion script
-   `ccx.h` --- compatibility header required for C++ builds

This directory defines the entire conversion layer.

------------------------------------------------------------------------

### `/.`  The root directory contains:

-   Makefiles for Linux:
    -   C99 build (original ADDA sources )  
    -   C++ build (converted sources)
-   Makefiles for Windows for mingw compilers:
    -   C99 build (original ADDA sources)  
    -   C++ build (converted sources)

-   CMakeLists.txt project files for Linux
    -   C99 build (original ADDA sources )  
    -   C++ build (converted sources)
-   CMakeLists.txt project files for Windows  
    -   C99 build for mingw compilers
    -   C++ build for mingw and MSVC compilers
    
-   Visual Studio project file.

-   Windows DLLs and import libraries. 
 
 The root directory can be good place holder for all DLLs and imports library. I have for example: 
 - 11/02/2026  15:27           134 109 adda_fortran.dll
 - 12/02/2026  12:59        19 111 424 clBLAS.dll
 - 08/02/2026  16:39         1 275 013 libclFFT.dll
 - 01/02/2026  16:25         2 712 765 libfftw3-3.dll
 - 11/02/2026  15:16           107 110 libadda_fortran.a
 - 11/02/2026  15:27            13 774 libadda_fortran.dll.a
 - 12/02/2026  11:45           133 890 libclBLAS.dll.a
 - 12/02/2026  11:44            28 874 libclFFT.dll.a
 - 11/02/2026  15:18           182 028 libfftw3-3.dll.a
 - 12/02/2026  11:46            97 204 libOpenCL.a

With all DLLs at the same place, it is easy to copy them in the exe directory. 
               


------------------------------------------------------------------------

## Windows Support

To simplify Windows compilation:

The root directory includes: - Prebuilt Fortran DLL - Associated import
library - FFTW DLL - FFTW import library

This allows building ADDA (C99 or C++) directly in Visual Studio without
requiring manual DLL import generation.

------------------------------------------------------------------------

## Linux Support

Under Linux you may:

-   Build original ADDA in C99 using GCC
-   Build converted ADDA in C++ using G++
-   Compile Fortran components as static libraries
-   Link against system FFTW

------------------------------------------------------------------------

## Design Philosophy

This fork:

-   Does not rewrite ADDA in idiomatic C++
-   Does not refactor core algorithms
-   Preserves original ADDA logic
-   Adds a thin automated compatibility layer

The objective is portability and toolchain flexibility, not redesign.

------------------------------------------------------------------------

## Intended Use Cases

-   Compilation with non-GCC compilers
-   Integration into C++-based simulation frameworks
-   Windows native builds using MSVC
-   Controlled experimental modernization without breaking upstream
    compatibility

------------------------------------------------------------------------

## Maintenance Model

When a new ADDA release is published:

1.  Replace contents of `src_cxx/` with upstream sources
2.  Re-run `fix_macro.py`
3.  Copy  `ccx.h` --- compatibility header
4.  Rebuild `src_cxx/`

No manual porting should be required.

------------------------------------------------------------------------

## Disclaimer

This repository is an independent fork and is not affiliated with the
official ADDA maintainers.

All original algorithmic content belongs to the ADDA authors.

This fork provides only:

-   Automated C++ conversion tooling
-   Cross-platform build infrastructure
-   Windows compatibility enhancements






