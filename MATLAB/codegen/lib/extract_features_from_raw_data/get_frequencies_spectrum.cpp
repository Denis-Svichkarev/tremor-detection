//
// File: get_frequencies_spectrum.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
//

// Include Files
#include "get_frequencies_spectrum.h"
#include "FFTImplementationCallback.h"
#include "extract_features_from_raw_data_data.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <cstring>
#include <string.h>

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
  coder::array<creal_T, 1U> y;
  coder::array<double, 2U> costab;
  coder::array<double, 2U> sintab;
  coder::array<double, 2U> sintabinv;
  coder::array<double, 1U> b_signal_data;
  coder::array<double, 1U> c_signal_data;
  creal_T Y_data[600];
  double P2_data[600];
  int N2blue;
  int i;
  int i1;
  int loop_ub;
  int nRows;

  //  FFT spectrum from signal
  //  sampling frequency
  if (signal_size[1] == 0) {
    nRows = 0;
  } else {
    bool useRadix2;
    useRadix2 = ((signal_size[1] & (signal_size[1] - 1)) == 0);
    coder::internal::FFTImplementationCallback::get_algo_sizes((signal_size[1]),
      (useRadix2), (&N2blue), (&nRows));
    coder::internal::FFTImplementationCallback::generate_twiddle_tables((nRows),
      (useRadix2), (costab), (sintab), (sintabinv));
    if (useRadix2) {
      c_signal_data.set(((double *)&signal_data[0]), signal_size[1]);
      coder::internal::FFTImplementationCallback::r2br_r2dit_trig((c_signal_data),
        (signal_size[1]), (costab), (sintab), (y));
    } else {
      b_signal_data.set(((double *)&signal_data[0]), signal_size[1]);
      coder::internal::FFTImplementationCallback::dobluesteinfft((b_signal_data),
        (N2blue), (signal_size[1]), (costab), (sintab), (sintabinv), (y));
    }

    nRows = signal_size[1];
    loop_ub = signal_size[1];
    for (i = 0; i < loop_ub; i++) {
      Y_data[i] = y[i];
    }
  }

  N2blue = signal_size[1];
  loop_ub = nRows - 1;
  for (i = 0; i <= loop_ub; i++) {
    double ai;
    double im;
    double re;
    im = Y_data[i].re;
    ai = Y_data[i].im;
    if (ai == 0.0) {
      re = im / static_cast<double>(N2blue);
      im = 0.0;
    } else if (im == 0.0) {
      re = 0.0;
      im = ai / static_cast<double>(N2blue);
    } else {
      re = im / static_cast<double>(N2blue);
      im = ai / static_cast<double>(N2blue);
    }

    Y_data[i].re = re;
    Y_data[i].im = im;
  }

  for (N2blue = 0; N2blue < nRows; N2blue++) {
    P2_data[N2blue] = rt_hypotd_snf(Y_data[N2blue].re, Y_data[N2blue].im);
  }

  nRows = static_cast<int>(std::floor(static_cast<double>(signal_size[1]) / 2.0));
  N2blue = nRows + 1;
  amplitudes_size[0] = 1;
  amplitudes_size[1] = nRows + 1;
  if (0 <= N2blue - 1) {
    std::memcpy(&amplitudes_data[0], &P2_data[0], N2blue * sizeof(double));
  }

  if (2 > static_cast<short>(nRows + 1) - 1) {
    i = 0;
    i1 = 1;
    N2blue = 0;
  } else {
    i = 1;
    i1 = static_cast<short>(nRows + 1);
    N2blue = 1;
  }

  loop_ub = i1 - i;
  for (i1 = 0; i1 <= loop_ub - 2; i1++) {
    amplitudes_data[N2blue + i1] = 2.0 * P2_data[i + i1];
  }

  costab.set_size(1, (nRows + 1));
  for (i = 0; i <= nRows; i++) {
    costab[i] = i;
  }

  frequencies_size[0] = 1;
  frequencies_size[1] = costab.size(1);
  loop_ub = costab.size(0) * costab.size(1);
  for (i = 0; i < loop_ub; i++) {
    frequencies_data[i] = 100.0 * costab[i] / static_cast<double>(signal_size[1]);
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
