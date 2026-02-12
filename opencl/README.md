## Install OpenCl on Windows

The  OpenCl package is installed when installing the GPU driver

 - OpenCl.dll is within windows system directory : C:\Windows\System32\OpenCL.dll

 - OpenCL headers are within the GPU toolbox.  For CUDA 11.8, opencl header are within: 
      C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8\include\CL

 - copy headers into  "./opencl/CL" 
 
 - Extract the import library and copy it tho the root directory
         make_openccl.bat 
         copy libOpenCL.a ..

 - It is not needed to copy OpenCL.dll into the *.exe directoty

 
    