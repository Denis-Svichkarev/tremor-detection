//
// File: Linear.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 18-Feb-2021 10:56:29
//

// Include Files
#include "Linear.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : const double svT[45168]
//                const double x[48]
//                double kernelProduct[941]
// Return Type  : void
//
namespace coder
{
  namespace classreg
  {
    namespace learning
    {
      namespace coder
      {
        namespace kernel
        {
          void Linear(const double svT[45168], const double x[48], double
                      kernelProduct[941])
          {
            double d;
            for (int i = 0; i < 941; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 48; i1++) {
                d += x[i1] * svT[i1 + 48 * i];
              }

              kernelProduct[i] = d;
            }
          }
        }
      }
    }
  }
}

//
// File trailer for Linear.cpp
//
// [EOF]
//
