//
// File: FFTImplementationCallback.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 20:13:16
//
#ifndef FFTIMPLEMENTATIONCALLBACK_H
#define FFTIMPLEMENTATIONCALLBACK_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include <cstddef>
#include <cstdlib>

// Type Definitions
namespace coder
{
  namespace internal
  {
    class FFTImplementationCallback
    {
     public:
      static void get_algo_sizes(int nfft, bool useRadix2, int *n2blue, int
        *nRows);
      static void generate_twiddle_tables(int nRows, bool useRadix2, ::coder::
        array<double, 2U> &costab, ::coder::array<double, 2U> &sintab, ::coder::
        array<double, 2U> &sintabinv);
      static void r2br_r2dit_trig(const ::coder::array<double, 1U> &x, int
        n1_unsigned, const ::coder::array<double, 2U> &costab, const ::coder::
        array<double, 2U> &sintab, ::coder::array<creal_T, 1U> &y);
      static void dobluesteinfft(const ::coder::array<double, 1U> &x, int n2blue,
        int nfft, const ::coder::array<double, 2U> &costab, const ::coder::array<
        double, 2U> &sintab, const ::coder::array<double, 2U> &sintabinv, ::
        coder::array<creal_T, 1U> &y);
     protected:
      static void r2br_r2dit_trig_impl(const ::coder::array<creal_T, 1U> &x, int
        unsigned_nRows, const ::coder::array<double, 2U> &costab, const ::coder::
        array<double, 2U> &sintab, ::coder::array<creal_T, 1U> &y);
      static void doHalfLengthRadix2(const ::coder::array<double, 1U> &x, ::
        coder::array<creal_T, 1U> &y, int unsigned_nRows, const ::coder::array<
        double, 2U> &costab, const ::coder::array<double, 2U> &sintab);
      static void doHalfLengthBluestein(const ::coder::array<double, 1U> &x, ::
        coder::array<creal_T, 1U> &y, int nrowsx, int nRows, int nfft, const ::
        coder::array<creal_T, 1U> &wwc, const ::coder::array<double, 2U> &costab,
        const ::coder::array<double, 2U> &sintab, const ::coder::array<double,
        2U> &costabinv, const ::coder::array<double, 2U> &sintabinv);
    };
  }
}

#endif

//
// File trailer for FFTImplementationCallback.h
//
// [EOF]
//
