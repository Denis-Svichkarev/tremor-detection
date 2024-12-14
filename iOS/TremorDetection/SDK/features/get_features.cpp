//
// File: get_features.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//

// Include Files
#include "get_features.h"
#include "iqr.h"
#include "median.h"
#include "minOrMax.h"
#include "nan_sum_or_mean.h"
#include "nanmean.h"
#include "rt_nonfinite.h"
#include "std.h"
#include "trapz.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Declarations
static double rt_powd_snf(double u0, double u1);

// Function Definitions
//
// Arguments    : double u0
//                double u1
// Return Type  : double
//
static double rt_powd_snf(double u0, double u1)
{
  double y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = rtNaN;
  } else {
    double d;
    double d1;
    d = std::abs(u0);
    d1 = std::abs(u1);
    if (rtIsInf(u1)) {
      if (d == 1.0) {
        y = 1.0;
      } else if (d > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d1 == 0.0) {
      y = 1.0;
    } else if (d1 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }

  return y;
}

//
// Arguments    : const double amplitudes_data[]
//                const int amplitudes_size[2]
//                const double frequencies_data[]
//                const int frequencies_size[2]
//                coder::array<double, 2U> &freq
//                coder::array<double, 2U> &amp
//                double *M
//                double *S
//                double *M2
//                double *maxValue
//                double *minValue
//                double *b_I
//                double *Q
//                double *SK
//                double *K
//                double *M_T
//                double *S_T
//                double *M2_T
//                double *maxValue_T
//                double *minValue_T
//                double *I_T
//                double *Q_T
// Return Type  : void
//
void get_features(const double amplitudes_data[], const int amplitudes_size[2],
                  const double frequencies_data[], const int frequencies_size[2],
                  coder::array<double, 2U> &freq, coder::array<double, 2U> &amp,
                  double *M, double *S, double *M2, double *maxValue, double
                  *minValue, double *b_I, double *Q, double *SK, double *K,
                  double *M_T, double *S_T, double *M2_T, double *maxValue_T,
                  double *minValue_T, double *I_T, double *Q_T)
{
  coder::array<double, 2U> b_amplitudes_data;
  coder::array<double, 2U> c_amplitudes_data;
  coder::array<double, 2U> d_amplitudes_data;
  coder::array<double, 2U> e_amplitudes_data;
  coder::array<double, 2U> f_amplitudes_data;
  coder::array<double, 2U> g_amplitudes_data;
  coder::array<double, 2U> x0;
  coder::array<double, 2U> xp;
  double s2;
  double y;
  int b_i;
  int i;
  int vlen;

  //  Extract 3-9 Hz frequencies and basic characteristics
  freq.set_size(1, 0);
  amp.set_size(1, 0);
  i = frequencies_size[1];
  for (b_i = 0; b_i < i; b_i++) {
    y = frequencies_data[b_i];
    if ((y >= 3.0) && (y <= 9.0)) {
      vlen = freq.size(1);
      freq.set_size(freq.size(0), (freq.size(1) + 1));
      freq[vlen] = y;
      vlen = amp.size(1);
      amp.set_size(amp.size(0), (amp.size(1) + 1));
      amp[vlen] = amplitudes_data[b_i];
    }
  }

  //  Frequency domain features
  vlen = amp.size(1);
  if (amp.size(1) == 0) {
    y = 0.0;
  } else {
    y = amp[0];
    for (b_i = 2; b_i <= vlen; b_i++) {
      y += amp[b_i - 1];
    }
  }

  *M = y / static_cast<double>(amp.size(1));
  *S = coder::b_std(amp);
  *M2 = coder::median(amp);
  *maxValue = coder::internal::maximum(amp);
  *minValue = coder::internal::minimum(amp);

  // [ecdf_f, ecdf_x] = ecdf(amp);
  // E = entropy(amp);
  *b_I = coder::iqr(amp);
  *Q = coder::trapz(amp);
  if (amp.size(1) == 0) {
    *SK = rtNaN;
  } else {
    coder::nan_sum_or_mean(amp, &y, &vlen);
    x0.set_size(1, amp.size(1));
    vlen = (amp.size(1) != 1);
    i = amp.size(1) - 1;
    for (b_i = 0; b_i <= i; b_i++) {
      x0[b_i] = amp[vlen * b_i] - y;
    }

    xp.set_size(1, x0.size(1));
    vlen = x0.size(0) * x0.size(1);
    for (i = 0; i < vlen; i++) {
      y = x0[i];
      xp[i] = y * y;
    }

    y = coder::nanmean(xp);
    i = xp.size(0) * xp.size(1);
    xp.set_size(1, xp.size(1));
    vlen = i - 1;
    for (i = 0; i <= vlen; i++) {
      xp[i] = xp[i] * x0[i];
    }

    *SK = coder::nanmean(xp) / rt_powd_snf(y, 1.5);
  }

  coder::nan_sum_or_mean(amp, &y, &vlen);
  x0.set_size(1, amp.size(1));
  if (amp.size(1) != 0) {
    vlen = (amp.size(1) != 1);
    i = amp.size(1) - 1;
    for (b_i = 0; b_i <= i; b_i++) {
      x0[b_i] = amp[vlen * b_i] - y;
    }
  }

  i = x0.size(0) * x0.size(1);
  x0.set_size(1, x0.size(1));
  vlen = i - 1;
  for (i = 0; i <= vlen; i++) {
    y = x0[i];
    y *= y;
    x0[i] = y;
  }

  s2 = coder::nanmean(x0);
  i = x0.size(0) * x0.size(1);
  x0.set_size(1, x0.size(1));
  vlen = i - 1;
  for (i = 0; i <= vlen; i++) {
    y = x0[i];
    y *= y;
    x0[i] = y;
  }

  *K = coder::nanmean(x0) / (s2 * s2);

  // W = pwelch(amp);
  //  Time domain features
  vlen = amplitudes_size[1];
  if (amplitudes_size[1] == 0) {
    y = 0.0;
  } else {
    y = amplitudes_data[0];
    for (b_i = 2; b_i <= vlen; b_i++) {
      y += amplitudes_data[b_i - 1];
    }
  }

  b_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *S_T = coder::b_std(b_amplitudes_data);
  c_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *M2_T = coder::median(c_amplitudes_data);
  d_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *maxValue_T = coder::internal::maximum(d_amplitudes_data);
  e_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *minValue_T = coder::internal::minimum(e_amplitudes_data);

  // [ecdf_f_T, ecdf_x_T] = ecdf(amplitudes);
  // E_T = entropy(amplitudes);
  f_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *I_T = coder::iqr(f_amplitudes_data);
  g_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *Q_T = coder::trapz(g_amplitudes_data);
  *M_T = y / static_cast<double>(amplitudes_size[1]);
}

//
// File trailer for get_features.cpp
//
// [EOF]
//
