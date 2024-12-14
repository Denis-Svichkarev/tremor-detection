//
// File: std.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//

// Include Files
#include "std.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &x
// Return Type  : double
//
namespace coder
{
  double b_std(const ::coder::array<double, 2U> &x)
  {
    array<double, 1U> absdiff;
    double xbar;
    double y;
    int kend;
    kend = x.size(1);
    if (x.size(1) == 0) {
      y = rtNaN;
    } else if (x.size(1) == 1) {
      if ((!rtIsInf(x[0])) && (!rtIsNaN(x[0]))) {
        y = 0.0;
      } else {
        y = rtNaN;
      }
    } else {
      int k;
      xbar = x[0];
      for (k = 2; k <= kend; k++) {
        xbar += x[k - 1];
      }

      xbar /= static_cast<double>(x.size(1));
      absdiff.set_size(x.size(1));
      for (k = 0; k < kend; k++) {
        absdiff[k] = std::abs(x[k] - xbar);
      }

      y = 0.0;
      xbar = 3.3121686421112381E-170;
      kend = x.size(1);
      for (k = 0; k < kend; k++) {
        if (absdiff[k] > xbar) {
          double t;
          t = xbar / absdiff[k];
          y = y * t * t + 1.0;
          xbar = absdiff[k];
        } else {
          double t;
          t = absdiff[k] / xbar;
          y += t * t;
        }
      }

      y = xbar * std::sqrt(y);
      y /= std::sqrt(static_cast<double>(x.size(1)) - 1.0);
    }

    return y;
  }
}

//
// File trailer for std.cpp
//
// [EOF]
//
