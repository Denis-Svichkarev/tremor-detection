//
// File: Linear.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 21-Feb-2021 14:17:16
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
          void Linear(const double svT[6048], const double x[48], double
                      kernelProduct[126]);
          void b_Linear(const double svT[11136], const double x[48], double
                        kernelProduct[232]);
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
