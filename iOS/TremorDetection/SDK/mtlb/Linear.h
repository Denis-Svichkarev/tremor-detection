//
// File: Linear.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 03-Dec-2021 23:13:20
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
          void Linear(const double svT[1566], const double x[87], double
                      kernelProduct[18]);
          void b_Linear(const double svT[1131], const double x[87], double
                        kernelProduct[13]);
          void c_Linear(const double svT[1218], const double x[87], double
                        kernelProduct[14]);
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
