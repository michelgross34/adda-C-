# modify the code to chonge io.h -> adda_io.h : comflict with windows <io.h>  header
# change header order in memory.c : memory.h must be the last header  

###############################################################################
# TOOLCHAIN (MinGW)
###############################################################################

CC      = gcc      
CXX     = g++ # nvcc # g++    #
NVCC = nvcc 
#CC      = mpicc    # real world

SRC_DIR = src_cxx
BUILD_DIR = bin

TARGET = $(BUILD_DIR)/adda_seq_cxx.exe

##################################################
#   Edit the following directories 
###########################################

#OPENCL_INCL_DR = C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v12.9/include
#OPENCL_INCL_DIR = C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v12.9/include

#CLFFT_INCL_DIR= E:/msna6/clFFT-master/src/include  #E:\msna6\clFFT-master\src\include
#CLFFT_VERSION_INCL_DIR= E:/msna6/clFFT-master/src/build/include
#CLBLAS_INCL_DIR= E:/msna6/clBLAS-master/src
#CLBLAS_VERSION_INCL_DIR= E:/msna6/clBLAS-master/src/cmake-build-release_mingw64/include

###############################################################################
# FLAGS COMPILER (gcc / C)
###############################################################################

CFLAGS  = -O2 -std=c11
CFLAGS += -I/fftw    # #include <fttw3.h>
#CFLAGS += -I$(OPENCL_INCL_DIR)

#CFLAGS += -I$(CLFFT_INCL_DIR)
#CFLAGS += -I$(CLFFT_VERSION_INCL_DIR)

#CFLAGS += -I$(CLBLAS_INCL_DIR)
#CFLAGS += -I$(CLBLAS_VERSION_INCL_DIR)

#CFLAGS += -DOPENCL
#CFLAGS += -DOCL_BLAS
#CFLAGS += -DADDA_MPI
#CFLAGS += -DPARALLEL

CFLAGS += -DSLICE_FFT
#CFLAGS += -DCLFFT
CFLAGS += -DFFTW




###############################################################################
# FLAGS COMPILER (g++)
###############################################################################

CXXFLAGS  = -O2 -std=c++17
CXXFLAGS += -I/fftw  # for  fftw3.h 

#CXXFLAGS += -I$(OPENCL_INCL_DIR)

#CXXFLAGS += -I$(CLFFT_INCL_DIR)
#CXXFLAGS += -I$(CLFFT_VERSION_INCL_DIR)

#CXXFLAGS += -I$(CLBLAS_INCL_DIR)
#CXXFLAGS += -I$(CLBLAS_VERSION_INCL_DIR)

#CXXFLAGS += -DOPENCL
#CXXFLAGS += -DOCL_BLAS
#CXXFLAGS += -DADDA_MPI
#CXXFLAGS += -DPARALLEL

CXXFLAGS += -DSLICE_FFT
#CXXFLAGS += -DCLFFT
CXXFLAGS += -DFFTW


###############################################################################
# FLAGS  LINKER
###############################################################################

# DLLs import libraries from src/fort and src/fftw
# libfftw3-3.dll.a and libadda_fortran.dll.a are in root directory
LDFLAGS = -L. -ladda_fortran.dll -lfftw3-3.dll 

#LDFLAGS += -L$(SRC_DIR)/opencl -lOpenCL 
#LDFLAGS += -L$(SRC_DIR)/clFFT -lclFFT -lclFFT.dll 
#LDFLAGS += -L$(SRC_DIR)/clBLAS -lclBLAS -lclBLAS.dll 

###############################################################################
# OBJECT FILES
###############################################################################

OBJS = \
$(BUILD_DIR)/io.o \
$(BUILD_DIR)/CalculateE.o \
$(BUILD_DIR)/calculator.o \
$(BUILD_DIR)/chebyshev.o \
$(BUILD_DIR)/cmplx.o \
$(BUILD_DIR)/comm.o \
$(BUILD_DIR)/crosssec.o \
$(BUILD_DIR)/fft.o \
$(BUILD_DIR)/GenerateB.o \
$(BUILD_DIR)/igt_so.o \
$(BUILD_DIR)/interaction.o \
$(BUILD_DIR)/iterative.o \
$(BUILD_DIR)/linalg.o \
$(BUILD_DIR)/make_particle.o \
$(BUILD_DIR)/mt19937ar.o \
$(BUILD_DIR)/Romberg.o \
$(BUILD_DIR)/sinint.o \
$(BUILD_DIR)/somnec.o \
$(BUILD_DIR)/timing.o \
$(BUILD_DIR)/vars.o \
$(BUILD_DIR)/ADDAmain.o \
$(BUILD_DIR)/param.o \
$(BUILD_DIR)/memory.o \
$(BUILD_DIR)/matvec.o 
#$(BUILD_DIR)/oclcore.o \
#$(BUILD_DIR)/oclmatvec.o 





###############################################################################
# DEFAULT TARGET
###############################################################################

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

###############################################################################
# LINK
###############################################################################

$(TARGET): $(BUILD_DIR) $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET) $(LDFLAGS)



###############################################################################
# CLEAN
###############################################################################

clean:
	rm -f $(BUILD_DIR)/*.o $(TARGET)



###############################################################################
# COMPILATION RULE
###############################################################################

#$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
#	$(CC) $(CFLAGS) -c $< -o $@


###############################################################################
# C++ FILES — EXPLICIT RULES (GNU make + g++)
###############################################################################

$(BUILD_DIR)/ADDAmain.o: $(SRC_DIR)/ADDAmain.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/io.o: $(SRC_DIR)/io.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/CalculateE.o: $(SRC_DIR)/CalculateE.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/calculator.o: $(SRC_DIR)/calculator.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/chebyshev.o: $(SRC_DIR)/chebyshev.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/cmplx.o: $(SRC_DIR)/cmplx.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/comm.o: $(SRC_DIR)/comm.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/crosssec.o: $(SRC_DIR)/crosssec.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/fft.o: $(SRC_DIR)/fft.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/GenerateB.o: $(SRC_DIR)/GenerateB.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/igt_so.o: $(SRC_DIR)/igt_so.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/interaction.o: $(SRC_DIR)/interaction.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/linalg.o: $(SRC_DIR)/linalg.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/make_particle.o: $(SRC_DIR)/make_particle.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/memory.o: $(SRC_DIR)/memory.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/mt19937ar.o: $(SRC_DIR)/mt19937ar.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/param.o: $(SRC_DIR)/param.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/Romberg.o: $(SRC_DIR)/Romberg.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/sinint.o: $(SRC_DIR)/sinint.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/somnec.o: $(SRC_DIR)/somnec.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/timing.o: $(SRC_DIR)/timing.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/vars.o: $(SRC_DIR)/vars.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/matvec.o: $(SRC_DIR)/matvec.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/iterative.o: $(SRC_DIR)/iterative.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@



###############################################################################
# C FILES — EXPLICIT RULES (GNU make + gcc)
###############################################################################

# adda_io is not used 
#$(BUILD_DIR)/adda_io.o: $(SRC_DIR)/adda_io.c
#	mkdir -p $(BUILD_DIR)
#	$(CC) $(CFLAGS) -c $< -o $@



