//
// File: Linear.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 19:54:19
//

// Include Files
#include "Linear.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : const double svT[7824]
//                const double x[48]
//                double kernelProduct[163]
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
          void Linear(const double svT[7824], const double x[48], double
                      kernelProduct[163])
          {
            double d;
            for (int i = 0; i < 163; i++) {
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
