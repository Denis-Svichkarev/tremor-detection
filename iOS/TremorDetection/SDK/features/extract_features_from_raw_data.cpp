//
// File: extract_features_from_raw_data.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//

// Include Files
#include "extract_features_from_raw_data.h"
#include "get_features.h"
#include "get_frequencies_spectrum.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <cstring>

// Function Definitions
//
// Arguments    : const double data[600]
//                double sample_number
//                coder::array<double, 2U> &data_features
// Return Type  : void
//
void extract_features_from_raw_data(const double data[600], double sample_number,
  coder::array<double, 2U> &data_features)
{
  coder::array<double, 2U> amp_X;
  coder::array<double, 2U> amp_Y;
  coder::array<double, 2U> amp_Z;
  coder::array<double, 2U> freq_X;
  double data_data[600];
  double amplitudes_X_data[301];
  double frequencies_X_data[301];
  double I_T_X;
  double I_T_Y;
  double I_T_Z;
  double I_X;
  double I_Y;
  double I_Z;
  double K_X;
  double K_Y;
  double K_Z;
  double M2_T_X;
  double M2_T_Y;
  double M2_T_Z;
  double M2_X;
  double M2_Y;
  double M2_Z;
  double M_T_X;
  double M_T_Y;
  double M_T_Z;
  double M_X;
  double M_Y;
  double M_Z;
  double Q_T_X;
  double Q_T_Y;
  double Q_T_Z;
  double Q_X;
  double Q_Y;
  double Q_Z;
  double SK_X;
  double SK_Y;
  double SK_Z;
  double S_T_X;
  double S_T_Y;
  double S_T_Z;
  double S_X;
  double S_Y;
  double S_Z;
  double maxValue_T_X;
  double maxValue_T_Y;
  double maxValue_T_Z;
  double maxValue_X;
  double maxValue_Y;
  double maxValue_Z;
  double minValue_T_X;
  double minValue_T_Y;
  double minValue_T_Z;
  double minValue_X;
  double minValue_Y;
  double minValue_Z;
  int amplitudes_X_size[2];
  int data_size[2];
  int frequencies_X_size[2];
  int i;
  int i1;
  int loop_ub;

  //  Extract features from raw data
  if (1.0 > sample_number) {
    loop_ub = 0;
  } else {
    loop_ub = static_cast<int>(sample_number);
  }

  data_size[0] = 1;
  data_size[1] = loop_ub;
  if (0 <= loop_ub - 1) {
    std::memcpy(&data_data[0], &data[0], loop_ub * sizeof(double));
  }

  get_frequencies_spectrum(data_data, data_size, amplitudes_X_data,
    amplitudes_X_size, frequencies_X_data, frequencies_X_size);
  get_features(amplitudes_X_data, amplitudes_X_size, frequencies_X_data,
               frequencies_X_size, freq_X, amp_X, &M_X, &S_X, &M2_X, &maxValue_X,
               &minValue_X, &I_X, &Q_X, &SK_X, &K_X, &M_T_X, &S_T_X, &M2_T_X,
               &maxValue_T_X, &minValue_T_X, &I_T_X, &Q_T_X);
  M_Z = sample_number * 2.0;
  if (sample_number + 1.0 > M_Z) {
    i = 0;
    i1 = 0;
  } else {
    i = static_cast<int>(sample_number + 1.0) - 1;
    i1 = static_cast<int>(M_Z);
  }

  data_size[0] = 1;
  loop_ub = i1 - i;
  data_size[1] = loop_ub;
  for (i1 = 0; i1 < loop_ub; i1++) {
    data_data[i1] = data[i + i1];
  }

  get_frequencies_spectrum(data_data, data_size, amplitudes_X_data,
    amplitudes_X_size, frequencies_X_data, frequencies_X_size);
  get_features(amplitudes_X_data, amplitudes_X_size, frequencies_X_data,
               frequencies_X_size, freq_X, amp_Y, &M_Y, &S_Y, &M2_Y, &maxValue_Y,
               &minValue_Y, &I_Y, &Q_Y, &SK_Y, &K_Y, &M_T_Y, &S_T_Y, &M2_T_Y,
               &maxValue_T_Y, &minValue_T_Y, &I_T_Y, &Q_T_Y);
  M_Z = sample_number * 2.0 + 1.0;
  S_Z = sample_number * 3.0;
  if (M_Z > S_Z) {
    i = 0;
    i1 = 0;
  } else {
    i = static_cast<int>(M_Z) - 1;
    i1 = static_cast<int>(S_Z);
  }

  data_size[0] = 1;
  loop_ub = i1 - i;
  data_size[1] = loop_ub;
  for (i1 = 0; i1 < loop_ub; i1++) {
    data_data[i1] = data[i + i1];
  }

  get_frequencies_spectrum(data_data, data_size, amplitudes_X_data,
    amplitudes_X_size, frequencies_X_data, frequencies_X_size);
  get_features(amplitudes_X_data, amplitudes_X_size, frequencies_X_data,
               frequencies_X_size, freq_X, amp_Z, &M_Z, &S_Z, &M2_Z, &maxValue_Z,
               &minValue_Z, &I_Z, &Q_Z, &SK_Z, &K_Z, &M_T_Z, &S_T_Z, &M2_T_Z,
               &maxValue_T_Z, &minValue_T_Z, &I_T_Z, &Q_T_Z);
  data_features.set_size(1, 0);
  i = amp_X.size(1);
  for (loop_ub = 0; loop_ub < i; loop_ub++) {
    i1 = data_features.size(1);
    data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
    data_features[i1] = amp_X[loop_ub];
  }

  i = amp_Y.size(1);
  for (loop_ub = 0; loop_ub < i; loop_ub++) {
    i1 = data_features.size(1);
    data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
    data_features[i1] = amp_Y[loop_ub];
  }

  i = amp_Z.size(1);
  for (loop_ub = 0; loop_ub < i; loop_ub++) {
    i1 = data_features.size(1);
    data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
    data_features[i1] = amp_Z[loop_ub];
  }

  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = S_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = S_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = S_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M2_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M2_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M2_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = maxValue_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = maxValue_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = maxValue_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = minValue_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = minValue_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = minValue_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = I_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = I_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = I_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = Q_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = Q_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = Q_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = SK_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = SK_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = SK_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = K_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = K_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = K_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M_T_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = S_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = S_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = S_T_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M2_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M2_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = M2_T_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = maxValue_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = maxValue_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = maxValue_T_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = minValue_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = minValue_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = minValue_T_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = I_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = I_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = I_T_Z;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = Q_T_X;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = Q_T_Y;
  i = data_features.size(1);
  data_features.set_size(data_features.size(0), (data_features.size(1) + 1));
  data_features[i] = Q_T_Z;
}

//
// File trailer for extract_features_from_raw_data.cpp
//
// [EOF]
//
