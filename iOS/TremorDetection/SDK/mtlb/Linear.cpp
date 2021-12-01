//
// File: Linear.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 19:14:56
//

// Include Files
#include "Linear.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : const double svT[957]
//                const double x[87]
//                double kernelProduct[11]
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
          void Linear(const double svT[957], const double x[87], double
                      kernelProduct[11])
          {
            double d;
            for (int i = 0; i < 11; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 87; i1++) {
                d += x[i1] * svT[i1 + 87 * i];
              }

              kernelProduct[i] = d;
            }
          }

          //
          // Arguments    : const double svT[783]
          //                const double x[87]
          //                double kernelProduct[9]
          // Return Type  : void
          //
          void b_Linear(const double svT[783], const double x[87], double
                        kernelProduct[9])
          {
            double d;
            for (int i = 0; i < 9; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 87; i1++) {
                d += x[i1] * svT[i1 + 87 * i];
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
