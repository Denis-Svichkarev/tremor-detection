//
// File: nanmean.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//

// Include Files
#include "nanmean.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &varargin_1
// Return Type  : double
//
namespace coder
{
  double nanmean(const ::coder::array<double, 2U> &varargin_1)
  {
    double y;
    if (varargin_1.size(1) == 0) {
      y = rtNaN;
    } else {
      int c;
      int vlen;
      vlen = varargin_1.size(1);
      y = 0.0;
      c = 0;
      for (int k = 0; k < vlen; k++) {
        double d;
        d = varargin_1[k];
        if (!rtIsNaN(d)) {
          y += d;
          c++;
        }
      }

      if (c == 0) {
        y = rtNaN;
      } else {
        y /= static_cast<double>(c);
      }
    }

    return y;
  }
}

//
// File trailer for nanmean.cpp
//
// [EOF]
//
