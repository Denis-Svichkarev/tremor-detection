//
// File: minOrMax.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 14-Feb-2021 13:23:25
//

// Include Files
#include "minOrMax.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const double x[3]
//                double *ex
//                int *idx
// Return Type  : void
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
  }
}

//
// File trailer for minOrMax.cpp
//
// [EOF]
//
