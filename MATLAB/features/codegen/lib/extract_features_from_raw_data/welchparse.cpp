//
// File: welchparse.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 20:13:16
//

// Include Files
#include "welchparse.h"
#include "extract_features_from_raw_data_internal_types.h"
#include "extract_features_from_raw_data_rtwutil.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <cmath>
#include <math.h>
#include <string.h>

// Function Declarations
static int div_s32_floor(int numerator, int denominator);

// Function Definitions
//
// Arguments    : int numerator
//                int denominator
// Return Type  : int
//
static int div_s32_floor(int numerator, int denominator)
{
  unsigned int absNumerator;
  int quotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
  } else {
    unsigned int absDenominator;
    unsigned int tempAbsQuotient;
    bool quotientNeedsNegation;
    if (numerator < 0) {
      absNumerator = ~static_cast<unsigned int>(numerator) + 1U;
    } else {
      absNumerator = static_cast<unsigned int>(numerator);
    }

    if (denominator < 0) {
      absDenominator = ~static_cast<unsigned int>(denominator) + 1U;
    } else {
      absDenominator = static_cast<unsigned int>(denominator);
    }

    quotientNeedsNegation = ((numerator < 0) != (denominator < 0));
    tempAbsQuotient = absNumerator / absDenominator;
    if (quotientNeedsNegation) {
      absNumerator %= absDenominator;
      if (absNumerator > 0U) {
        tempAbsQuotient++;
      }

      quotient = -static_cast<int>(tempAbsQuotient);
    } else {
      quotient = static_cast<int>(tempAbsQuotient);
    }
  }

  return quotient;
}

//
// Arguments    : const ::coder::array<double, 2U> &x1
//                ::coder::array<double, 1U> &x
//                double *M
//                ::coder::array<double, 1U> &win
//                double *noverlap
//                double *k
//                double *L
//                struct_T *options
// Return Type  : void
//
namespace coder
{
  namespace signal
  {
    namespace internal
    {
      namespace spectral
      {
        void welchparse(const ::coder::array<double, 2U> &x1, ::coder::array<
                        double, 1U> &x, double *M, ::coder::array<double, 1U>
                        &win, double *noverlap, double *k, double *L, struct_T
                        *options)
        {
          static const char cv[8] = { 'o', 'n', 'e', 's', 'i', 'd', 'e', 'd' };

          array<double, 2U> y;
          array<double, 1U> b_win;
          double f;
          int b_L;
          int b_M;
          int b_noverlap;
          int eint;
          int i;
          int nx;
          x.set_size(x1.size(1));
          nx = x1.size(1);
          for (i = 0; i < nx; i++) {
            x[i] = x1[i];
          }

          b_M = x1.size(1);
          b_L = static_cast<int>(std::floor(static_cast<double>(x1.size(1)) /
            4.5));
          b_noverlap = static_cast<int>(std::floor(0.5 * static_cast<double>(b_L)));
          if (std::fmod(static_cast<double>(b_L), 2.0) == 0.0) {
            nx = static_cast<int>(std::floor(static_cast<double>(b_L) / 2.0 -
              1.0));
            y.set_size(1, (nx + 1));
            for (i = 0; i <= nx; i++) {
              y[i] = i;
            }

            win.set_size(y.size(1));
            nx = y.size(1);
            for (i = 0; i < nx; i++) {
              win[i] = 6.2831853071795862 * (y[i] / (static_cast<double>(b_L) -
                1.0));
            }

            nx = win.size(0);
            for (int b_k = 0; b_k < nx; b_k++) {
              win[b_k] = std::cos(win[b_k]);
            }

            nx = win.size(0);
            for (i = 0; i < nx; i++) {
              win[i] = 0.54 - 0.46 * win[i];
            }

            b_win.set_size(((win.size(0) + div_s32_floor(1 - win.size(0), -1)) +
                            1));
            nx = win.size(0);
            for (i = 0; i < nx; i++) {
              b_win[i] = win[i];
            }

            nx = div_s32_floor(1 - win.size(0), -1);
            for (i = 0; i <= nx; i++) {
              b_win[i + win.size(0)] = win[(win.size(0) - i) - 1];
            }

            win.set_size(b_win.size(0));
            nx = b_win.size(0);
            for (i = 0; i < nx; i++) {
              win[i] = b_win[i];
            }
          } else {
            int b_k;
            int i1;
            int loop_ub;
            nx = static_cast<int>(std::floor((static_cast<double>(b_L) + 1.0) /
              2.0 - 1.0));
            y.set_size(1, (nx + 1));
            for (i = 0; i <= nx; i++) {
              y[i] = i;
            }

            win.set_size(y.size(1));
            nx = y.size(1);
            for (i = 0; i < nx; i++) {
              win[i] = 6.2831853071795862 * (y[i] / (static_cast<double>(b_L) -
                1.0));
            }

            nx = win.size(0);
            for (b_k = 0; b_k < nx; b_k++) {
              win[b_k] = std::cos(win[b_k]);
            }

            nx = win.size(0);
            for (i = 0; i < nx; i++) {
              win[i] = 0.54 - 0.46 * win[i];
            }

            if (1 > win.size(0) - 1) {
              i = 0;
              b_k = 1;
              i1 = -1;
            } else {
              i = win.size(0) - 2;
              b_k = -1;
              i1 = 0;
            }

            nx = div_s32_floor(i1 - i, b_k);
            b_win.set_size(((win.size(0) + nx) + 1));
            loop_ub = win.size(0);
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_win[i1] = win[i1];
            }

            for (i1 = 0; i1 <= nx; i1++) {
              b_win[i1 + win.size(0)] = win[i + b_k * i1];
            }

            win.set_size(b_win.size(0));
            nx = b_win.size(0);
            for (i = 0; i < nx; i++) {
              win[i] = b_win[i];
            }
          }

          f = frexp(static_cast<double>(b_L), &eint);
          if (f == 0.5) {
            eint--;
          }

          f = rt_powd_snf(2.0, static_cast<double>(eint));
          if (256.0 > f) {
            f = 256.0;
          }

          options->nfft = f;
          options->Fs = rtNaN;
          options->average = true;
          options->maxhold = false;
          options->minhold = false;
          options->MIMO = false;
          options->conflevel = rtNaN;
          options->isNFFTSingle = false;
          for (i = 0; i < 8; i++) {
            options->range[i] = cv[i];
          }

          options->centerdc = false;
          *k = (static_cast<double>(x1.size(1)) - static_cast<double>(b_noverlap))
            / static_cast<double>(b_L - b_noverlap);
          if (*k < 0.0) {
            *k = std::ceil(*k);
          } else {
            *k = std::floor(*k);
          }

          *M = b_M;
          *noverlap = b_noverlap;
          *L = b_L;
        }
      }
    }
  }
}

//
// File trailer for welchparse.cpp
//
// [EOF]
//
