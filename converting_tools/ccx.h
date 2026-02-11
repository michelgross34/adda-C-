//#include "ccx.h"





#ifndef __cxx_h
#define __cxx_h


#ifndef __cplusplus
#include //////<complex.h>
//#define __USE_MINGW_ANSI_STDIO 1
typedef double double__complexcomplex;
typedef double double__complex__complex;
typedef double double__complexcomplex_t;
#define RESTRICT   restrict
#define STATIC	static
#define REGISTER  register
#endif

#ifdef __cplusplus
#define MSVC_CXX


#define doublecomplex   double__complex

#include <cstdio>



#define restrict 
#include <complex>

//#define Nmat 40


#ifdef MSVC_CXX
#define RESTRICT
#define STATIC
#define REGISTER
#else
#define RESTRICT   restrict
#define STATIC   static
#define REGISTER  register
#endif

#define NO_GITHASH
#define COMPLEX_DOUBLE double__complex

// ============================================================================
// COMPLEX NUMBERS (C99 -> C++)
// ============================================================================

#ifdef MSVC_CXX
#ifdef _WIN32
#define DLL_EXPORT extern "C" __declspec(dllexport)
#else
#define DLL_EXPORT extern "C"
#endif
#else
#define DLL_EXPORT
#endif
#ifdef MSVC_CXX

#include <complex>
#include <cmath>


#define doublecomplex_t doublecomplex

//#include <cuComplex.h>
using double__complex = std::complex<double>;
#define DC(x) double__complex((x), 0.0)





// imaginary unit
static const double__complex I(0.0, 1.0);



// C99 -> C++ mappings
#define creal(z)  ((z).real())
#define cimag(z)  ((z).imag())
#define conj(z)   (std::conj(z))
#define cabs(z)   (std::abs(z))
#define csqrt(z)  (std::sqrt(z))
#define cexp(z)   (std::exp(z))
#define ctanh(z)  (std::tanh(z))
#define cpow(a,b) (std::pow((a),(b)))
#define clog(z)    (std::log(z))

#endif // MSVC_CXX


// int + std::complex<double>
inline std::complex<double>
operator+(int lhs, const std::complex<double>& rhs)
{
	return std::complex<double>(lhs + rhs.real(), rhs.imag());
}

// std::complex<double> + int
inline std::complex<double>
operator+(const std::complex<double>& lhs, int rhs)
{
	return std::complex<double>(lhs.real() + rhs, lhs.imag());
}



// int - complex
inline std::complex<double>
operator-(int lhs, const std::complex<double>& rhs)
{
	return { lhs - rhs.real(), -rhs.imag() };
}

// complex - int
inline std::complex<double>
operator-(const std::complex<double>& lhs, int rhs)
{
	return { lhs.real() - rhs, lhs.imag() };
}


// int* complex
inline std::complex<double>
operator*(int lhs, const std::complex<double>&rhs)
{
	return { lhs * rhs.real(), lhs * rhs.imag() };
}

// complex * int
inline std::complex<double>
operator*(const std::complex<double>& lhs, int rhs)
{
	return { lhs.real() * rhs, lhs.imag() * rhs };
}


// complex * double
inline std::complex<double>
operator*(const std::complex<double>& lhs, double rhs)
{
	return { lhs.real() * rhs, lhs.imag() * rhs };
}


// int / complex
inline std::complex<double>
operator/(int lhs, const std::complex<double>& rhs)
{
	double denom = rhs.real() * rhs.real()
		+ rhs.imag() * rhs.imag();

	return {
		lhs * rhs.real() / denom,
	   -lhs * rhs.imag() / denom
	};
}


// complex / int
inline std::complex<double>
operator/(const std::complex<double>& lhs, int rhs)
{
	return { lhs.real() / rhs, lhs.imag() / rhs };
}





#define FFTW_PLAN_MANY_DFT(rank, n, howmany, in, inembed, istride, idist, \
                           out, onembed, ostride, odist, sign, flags) \
    fftw_plan_many_dft( \
        (rank), (n), (howmany), \
        (fftw_complex*)(in), (inembed), (istride), (idist), \
        (fftw_complex*)(out), (onembed), (ostride), (odist), \
        (sign), (flags) )




#define FFTW_PLAN_GURU_DFT(rank, dims, howmany_rank, howmany_dims, \
                           in, out, sign, flags) \
    fftw_plan_guru_dft( \
        (rank), (dims), \
        (howmany_rank), (howmany_dims), \
        (fftw_complex*)(in), \
        (fftw_complex*)(out), \
        (sign), (flags) )



typedef struct {
	double__complex pt[40000];
}LINE;
typedef struct {
	unsigned short pt[40000];
}LINE_USHORT;

typedef struct {
	unsigned char pt[40000];
}LINE_UCHAR;


typedef struct {
	double__complex* cpu;
	LINE* line;
	double__complex* gpu;
	int nb,
		size;
	char* name;
	int	magic;
}doublecomplex_cpu_gpu;

typedef struct {
	double* cpu;
	double* gpu;
	int
		size;
	char* name;
	int	magic;
}double_ptr;


typedef struct {
	unsigned short* cpu;
	LINE_USHORT* line;
	unsigned short* gpu;
	int nb,
		size;
	char* name;
	int	magic;
}ushort_cpu_gpu;

typedef struct {
	unsigned char* cpu;
	LINE_UCHAR* line;
	unsigned char* gpu;
	int nb,
		size;
	char* name;
	int	magic;
}uchar_cpu_gpu;

//#define complex  cxx 

#endif

#endif // __cxx_h



