//
// File: Linear.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 03-Dec-2021 23:13:20
//

// Include Files
#include "Linear.h"
#include "rt_nonfinite.h"

// Function Definitions
//
// Arguments    : const double svT[1566]
//                const double x[87]
//                double kernelProduct[18]
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
          void Linear(const double svT[1566], const double x[87], double
                      kernelProduct[18])
          {
            double d;
            for (int i = 0; i < 18; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 87; i1++) {
                d += x[i1] * svT[i1 + 87 * i];
              }

              kernelProduct[i] = d;
            }
          }

          //
          // Arguments    : const double svT[1131]
          //                const double x[87]
          //                double kernelProduct[13]
          // Return Type  : void
          //
          void b_Linear(const double svT[1131], const double x[87], double
                        kernelProduct[13])
          {
            double d;
            for (int i = 0; i < 13; i++) {
              d = 0.0;
              for (int i1 = 0; i1 < 87; i1++) {
                d += x[i1] * svT[i1 + 87 * i];
              }

              kernelProduct[i] = d;
            }
          }

          //
          // Arguments    : const double svT[1218]
          //                const double x[87]
          //                double kernelProduct[14]
          // Return Type  : void
          //
          void c_Linear(const double svT[1218], const double x[87], double
                        kernelProduct[14])
          {
            double d;
            for (int i = 0; i < 14; i++) {
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
