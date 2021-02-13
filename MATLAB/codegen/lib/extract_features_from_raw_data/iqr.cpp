//
// File: iqr.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "iqr.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <string.h>

// Function Declarations
static double rt_roundd_snf(double u);

// Function Definitions
//
// Arguments    : double u
// Return Type  : double
//
static double rt_roundd_snf(double u)
{
  double y;
  if (std::abs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = std::floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = std::ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

//
// Arguments    : const ::coder::array<double, 2U> &x
// Return Type  : double
//
namespace coder
{
  double iqr(const ::coder::array<double, 2U> &x)
  {
    array<int, 2U> idx;
    array<int, 1U> iwork;
    double r;
    double y_idx_0_tmp;
    int k;
    int qEnd;
    if (x.size(1) == 0) {
      y_idx_0_tmp = rtNaN;
      r = rtNaN;
    } else {
      int b_i;
      int i;
      int n;
      int nj;
      n = x.size(1) + 1;
      idx.set_size(1, x.size(1));
      nj = x.size(1);
      for (i = 0; i < nj; i++) {
        idx[i] = 0;
      }

      iwork.set_size(x.size(1));
      i = x.size(1) - 1;
      for (k = 1; k <= i; k += 2) {
        r = x[k];
        if ((x[k - 1] <= r) || rtIsNaN(r)) {
          idx[k - 1] = k;
          idx[k] = k + 1;
        } else {
          idx[k - 1] = k + 1;
          idx[k] = k;
        }
      }

      if ((x.size(1) & 1) != 0) {
        idx[x.size(1) - 1] = x.size(1);
      }

      b_i = 2;
      while (b_i < n - 1) {
        int j;
        nj = b_i << 1;
        j = 1;
        for (int pEnd = b_i + 1; pEnd < n; pEnd = qEnd + b_i) {
          int kEnd;
          int p;
          int q;
          p = j;
          q = pEnd - 1;
          qEnd = j + nj;
          if (qEnd > n) {
            qEnd = n;
          }

          k = 0;
          kEnd = qEnd - j;
          while (k + 1 <= kEnd) {
            r = x[idx[q] - 1];
            i = idx[p - 1];
            if ((x[i - 1] <= r) || rtIsNaN(r)) {
              iwork[k] = i;
              p++;
              if (p == pEnd) {
                while (q + 1 < qEnd) {
                  k++;
                  iwork[k] = idx[q];
                  q++;
                }
              }
            } else {
              iwork[k] = idx[q];
              q++;
              if (q + 1 == qEnd) {
                while (p < pEnd) {
                  k++;
                  iwork[k] = idx[p - 1];
                  p++;
                }
              }
            }

            k++;
          }

          for (k = 0; k < kEnd; k++) {
            idx[(j + k) - 1] = iwork[k];
          }

          j = qEnd;
        }

        b_i = nj;
      }

      nj = x.size(1);
      while ((nj > 0) && rtIsNaN(x[idx[nj - 1] - 1])) {
        nj--;
      }

      if (nj < 1) {
        y_idx_0_tmp = rtNaN;
        r = rtNaN;
      } else if (nj == 1) {
        y_idx_0_tmp = x[idx[0] - 1];
        r = y_idx_0_tmp;
      } else {
        r = 0.25 * static_cast<double>(nj);
        b_i = static_cast<int>(rt_roundd_snf(r));
        if (b_i >= nj) {
          y_idx_0_tmp = x[idx[nj - 1] - 1];
        } else {
          r -= static_cast<double>(b_i);
          y_idx_0_tmp = (0.5 - r) * x[idx[b_i - 1] - 1] + (r + 0.5) * x[idx[b_i]
            - 1];
        }

        r = 0.75 * static_cast<double>(nj);
        b_i = static_cast<int>(rt_roundd_snf(r));
        if (b_i >= nj) {
          r = x[idx[nj - 1] - 1];
        } else {
          r -= static_cast<double>(b_i);
          r = (0.5 - r) * x[idx[b_i - 1] - 1] + (r + 0.5) * x[idx[b_i] - 1];
        }
      }
    }

    return r - y_idx_0_tmp;
  }
}

//
// File trailer for iqr.cpp
//
// [EOF]
//
