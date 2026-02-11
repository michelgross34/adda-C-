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
    ├── src/              # Original ADDA C99 source files
    ├── src_cxx/             # Automatically converted C++ sources
    ├── fort/                # Fortran sources + build scripts
    ├── fftw/                # Windows import library generation for FFTW
    ├── converting_tools/    # Python conversion script + compatibility header
    ├── Makefile(s)          # Linux and Windows build configurations
    ├── Visual Studio project
    ├── FFTW and ADDA fortran DLLs and import libraries (*dll.a)
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
`src_cc`.

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

### `/fftw`

Contains a Windows batch script to generate an import library from the
official FFTW DLL distribution.

Since FFTW Windows binaries are distributed as DLLs without MSVC import
libraries, this script creates the required `.dll.a` file for Visual
Studio linking.

------------------------------------------------------------------------

### `/converting_tools`

Contains:

-   `fix_macro.py` --- automated C → C++ conversion script
-   `ccx.h` --- compatibility header required for C++ builds

This directory defines the entire conversion layer.

------------------------------------------------------------------------


### The root directory contains:

-   Makefiles for Linux:
    -   C99 build (original ADDA sources)  
    -   C++ build (converted sources)
-   Windows batch files for:
    -   Fortran compilation
    -   Full build process
-   Visual Studio project file

-   Windows DLLs and import libraries 

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






