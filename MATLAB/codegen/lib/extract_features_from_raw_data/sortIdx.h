//
// File: sortIdx.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//
#ifndef SORTIDX_H
#define SORTIDX_H

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
    void merge_block(::coder::array<int, 1U> &idx, ::coder::array<double, 1U> &x,
                     int offset, int n, int preSortLevel, ::coder::array<int, 1U>
                     &iwork, ::coder::array<double, 1U> &xwork);
  }
}

#endif

//
// File trailer for sortIdx.h
//
// [EOF]
//
