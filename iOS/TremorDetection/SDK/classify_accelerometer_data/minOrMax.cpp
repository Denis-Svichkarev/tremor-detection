//
// File: minOrMax.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 17:28:01
//

// Include Files
#include "minOrMax.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &x
// Return Type  : double
//
namespace coder
{
  namespace internal
  {
  void maximum(const double x[3], double *ex, int *idx)
      {
        int k;
        if (!rtIsNaN(x[0])) {
          *idx = 1;
        } else {
          bool exitg1;
          *idx = 0;
          k = 2;
          exitg1 = false;
          while ((!exitg1) && (k < 4)) {
            if (!rtIsNaN(x[k - 1])) {
              *idx = k;
              exitg1 = true;
            } else {
              k++;
            }
          }
        }

        if (*idx == 0) {
          *ex = x[0];
          *idx = 1;
        } else {
          int i;
          *ex = x[*idx - 1];
          i = *idx + 1;
          for (k = i; k < 4; k++) {
            double d;
            d = x[k - 1];
            if (*ex < d) {
              *ex = d;
              *idx = k;
            }
          }
        }
      }
  
    double maximum(const ::coder::array<double, 2U> &x)
    {
      double ex;
      int n;
      n = x.size(1);
      if (x.size(1) <= 2) {
        if (x.size(1) == 1) {
          ex = x[0];
        } else if ((x[0] < x[1]) || (rtIsNaN(x[0]) && (!rtIsNaN(x[1])))) {
          ex = x[1];
        } else {
          ex = x[0];
        }
      } else {
        int idx;
        int k;
        if (!rtIsNaN(x[0])) {
          idx = 1;
        } else {
          bool exitg1;
          idx = 0;
          k = 2;
          exitg1 = false;
          while ((!exitg1) && (k <= x.size(1))) {
            if (!rtIsNaN(x[k - 1])) {
              idx = k;
              exitg1 = true;
            } else {
              k++;
            }
          }
        }

        if (idx == 0) {
          ex = x[0];
        } else {
          ex = x[idx - 1];
          idx++;
          for (k = idx; k <= n; k++) {
            double d;
            d = x[k - 1];
            if (ex < d) {
              ex = d;
            }
          }
        }
      }

      return ex;
    }

    //
    // Arguments    : const ::coder::array<double, 2U> &x
    // Return Type  : double
    //
    double minimum(const ::coder::array<double, 2U> &x)
    {
      double ex;
      int n;
      n = x.size(1);
      if (x.size(1) <= 2) {
        if (x.size(1) == 1) {
          ex = x[0];
        } else if ((x[0] > x[1]) || (rtIsNaN(x[0]) && (!rtIsNaN(x[1])))) {
          ex = x[1];
        } else {
          ex = x[0];
        }
      } else {
        int idx;
        int k;
        if (!rtIsNaN(x[0])) {
          idx = 1;
        } else {
          bool exitg1;
          idx = 0;
          k = 2;
          exitg1 = false;
          while ((!exitg1) && (k <= x.size(1))) {
            if (!rtIsNaN(x[k - 1])) {
              idx = k;
              exitg1 = true;
            } else {
              k++;
            }
          }
        }

        if (idx == 0) {
          ex = x[0];
        } else {
          ex = x[idx - 1];
          idx++;
          for (k = idx; k <= n; k++) {
            double d;
            d = x[k - 1];
            if (ex > d) {
              ex = d;
            }
          }
        }
      }

      return ex;
    }
  }
}

//
// File trailer for minOrMax.cpp
//
// [EOF]
//
