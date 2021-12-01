//
// File: FFTImplementationCallback.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//
#ifndef FFTIMPLEMENTATIONCALLBACK_H
#define FFTIMPLEMENTATIONCALLBACK_H

// Include Files
#include "rtwtypes.h"
#include <cstddef>
#include <cstdlib>

// Type Definitions
namespace coder
{
  namespace internal
  {
    namespace fft
    {
      class FFTImplementationCallback
      {
       public:
        static void dobluesteinfft(const double x_data[], const int x_size[1],
          int n2blue, int nfft, const double costab_data[], const int
          costab_size[2], const double sintab_data[], const double
          sintabinv_data[], creal_T y_data[], int y_size[1]);
        static void doHalfLengthRadix2(const double x_data[], const int x_size[1],
          creal_T y_data[], int y_size[1], int unsigned_nRows, const double
          costab_data[], const int costab_size[2], const double sintab_data[]);
       protected:
        static void r2br_r2dit_trig(const creal_T x_data[], const int x_size[1],
          int n1_unsigned, const double costab_data[], const double sintab_data[],
          creal_T y_data[], int y_size[1]);
        static void b_r2br_r2dit_trig(const creal_T x_data[], const int x_size[1],
          int n1_unsigned, const double costab_data[], const double sintab_data[],
          creal_T y_data[], int y_size[1]);
        static void doHalfLengthBluestein(const double x_data[], const int
          x_size[1], creal_T y_data[], int nrowsx, int nRows, int nfft, const
          creal_T wwc_data[], const int wwc_size[1], const double costab_data[],
          const int costab_size[2], const double sintab_data[], const double
          costabinv_data[], const double sintabinv_data[]);
      };
    }
  }
}

#endif

//
// File trailer for FFTImplementationCallback.h
//
// [EOF]
//
