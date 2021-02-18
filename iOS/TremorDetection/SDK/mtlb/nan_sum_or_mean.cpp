//
// File: nan_sum_or_mean.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "nan_sum_or_mean.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &x
//                double *y
//                int *c
// Return Type  : void
//
namespace coder
{
  void nan_sum_or_mean(const ::coder::array<double, 2U> &x, double *y, int *c)
  {
    *c = 0;
    if (x.size(1) == 0) {
      *y = rtNaN;
    } else {
      int vlen;
      vlen = x.size(1);
      *y = 0.0;
      for (int k = 0; k < vlen; k++) {
        double d;
        d = x[k];
        if (!rtIsNaN(d)) {
          *y += d;
          (*c)++;
        }
      }

      if (*c == 0) {
        *y = rtNaN;
      } else {
        *y /= static_cast<double>(*c);
      }
    }
  }
}

//
// File trailer for nan_sum_or_mean.cpp
//
// [EOF]
//
