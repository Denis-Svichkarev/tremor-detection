//
// File: ecdf.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 20:13:16
//

// Include Files
#include "ecdf.h"
#include "diff.h"
#include "minOrMax.h"
#include "nullAssignment.h"
#include "rt_nonfinite.h"
#include "sort.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const ::coder::array<double, 2U> &y
//                ::coder::array<double, 1U> &Fout
//                ::coder::array<double, 1U> &x
// Return Type  : void
//
namespace coder
{
  void ecdf(const ::coder::array<double, 2U> &y, ::coder::array<double, 1U>
            &Fout, ::coder::array<double, 1U> &x)
  {
    array<double, 1U> D;
    array<double, 1U> freq;
    array<double, 1U> totcumfreq;
    array<int, 1U> iidx;
    array<bool, 1U> cens;
    array<bool, 1U> isDiff;
    array<bool, 1U> r;
    int b_trueCount;
    int i;
    int loop_ub;
    int partialTrueCount;
    int trueCount;
    bool b_y;
    bool exitg1;
    isDiff.set_size(y.size(1));
    loop_ub = y.size(1);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      isDiff[partialTrueCount] = rtIsNaN(y[partialTrueCount]);
    }

    r.set_size(y.size(1));
    loop_ub = y.size(1);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      r[partialTrueCount] = false;
    }

    loop_ub = isDiff.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      isDiff[partialTrueCount] = ((!isDiff[partialTrueCount]) &&
        (!r[partialTrueCount]));
    }

    loop_ub = isDiff.size(0) - 1;
    trueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        trueCount++;
      }
    }

    x.set_size(trueCount);
    partialTrueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        x[partialTrueCount] = y[i];
        partialTrueCount++;
      }
    }

    loop_ub = isDiff.size(0) - 1;
    trueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        trueCount++;
      }
    }

    cens.set_size(trueCount);
    partialTrueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        cens[partialTrueCount] = false;
        partialTrueCount++;
      }
    }

    loop_ub = isDiff.size(0) - 1;
    trueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        trueCount++;
      }
    }

    freq.set_size(trueCount);
    partialTrueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        freq[partialTrueCount] = 1.0;
        partialTrueCount++;
      }
    }

    internal::sort(x, iidx);
    Fout.set_size(iidx.size(0));
    loop_ub = iidx.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      Fout[partialTrueCount] = iidx[partialTrueCount];
    }

    isDiff.set_size(Fout.size(0));
    loop_ub = Fout.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      isDiff[partialTrueCount] = cens[static_cast<int>(Fout[partialTrueCount]) -
        1];
    }

    cens.set_size(isDiff.size(0));
    loop_ub = isDiff.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      cens[partialTrueCount] = isDiff[partialTrueCount];
    }

    totcumfreq.set_size(Fout.size(0));
    loop_ub = Fout.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      totcumfreq[partialTrueCount] = freq[static_cast<int>(Fout[partialTrueCount])
        - 1];
    }

    freq.set_size(totcumfreq.size(0));
    loop_ub = totcumfreq.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      freq[partialTrueCount] = totcumfreq[partialTrueCount];
    }

    if ((freq.size(0) != 1) && (freq.size(0) != 0) && (freq.size(0) != 1)) {
      partialTrueCount = freq.size(0);
      for (loop_ub = 0; loop_ub <= partialTrueCount - 2; loop_ub++) {
        totcumfreq[loop_ub + 1] = totcumfreq[loop_ub] + totcumfreq[loop_ub + 1];
      }
    }

    loop_ub = freq.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      freq[partialTrueCount] = freq[partialTrueCount] * static_cast<double>
        (!cens[partialTrueCount]);
    }

    if ((freq.size(0) != 1) && (freq.size(0) != 0) && (freq.size(0) != 1)) {
      partialTrueCount = freq.size(0);
      for (loop_ub = 0; loop_ub <= partialTrueCount - 2; loop_ub++) {
        freq[loop_ub + 1] = freq[loop_ub] + freq[loop_ub + 1];
      }
    }

    diff(x, Fout);
    isDiff.set_size(Fout.size(0));
    loop_ub = Fout.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      isDiff[partialTrueCount] = (Fout[partialTrueCount] == 0.0);
    }

    b_y = false;
    loop_ub = 1;
    exitg1 = false;
    while ((!exitg1) && (loop_ub <= isDiff.size(0))) {
      if (!isDiff[loop_ub - 1]) {
        loop_ub++;
      } else {
        b_y = true;
        exitg1 = true;
      }
    }

    if (b_y) {
      internal::nullAssignment(x, isDiff);
      internal::nullAssignment(totcumfreq, isDiff);
      internal::nullAssignment(freq, isDiff);
    }

    diff(freq, Fout);
    D.set_size((Fout.size(0) + 1));
    D[0] = freq[0];
    loop_ub = Fout.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      D[partialTrueCount + 1] = Fout[partialTrueCount];
    }

    if (1.0 > static_cast<double>(totcumfreq.size(0)) - 1.0) {
      loop_ub = 0;
    } else {
      loop_ub = totcumfreq.size(0) - 1;
    }

    Fout.set_size((loop_ub + 1));
    Fout[0] = totcumfreq[totcumfreq.size(0) - 1];
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      Fout[partialTrueCount + 1] = totcumfreq[totcumfreq.size(0) - 1] -
        totcumfreq[partialTrueCount];
    }

    isDiff.set_size(D.size(0));
    loop_ub = D.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      isDiff[partialTrueCount] = (D[partialTrueCount] > 0.0);
    }

    loop_ub = D.size(0) - 1;
    trueCount = 0;
    partialTrueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (D[i] > 0.0) {
        trueCount++;
        x[partialTrueCount] = x[i];
        partialTrueCount++;
      }
    }

    x.set_size(trueCount);
    loop_ub = D.size(0) - 1;
    b_trueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (D[i] > 0.0) {
        b_trueCount++;
      }
    }

    partialTrueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (D[i] > 0.0) {
        D[partialTrueCount] = D[i];
        partialTrueCount++;
      }
    }

    D.set_size(b_trueCount);
    loop_ub = isDiff.size(0) - 1;
    partialTrueCount = 0;
    for (i = 0; i <= loop_ub; i++) {
      if (isDiff[i]) {
        Fout[partialTrueCount] = Fout[i];
        partialTrueCount++;
      }
    }

    Fout.set_size(b_trueCount);
    for (partialTrueCount = 0; partialTrueCount < b_trueCount; partialTrueCount
         ++) {
      Fout[partialTrueCount] = 1.0 - D[partialTrueCount] / Fout[partialTrueCount];
    }

    if ((Fout.size(0) != 1) && (Fout.size(0) != 0) && (Fout.size(0) != 1)) {
      partialTrueCount = Fout.size(0);
      for (loop_ub = 0; loop_ub <= partialTrueCount - 2; loop_ub++) {
        Fout[loop_ub + 1] = Fout[loop_ub] * Fout[loop_ub + 1];
      }
    }

    loop_ub = Fout.size(0);
    for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++) {
      Fout[partialTrueCount] = 1.0 - Fout[partialTrueCount];
    }

    if (b_trueCount != 0) {
      totcumfreq.set_size((trueCount + 1));
      totcumfreq[0] = internal::minimum(y);
      for (partialTrueCount = 0; partialTrueCount < trueCount; partialTrueCount
           ++) {
        totcumfreq[partialTrueCount + 1] = x[partialTrueCount];
      }

      x.set_size(totcumfreq.size(0));
      loop_ub = totcumfreq.size(0);
      for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++)
      {
        x[partialTrueCount] = totcumfreq[partialTrueCount];
      }

      totcumfreq.set_size((Fout.size(0) + 1));
      totcumfreq[0] = 0.0;
      loop_ub = Fout.size(0);
      for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++)
      {
        totcumfreq[partialTrueCount + 1] = Fout[partialTrueCount];
      }

      Fout.set_size(totcumfreq.size(0));
      loop_ub = totcumfreq.size(0);
      for (partialTrueCount = 0; partialTrueCount < loop_ub; partialTrueCount++)
      {
        Fout[partialTrueCount] = totcumfreq[partialTrueCount];
      }
    }
  }
}

//
// File trailer for ecdf.cpp
//
// [EOF]
//
