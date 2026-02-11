# modify the code to chonge io.h -> adda_io.h : comflict with windows <io.h>  header
# change header order in memory.c : memory.h must be the last header  

###############################################################################
# TOOLCHAIN (MinGW)
###############################################################################

CC      = gcc      # gcc for test
#CC      = mpicc    # real world

SRC_DIR = .
BUILD_DIR = bin

TARGET = $(BUILD_DIR)/adda_mpi.exe

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
# FLAGS  COMPILER
###############################################################################

CFLAGS  = -O2 -std=c11 
CFLAGS +=-I$(SRC_DIR) 
#CFLAGS += -I$(OPENCL_INCL_DIR) 

#CFLAGS += -I$(CLFFT_INCL_DIR) 
#CFLAGS += -I$(CLFFT_VERSION_INCL_DIR) 

#CFLAGS += -I$(CLBLAS_INCL_DIR) 
#CFLAGS += -I$(CLBLAS_VERSION_INCL_DIR) 

#CFLAS  += -DOPENCL
#CFLAGS += -DOCL_BLAS
CFLAGS += -DADDA_MPI
CFLAGS += -DPARALLEL


CFLAGS += -DSLICE_FFT
#CFLAGS += -DCLFFT
CFLAGS += -DFFTW

###############################################################################
# FLAGS  LINKER
###############################################################################

# DLLs import libraries from src/fort and src/fftw
LDFLAGS = \
-L$(SRC_DIR)/fort \
-L$(SRC_DIR)/fftw \
-ladda_fortran.dll \
-lfftw3-3.dll \

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
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)

###############################################################################
# COMPILATION RULE
###############################################################################

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@


###############################################################################
# CLEAN
###############################################################################

clean:
	rm -f $(BUILD_DIR)/*.o $(TARGET)



