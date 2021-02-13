//
// File: minOrMax.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 17:28:01
//
#ifndef MINORMAX_H
#define MINORMAX_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
namespace coder
{
  namespace internal
  {
    void maximum(const double x[3], double *ex, int *idx);
  
    double maximum(const ::coder::array<double, 2U> &x);
    double minimum(const ::coder::array<double, 2U> &x);
  }
}

#endif

//
// File trailer for minOrMax.h
//
// [EOF]
//
