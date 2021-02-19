//
// File: extract_features_from_raw_data_internal_types.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 20:13:16
//
#ifndef EXTRACT_FEATURES_FROM_RAW_DATA_INTERNAL_TYPES_H
#define EXTRACT_FEATURES_FROM_RAW_DATA_INTERNAL_TYPES_H

// Include Files
#include "extract_features_from_raw_data_types.h"
#include "rtwtypes.h"

// Type Definitions
struct struct_T
{
  double nfft;
  double Fs;
  double conflevel;
  bool average;
  bool maxhold;
  bool minhold;
  bool MIMO;
  bool isNFFTSingle;
  bool centerdc;
  char range[8];
};

#endif

//
// File trailer for extract_features_from_raw_data_internal_types.h
//
// [EOF]
//
