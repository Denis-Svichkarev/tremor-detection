//
// File: Linear.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 09-Dec-2021 00:19:42
//
#ifndef LINEAR_H
#define LINEAR_H

// Include Files
#include "rtwtypes.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
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
                      kernelProduct[215]);
          void b_Linear(const double svT[10788], const double x[87], double
                        kernelProduct[124]);
          void c_Linear(const double svT[4524], const double x[87], double
                        kernelProduct[52]);
        }
      }
    }
  }
}

#endif

//
// File trailer for Linear.h
//
// [EOF]
//
