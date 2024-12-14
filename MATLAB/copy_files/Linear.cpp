//
// File: Linear.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 09-Dec-2021 00:19:42
//

// Include Files
#include "Linear.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : const double svT[18705]
//                const double x[87]
//                double kernelProduct[215]
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
          void Linear(const double svT[18705], const double x[87], double
                      kernelProduct[215])
          {
            double d;
            for (int i = 0; i < 215; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 87; i1++) {
                d += x[i1] * svT[i1 + 87 * i];
              }

              kernelProduct[i] = d;
            }
          }

          //
          // Arguments    : const double svT[10788]
          //                const double x[87]
          //                double kernelProduct[124]
          // Return Type  : void
          //
          void b_Linear(const double svT[10788], const double x[87], double
                        kernelProduct[124])
          {
            double d;
            for (int i = 0; i < 124; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 87; i1++) {
                d += x[i1] * svT[i1 + 87 * i];
              }

              kernelProduct[i] = d;
            }
          }

          //
          // Arguments    : const double svT[4524]
          //                const double x[87]
          //                double kernelProduct[52]
          // Return Type  : void
          //
          void c_Linear(const double svT[4524], const double x[87], double
                        kernelProduct[52])
          {
            double d;
            for (int i = 0; i < 52; i++) {
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
