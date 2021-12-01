//
// File: get_frequencies_spectrum.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//

// Include Files
#include "get_frequencies_spectrum.h"
#include "FFTImplementationCallback.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <cstring>

// Function Declarations
static double rt_hypotd_snf(double u0, double u1);

// Function Definitions
//
// Arguments    : double u0
//                double u1
// Return Type  : double
//
static double rt_hypotd_snf(double u0, double u1)
{
  double a;
  double y;
  a = std::abs(u0);
  y = std::abs(u1);
  if (a < y) {
    a /= y;
    y *= std::sqrt(a * a + 1.0);
  } else if (a > y) {
    y /= a;
    y = a * std::sqrt(y * y + 1.0);
  } else {
    if (!rtIsNaN(y)) {
      y = a * 1.4142135623730951;
    }
  }

  return y;
}

//
// Arguments    : const double signal_data[]
//                const int signal_size[2]
//                double amplitudes_data[]
//                int amplitudes_size[2]
//                double frequencies_data[]
//                int frequencies_size[2]
// Return Type  : void
//
void get_frequencies_spectrum(const double signal_data[], const int signal_size
  [2], double amplitudes_data[], int amplitudes_size[2], double
  frequencies_data[], int frequencies_size[2])
{
  static creal_T y_data[2400];
  creal_T Y_data[600];
  creal_T yCol_data[600];
  double costab_data[1201];
  double sintab_data[1201];
  double sintabinv_data[1201];
  double costab1q_data[601];
  double P2_data[600];
  double temp_im;
  double temp_re;
  int costab_size[2];
  int b_signal[1];
  int yCol_size[1];
  int iDelta2;
  int iheight;
  int k;
  int pmax;
  int pmin;
  int pow2p;
  int y_size_idx_0;

  //  FFT spectrum from signal
  //  sampling frequency
  if (signal_size[1] == 0) {
    pmax = 0;
  } else {
    int n;
    bool useRadix2;
    useRadix2 = ((signal_size[1] & (signal_size[1] - 1)) == 0);
    iDelta2 = 1;
    if (useRadix2) {
      pmax = signal_size[1];
    } else {
      n = (signal_size[1] + signal_size[1]) - 1;
      pmax = 31;
      if (n <= 1) {
        pmax = 0;
      } else {
        bool exitg1;
        pmin = 0;
        exitg1 = false;
        while ((!exitg1) && (pmax - pmin > 1)) {
          k = (pmin + pmax) >> 1;
          pow2p = 1 << k;
          if (pow2p == n) {
            pmax = k;
            exitg1 = true;
          } else if (pow2p > n) {
            pmax = k;
          } else {
            pmin = k;
          }
        }
      }

      iDelta2 = 1 << pmax;
      pmax = iDelta2;
    }

    temp_im = 6.2831853071795862 / static_cast<double>(pmax);
    n = pmax / 2 / 2;
    pow2p = n + 1;
    costab1q_data[0] = 1.0;
    pmax = n / 2 - 1;
    for (k = 0; k <= pmax; k++) {
      costab1q_data[k + 1] = std::cos(temp_im * (static_cast<double>(k) + 1.0));
    }

    y_size_idx_0 = pmax + 2;
    iheight = n - 1;
    for (k = y_size_idx_0; k <= iheight; k++) {
      costab1q_data[k] = std::sin(temp_im * static_cast<double>(n - k));
    }

    costab1q_data[n] = 0.0;
    if (!useRadix2) {
      pmin = n << 1;
      costab_size[0] = 1;
      costab_size[1] = static_cast<short>(pmin + 1);
      costab_data[0] = 1.0;
      sintab_data[0] = 0.0;
      for (k = 0; k < n; k++) {
        sintabinv_data[k + 1] = costab1q_data[(n - k) - 1];
      }

      for (k = pow2p; k <= pmin; k++) {
        sintabinv_data[k] = costab1q_data[k - n];
      }

      for (k = 0; k < n; k++) {
        costab_data[k + 1] = costab1q_data[k + 1];
        sintab_data[k + 1] = -costab1q_data[(n - k) - 1];
      }

      for (k = pow2p; k <= pmin; k++) {
        costab_data[k] = -costab1q_data[pmin - k];
        sintab_data[k] = -costab1q_data[k - n];
      }
    } else {
      pmin = n << 1;
      costab_size[0] = 1;
      costab_size[1] = static_cast<short>(pmin + 1);
      costab_data[0] = 1.0;
      sintab_data[0] = 0.0;
      for (k = 0; k < n; k++) {
        costab_data[k + 1] = costab1q_data[k + 1];
        sintab_data[k + 1] = -costab1q_data[(n - k) - 1];
      }

      for (k = pow2p; k <= pmin; k++) {
        costab_data[k] = -costab1q_data[pmin - k];
        sintab_data[k] = -costab1q_data[k - n];
      }
    }

    if (useRadix2) {
      yCol_size[0] = static_cast<short>(signal_size[1]);
      if (signal_size[1] != 1) {
        b_signal[0] = signal_size[1];
        coder::internal::fft::FFTImplementationCallback::doHalfLengthRadix2
          ((signal_data), (b_signal), (yCol_data), (yCol_size), (signal_size[1]),
           (costab_data), (costab_size), (sintab_data));
      } else {
        k = 0;
        yCol_data[0].re = signal_data[0];
        yCol_data[0].im = 0.0;
        y_size_idx_0 = static_cast<short>(signal_size[1]);
        pow2p = static_cast<short>(signal_size[1]);
        if (0 <= pow2p - 1) {
          std::memcpy(&y_data[0], &yCol_data[0], pow2p * sizeof(creal_T));
        }

        pow2p = 2;
        iDelta2 = 4;
        iheight = -3;
        while (k > 0) {
          for (pmax = 0; pmax < iheight; pmax += iDelta2) {
            pmin = pmax + pow2p;
            temp_re = y_data[pmin].re;
            temp_im = y_data[pmin].im;
            y_data[pmin].re = y_data[pmax].re - temp_re;
            y_data[pmin].im = y_data[pmax].im - temp_im;
            y_data[pmax].re += temp_re;
            y_data[pmax].im += temp_im;
          }

          k = 0;
          pow2p = iDelta2;
          iDelta2 += iDelta2;
          iheight -= pow2p;
        }

        if (0 <= y_size_idx_0 - 1) {
          std::memcpy(&yCol_data[0], &y_data[0], y_size_idx_0 * sizeof(creal_T));
        }
      }
    } else {
      b_signal[0] = signal_size[1];
      coder::internal::fft::FFTImplementationCallback::dobluesteinfft
        ((signal_data), (b_signal), (iDelta2), (signal_size[1]), (costab_data),
         (costab_size), (sintab_data), (sintabinv_data), (yCol_data), (yCol_size));
    }

    pmax = signal_size[1];
    pow2p = signal_size[1];
    if (0 <= pow2p - 1) {
      std::memcpy(&Y_data[0], &yCol_data[0], pow2p * sizeof(creal_T));
    }
  }

  temp_re = signal_size[1];
  pow2p = pmax - 1;
  for (y_size_idx_0 = 0; y_size_idx_0 <= pow2p; y_size_idx_0++) {
    double ai;
    double re;
    temp_im = Y_data[y_size_idx_0].re;
    ai = Y_data[y_size_idx_0].im;
    if (ai == 0.0) {
      re = temp_im / temp_re;
      temp_im = 0.0;
    } else if (temp_im == 0.0) {
      re = 0.0;
      temp_im = ai / temp_re;
    } else {
      re = temp_im / temp_re;
      temp_im = ai / temp_re;
    }

    Y_data[y_size_idx_0].re = re;
    Y_data[y_size_idx_0].im = temp_im;
  }

  for (k = 0; k < pmax; k++) {
    P2_data[k] = rt_hypotd_snf(Y_data[k].re, Y_data[k].im);
  }

  pmin = static_cast<int>(std::floor(static_cast<double>(signal_size[1]) / 2.0));
  pmax = pmin + 1;
  amplitudes_size[0] = 1;
  amplitudes_size[1] = pmin + 1;
  if (0 <= pmax - 1) {
    std::memcpy(&amplitudes_data[0], &P2_data[0], pmax * sizeof(double));
  }

  if (2 > static_cast<short>(pmin + 1) - 1) {
    y_size_idx_0 = 0;
    iheight = 1;
    pmax = 0;
  } else {
    y_size_idx_0 = 1;
    iheight = static_cast<short>(pmin + 1);
    pmax = 1;
  }

  pow2p = iheight - y_size_idx_0;
  for (iheight = 0; iheight <= pow2p - 2; iheight++) {
    amplitudes_data[pmax + iheight] = 2.0 * P2_data[y_size_idx_0 + iheight];
  }

  frequencies_size[1] = pmin + 1;
  for (y_size_idx_0 = 0; y_size_idx_0 <= pmin; y_size_idx_0++) {
    frequencies_data[y_size_idx_0] = y_size_idx_0;
  }

  frequencies_size[0] = 1;
  for (y_size_idx_0 = 0; y_size_idx_0 <= pmin; y_size_idx_0++) {
    frequencies_data[y_size_idx_0] = 100.0 * frequencies_data[y_size_idx_0] /
      static_cast<double>(signal_size[1]);
  }

  //  fs = 100;               % sampling frequency
  //  t = 0:(1/fs):(10-1/fs); % time vector
  //
  //  n = length(timewindow);
  //  X = fft(timewindow);
  //
  //  f = (0:n-1)*(fs/n);     %frequency range
  //  power = abs(X).^2/n;    %power
  //  plot(f, power); hold on;
}

//
// File trailer for get_frequencies_spectrum.cpp
//
// [EOF]
//
