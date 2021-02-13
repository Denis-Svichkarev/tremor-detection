//
// File: trapz.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "trapz.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &x
// Return Type  : double
//
namespace coder
{
  double trapz(const ::coder::array<double, 2U> &x)
  {
    array<double, 1U> c;
    double z;
    z = 0.0;
    if (x.size(1) > 1) {
      int i;
      int ix;
      c.set_size(x.size(1));
      ix = x.size(1);
      for (i = 0; i < ix; i++) {
        c[i] = 1.0;
      }

      c[0] = 0.5;
      c[x.size(1) - 1] = 0.5;
      ix = 0;
      i = x.size(1);
      for (int iac = 1; iac <= i; iac++) {
        for (int ia = iac; ia <= iac; ia++) {
          z += x[ia - 1] * c[ix];
        }

        ix++;
      }
    }

    return z;
  }
}

//
// File trailer for trapz.cpp
//
// [EOF]
//
