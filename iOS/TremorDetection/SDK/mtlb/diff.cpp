//
// File: diff.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "diff.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 1U> &x
//                ::coder::array<double, 1U> &y
// Return Type  : void
//
namespace coder
{
  void diff(const ::coder::array<double, 1U> &x, ::coder::array<double, 1U> &y)
  {
    double tmp1;
    int dimSize;
    dimSize = x.size(0);
    if (x.size(0) == 0) {
      y.set_size(0);
    } else {
      int ixLead;
      ixLead = x.size(0) - 1;
      if (ixLead >= 1) {
        ixLead = 1;
      }

      if (ixLead < 1) {
        y.set_size(0);
      } else {
        y.set_size((x.size(0) - 1));
        if (x.size(0) - 1 != 0) {
          double work_data_idx_0;
          int iyLead;
          ixLead = 1;
          iyLead = 0;
          work_data_idx_0 = x[0];
          for (int m = 2; m <= dimSize; m++) {
            double d;
            tmp1 = x[ixLead];
            d = tmp1;
            tmp1 -= work_data_idx_0;
            work_data_idx_0 = d;
            ixLead++;
            y[iyLead] = tmp1;
            iyLead++;
          }
        }
      }
    }
  }
}

//
// File trailer for diff.cpp
//
// [EOF]
//
