//
// File: get_features.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 20:13:16
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
                  *minValue, coder::array<double, 1U> &ecdf_f, coder::array<
                  double, 1U> &ecdf_x, double *b_I, double *Q, double *SK,
                  double *K, coder::array<double, 2U> &W, double *M_T, double
                  *S_T, double *M2_T, double *maxValue_T, double *minValue_T,
                  double ecdf_f_T_data[], int ecdf_f_T_size[1], double
                  ecdf_x_T_data[], int ecdf_x_T_size[1], double *I_T, double
                  *Q_T);

#endif

//
// File trailer for get_features.h
//
// [EOF]
//
