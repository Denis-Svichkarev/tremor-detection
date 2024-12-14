//
// File: get_features.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//
#ifndef GET_FEATURES_H
#define GET_FEATURES_H

// Include Files
#include "rtwtypes.h"
#include "coder_array.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
void get_features(const double amplitudes_data[], const int amplitudes_size[2],
                  const double frequencies_data[], const int frequencies_size[2],
                  coder::array<double, 2U> &freq, coder::array<double, 2U> &amp,
                  double *M, double *S, double *M2, double *maxValue, double
                  *minValue, double *b_I, double *Q, double *SK, double *K,
                  double *M_T, double *S_T, double *M2_T, double *maxValue_T,
                  double *minValue_T, double *I_T, double *Q_T);

#endif

//
// File trailer for get_features.h
//
// [EOF]
//
