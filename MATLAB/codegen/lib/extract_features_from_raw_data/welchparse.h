//
// File: welchparse.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//
#ifndef WELCHPARSE_H
#define WELCHPARSE_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include <cstddef>
#include <cstdlib>

// Type Declarations
struct struct_T;

// Function Declarations
namespace coder
{
  namespace signal
  {
    namespace internal
    {
      namespace spectral
      {
        void welchparse(const ::coder::array<double, 2U> &x1, ::coder::array<
                        double, 1U> &x, double *M, ::coder::array<double, 1U>
                        &win, double *noverlap, double *k, double *L, struct_T
                        *options);
      }
    }
  }
}

#endif

//
// File trailer for welchparse.h
//
// [EOF]
//
