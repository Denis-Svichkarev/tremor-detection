//
// File: get_features.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "get_features.h"
#include "FFTImplementationCallback.h"
#include "computepsd.h"
#include "ecdf.h"
#include "extract_features_from_raw_data_data.h"
#include "extract_features_from_raw_data_internal_types.h"
#include "extract_features_from_raw_data_rtwutil.h"
#include "iqr.h"
#include "median.h"
#include "minOrMax.h"
#include "nan_sum_or_mean.h"
#include "nanmean.h"
#include "psdfreqvec.h"
#include "rt_nonfinite.h"
#include "std.h"
#include "trapz.h"
#include "welchparse.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <string.h>

// Function Declarations
static int div_s32(int numerator, int denominator);

// Function Definitions
//
// Arguments    : int numerator
//                int denominator
// Return Type  : int
//
static int div_s32(int numerator, int denominator)
{
  unsigned int b_numerator;
  int quotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
  } else {
    unsigned int b_denominator;
    if (numerator < 0) {
      b_numerator = ~static_cast<unsigned int>(numerator) + 1U;
    } else {
      b_numerator = static_cast<unsigned int>(numerator);
    }

    if (denominator < 0) {
      b_denominator = ~static_cast<unsigned int>(denominator) + 1U;
    } else {
      b_denominator = static_cast<unsigned int>(denominator);
    }

    b_numerator /= b_denominator;
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int>(b_numerator);
    } else {
      quotient = static_cast<int>(b_numerator);
    }
  }

  return quotient;
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
//                coder::array<double, 1U> &ecdf_f
//                coder::array<double, 1U> &ecdf_x
//                double *b_I
//                double *Q
//                double *SK
//                double *K
//                coder::array<double, 2U> &W
//                double *M_T
//                double *S_T
//                double *M2_T
//                double *maxValue_T
//                double *minValue_T
//                double ecdf_f_T_data[]
//                int ecdf_f_T_size[1]
//                double ecdf_x_T_data[]
//                int ecdf_x_T_size[1]
//                double *I_T
//                double *Q_T
// Return Type  : void
//
void get_features(const double amplitudes_data[], const int amplitudes_size[2],
                  const double frequencies_data[], const int frequencies_size[2],
                  coder::array<double, 2U> &freq, coder::array<double, 2U> &amp,
                  double *M, double *S, double *M2, double *maxValue, double
                  *minValue, coder::array<double, 1U> &ecdf_f, coder::array<
                  double, 1U> &ecdf_x, double *b_I, double *Q, double *SK,
                  double *K, coder::array<double, 2U> &W, double *M_T, double
                  *S_T, double *M2_T, double *maxValue_T, double *minValue_T,
                  double ecdf_f_T_data[], int ecdf_f_T_size[1], double
                  ecdf_x_T_data[], int ecdf_x_T_size[1], double *I_T, double
                  *Q_T)
{
  coder::array<creal_T, 1U> Xx;
  coder::array<double, 2U> Sxx1;
  coder::array<double, 2U> b_amplitudes_data;
  coder::array<double, 2U> c_amplitudes_data;
  coder::array<double, 2U> costab;
  coder::array<double, 2U> d_amplitudes_data;
  coder::array<double, 2U> e_amplitudes_data;
  coder::array<double, 2U> f_amplitudes_data;
  coder::array<double, 2U> g_amplitudes_data;
  coder::array<double, 2U> h_amplitudes_data;
  coder::array<double, 2U> sintab;
  coder::array<double, 2U> sintabinv;
  coder::array<double, 2U> wrappedData;
  coder::array<double, 2U> x0;
  coder::array<double, 2U> xp;
  coder::array<double, 1U> b_xw;
  coder::array<double, 1U> win1;
  coder::array<double, 1U> x1;
  coder::array<double, 1U> xw;
  struct_T options;
  double L;
  double LminusOverlap;
  double cdiff;
  double k1;
  double noverlap;
  double options_nfft;
  double s2;
  double u1;
  int units_size[2];
  int acoef;
  int i;
  int i1;
  int k;
  int vlen;
  char units_data[10];

  //  Extract 3-9 Hz frequencies and basic characteristics
  freq.set_size(1, 0);
  amp.set_size(1, 0);
  i = frequencies_size[1];
  for (vlen = 0; vlen < i; vlen++) {
    noverlap = frequencies_data[vlen];
    if ((noverlap >= 3.0) && (noverlap <= 9.0)) {
      i1 = freq.size(1);
      freq.set_size(freq.size(0), (freq.size(1) + 1));
      freq[i1] = noverlap;
      i1 = amp.size(1);
      amp.set_size(amp.size(0), (amp.size(1) + 1));
      amp[i1] = amplitudes_data[vlen];
    }
  }

  //  Frequency domain features
  vlen = amp.size(1);
  if (amp.size(1) == 0) {
    s2 = 0.0;
  } else {
    s2 = amp[0];
    for (k = 2; k <= vlen; k++) {
      s2 += amp[k - 1];
    }
  }

  *M = s2 / static_cast<double>(amp.size(1));
  *S = coder::b_std(amp);
  *M2 = coder::median(amp);
  *maxValue = coder::internal::maximum(amp);
  *minValue = coder::internal::minimum(amp);
  coder::ecdf(amp, ecdf_f, ecdf_x);

  // E = entropy(amp);
  *b_I = coder::iqr(amp);
  *Q = coder::trapz(amp);
  if (amp.size(1) == 0) {
    *SK = rtNaN;
  } else {
    coder::nan_sum_or_mean(amp, &s2, &vlen);
    x0.set_size(1, amp.size(1));
    acoef = (amp.size(1) != 1);
    i = amp.size(1) - 1;
    for (k = 0; k <= i; k++) {
      x0[k] = amp[acoef * k] - s2;
    }

    xp.set_size(1, x0.size(1));
    vlen = x0.size(0) * x0.size(1);
    for (i = 0; i < vlen; i++) {
      noverlap = x0[i];
      xp[i] = noverlap * noverlap;
    }

    s2 = coder::nanmean(xp);
    i = xp.size(0) * xp.size(1);
    xp.set_size(1, xp.size(1));
    vlen = i - 1;
    for (i = 0; i <= vlen; i++) {
      xp[i] = xp[i] * x0[i];
    }

    *SK = coder::nanmean(xp) / rt_powd_snf(s2, 1.5);
  }

  coder::nan_sum_or_mean(amp, &s2, &vlen);
  x0.set_size(1, amp.size(1));
  if (amp.size(1) != 0) {
    acoef = (amp.size(1) != 1);
    i = amp.size(1) - 1;
    for (k = 0; k <= i; k++) {
      x0[k] = amp[acoef * k] - s2;
    }
  }

  i = x0.size(0) * x0.size(1);
  x0.set_size(1, x0.size(1));
  vlen = i - 1;
  for (i = 0; i <= vlen; i++) {
    noverlap = x0[i];
    noverlap *= noverlap;
    x0[i] = noverlap;
  }

  s2 = coder::nanmean(x0);
  i = x0.size(0) * x0.size(1);
  x0.set_size(1, x0.size(1));
  vlen = i - 1;
  for (i = 0; i <= vlen; i++) {
    noverlap = x0[i];
    noverlap *= noverlap;
    x0[i] = noverlap;
  }

  *K = coder::nanmean(x0) / (s2 * s2);
  coder::signal::internal::spectral::welchparse(amp, x1, &s2, win1, &noverlap,
    &k1, &L, &options);
  options_nfft = options.nfft;
  LminusOverlap = L - noverlap;
  s2 = k1 * LminusOverlap;
  if (rtIsNaN(LminusOverlap) || rtIsNaN(s2)) {
    x0.set_size(1, 1);
    x0[0] = rtNaN;
  } else if ((LminusOverlap == 0.0) || ((1.0 < s2) && (LminusOverlap < 0.0)) ||
             ((s2 < 1.0) && (LminusOverlap > 0.0))) {
    x0.set_size(1, 0);
  } else if (rtIsInf(s2) && (rtIsInf(LminusOverlap) || (1.0 == s2))) {
    x0.set_size(1, 1);
    x0[0] = rtNaN;
  } else if (rtIsInf(LminusOverlap)) {
    x0.set_size(1, 1);
    x0[0] = 1.0;
  } else if (std::floor(LminusOverlap) == LminusOverlap) {
    vlen = static_cast<int>(std::floor((s2 - 1.0) / LminusOverlap));
    x0.set_size(1, (vlen + 1));
    for (i = 0; i <= vlen; i++) {
      x0[i] = LminusOverlap * static_cast<double>(i) + 1.0;
    }
  } else {
    double apnd;
    noverlap = std::floor((s2 - 1.0) / LminusOverlap + 0.5);
    apnd = noverlap * LminusOverlap + 1.0;
    if (LminusOverlap > 0.0) {
      cdiff = apnd - s2;
    } else {
      cdiff = s2 - apnd;
    }

    u1 = std::abs(s2);
    if ((1.0 > u1) || rtIsNaN(u1)) {
      u1 = 1.0;
    }

    if (std::abs(cdiff) < 4.4408920985006262E-16 * u1) {
      noverlap++;
      apnd = s2;
    } else if (cdiff > 0.0) {
      apnd = (noverlap - 1.0) * LminusOverlap + 1.0;
    } else {
      noverlap++;
    }

    if (noverlap >= 0.0) {
      vlen = static_cast<int>(noverlap);
    } else {
      vlen = 0;
    }

    x0.set_size(1, vlen);
    if (vlen > 0) {
      x0[0] = 1.0;
      if (vlen > 1) {
        x0[vlen - 1] = apnd;
        acoef = (vlen - 1) / 2;
        for (k = 0; k <= acoef - 2; k++) {
          s2 = (static_cast<double>(k) + 1.0) * LminusOverlap;
          x0[k + 1] = s2 + 1.0;
          x0[(vlen - k) - 2] = apnd - s2;
        }

        if (acoef << 1 == vlen - 1) {
          x0[acoef] = (apnd + 1.0) / 2.0;
        } else {
          s2 = static_cast<double>(acoef) * LminusOverlap;
          x0[acoef] = s2 + 1.0;
          x0[acoef + 1] = apnd - s2;
        }
      }
    }
  }

  xp.set_size(1, x0.size(1));
  vlen = x0.size(0) * x0.size(1);
  for (i = 0; i < vlen; i++) {
    xp[i] = (x0[i] + L) - 1.0;
  }

  Sxx1.set_size(0, 0);
  i = static_cast<int>(k1);
  for (int ii = 0; ii < i; ii++) {
    int bcoef;
    int nFullPasses;
    noverlap = x0[ii];
    s2 = xp[ii];
    if (noverlap > s2) {
      i1 = -1;
      nFullPasses = -1;
    } else {
      i1 = static_cast<int>(noverlap) - 2;
      nFullPasses = static_cast<int>(s2) - 1;
    }

    if (win1.size(0) == 1) {
      vlen = nFullPasses - i1;
    } else {
      vlen = nFullPasses - i1;
      if (vlen == 1) {
        vlen = win1.size(0);
      } else {
        if ((vlen != win1.size(0)) && (win1.size(0) < vlen)) {
          vlen = win1.size(0);
        }
      }
    }

    b_xw.set_size(vlen);
    if (vlen != 0) {
      acoef = (nFullPasses - i1 != 1);
      bcoef = (win1.size(0) != 1);
      nFullPasses = vlen - 1;
      for (k = 0; k <= nFullPasses; k++) {
        b_xw[k] = x1[(i1 + acoef * k) + 1] * win1[bcoef * k];
      }
    }

    xw.set_size((static_cast<int>(options_nfft)));
    vlen = static_cast<int>(options_nfft);
    for (i1 = 0; i1 < vlen; i1++) {
      xw[i1] = 0.0;
    }

    if (b_xw.size(0) > options_nfft) {
      bcoef = static_cast<int>(options_nfft);
      if (b_xw.size(0) == 1) {
        wrappedData.set_size(1, (static_cast<int>(options_nfft)));
        vlen = static_cast<int>(options_nfft);
        for (i1 = 0; i1 < vlen; i1++) {
          wrappedData[i1] = 0.0;
        }
      } else {
        wrappedData.set_size((static_cast<int>(options_nfft)), 1);
        vlen = static_cast<int>(options_nfft);
        for (i1 = 0; i1 < vlen; i1++) {
          wrappedData[i1] = 0.0;
        }
      }

      nFullPasses = div_s32(b_xw.size(0), static_cast<int>(options_nfft));
      vlen = nFullPasses * static_cast<int>(options_nfft);
      acoef = (b_xw.size(0) - vlen) - 1;
      for (k = 0; k <= acoef; k++) {
        wrappedData[k] = b_xw[vlen + k];
      }

      i1 = acoef + 2;
      for (k = i1; k <= bcoef; k++) {
        wrappedData[k - 1] = 0.0;
      }

      for (acoef = 0; acoef < nFullPasses; acoef++) {
        vlen = acoef * static_cast<int>(options_nfft);
        for (k = 0; k < bcoef; k++) {
          wrappedData[k] = wrappedData[k] + b_xw[vlen + k];
        }
      }

      vlen = wrappedData.size(0) * wrappedData.size(1);
      for (i1 = 0; i1 < vlen; i1++) {
        xw[i1] = wrappedData[i1];
      }
    } else {
      xw.set_size(b_xw.size(0));
      vlen = b_xw.size(0);
      for (i1 = 0; i1 < vlen; i1++) {
        xw[i1] = b_xw[i1];
      }
    }

    if ((xw.size(0) == 0) || (0 == static_cast<int>(options_nfft))) {
      vlen = static_cast<int>(options_nfft);
      Xx.set_size((static_cast<int>(options_nfft)));
      for (i1 = 0; i1 < vlen; i1++) {
        Xx[i1].re = 0.0;
        Xx[i1].im = 0.0;
      }
    } else {
      bool useRadix2;
      useRadix2 = ((static_cast<int>(options_nfft) > 0) && ((static_cast<int>
        (options_nfft) & (static_cast<int>(options_nfft) - 1)) == 0));
      coder::internal::FFTImplementationCallback::get_algo_sizes((static_cast<
        int>(options_nfft)), (useRadix2), (&vlen), (&acoef));
      coder::internal::FFTImplementationCallback::generate_twiddle_tables((acoef),
        (useRadix2), (costab), (sintab), (sintabinv));
      if (useRadix2) {
        coder::internal::FFTImplementationCallback::r2br_r2dit_trig((xw), (
          static_cast<int>(options_nfft)), (costab), (sintab), (Xx));
      } else {
        coder::internal::FFTImplementationCallback::dobluesteinfft((xw), (vlen),
          (static_cast<int>(options_nfft)), (costab), (sintab), (sintabinv), (Xx));
      }
    }

    s2 = 0.0;
    vlen = win1.size(0);
    for (i1 = 0; i1 < vlen; i1++) {
      s2 += win1[i1] * win1[i1];
    }

    xw.set_size(Xx.size(0));
    vlen = Xx.size(0);
    for (i1 = 0; i1 < vlen; i1++) {
      noverlap = Xx[i1].re;
      cdiff = -Xx[i1].im;
      u1 = Xx[i1].re * noverlap - Xx[i1].im * cdiff;
      cdiff = Xx[i1].re * cdiff + Xx[i1].im * noverlap;
      if (cdiff == 0.0) {
        noverlap = u1 / s2;
      } else if (u1 == 0.0) {
        noverlap = 0.0;
      } else {
        noverlap = u1 / s2;
      }

      xw[i1] = noverlap;
    }

    if (ii + 1U == 1U) {
      Sxx1.set_size(xw.size(0), 1);
      vlen = xw.size(0);
      for (i1 = 0; i1 < vlen; i1++) {
        Sxx1[i1] = xw[i1];
      }
    } else {
      acoef = Sxx1.size(0);
      xw.set_size(Sxx1.size(0));
      vlen = Sxx1.size(0);
      for (i1 = 0; i1 < vlen; i1++) {
        xw[i1] = Sxx1[i1] + xw[i1];
      }

      vlen = Sxx1.size(0);
      Sxx1.set_size(vlen, 1);
      for (i1 = 0; i1 < acoef; i1++) {
        Sxx1[i1] = xw[i1];
      }
    }
  }

  vlen = Sxx1.size(0) * Sxx1.size(1);
  for (i = 0; i < vlen; i++) {
    Sxx1[i] = Sxx1[i] / k1;
  }

  coder::psdfreqvec(options.nfft, rtNaN, xw);
  vlen = xw.size(0);
  x0 = xw.reshape(vlen, 1);
  coder::computepsd(Sxx1, x0, options.range, options.nfft, W, b_xw, units_data,
                    units_size);

  //  Time domain features
  vlen = amplitudes_size[1];
  if (amplitudes_size[1] == 0) {
    s2 = 0.0;
  } else {
    s2 = amplitudes_data[0];
    for (k = 2; k <= vlen; k++) {
      s2 += amplitudes_data[k - 1];
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
  f_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  coder::ecdf(f_amplitudes_data, xw, b_xw);
  ecdf_f_T_size[0] = xw.size(0);
  vlen = xw.size(0);
  for (i = 0; i < vlen; i++) {
    ecdf_f_T_data[i] = xw[i];
  }

  ecdf_x_T_size[0] = b_xw.size(0);
  vlen = b_xw.size(0);
  for (i = 0; i < vlen; i++) {
    ecdf_x_T_data[i] = b_xw[i];
  }

  // E_T = entropy(amplitudes);
  g_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *I_T = coder::iqr(g_amplitudes_data);
  h_amplitudes_data.set(((double *)&amplitudes_data[0]), amplitudes_size[0],
                        amplitudes_size[1]);
  *Q_T = coder::trapz(h_amplitudes_data);
  *M_T = s2 / static_cast<double>(amplitudes_size[1]);
}

//
// File trailer for get_features.cpp
//
// [EOF]
//
