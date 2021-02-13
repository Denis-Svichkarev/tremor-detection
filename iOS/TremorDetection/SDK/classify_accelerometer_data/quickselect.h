//
// File: quickselect.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//
#ifndef QUICKSELECT_H
#define QUICKSELECT_H

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
    void quickselect(::coder::array<double, 2U> &v, int n, int vlen, double *vn,
                     int *nfirst, int *nlast);
  }
}

#endif

//
// File trailer for quickselect.h
//
// [EOF]
//
