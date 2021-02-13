//
// File: nullAssignment.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "nullAssignment.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <string.h>

// Function Definitions
//
// Arguments    : ::coder::array<double, 1U> &x
//                const ::coder::array<bool, 1U> &idx
// Return Type  : void
//
namespace coder
{
  namespace internal
  {
    void nullAssignment(::coder::array<double, 1U> &x, const ::coder::array<bool,
                        1U> &idx)
    {
      int k;
      int k0;
      int nxin;
      int nxout;
      nxin = x.size(0);
      nxout = 0;
      k0 = idx.size(0);
      for (k = 0; k < k0; k++) {
        nxout += idx[k];
      }

      nxout = x.size(0) - nxout;
      k0 = -1;
      for (k = 0; k < nxin; k++) {
        if ((k + 1 > idx.size(0)) || (!idx[k])) {
          k0++;
          x[k0] = x[k];
        }
      }

      if (1 > nxout) {
        nxout = 0;
      }

      x.set_size(nxout);
    }
  }
}

//
// File trailer for nullAssignment.cpp
//
// [EOF]
//
