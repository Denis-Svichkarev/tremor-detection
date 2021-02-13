/*
 * File: _coder_extract_features_from_raw_data_api.h
 *
 * MATLAB Coder version            : 5.1
 * C/C++ source code generated on  : 13-Feb-2021 18:42:55
 */

#ifndef _CODER_EXTRACT_FEATURES_FROM_RAW_DATA_API_H
#define _CODER_EXTRACT_FEATURES_FROM_RAW_DATA_API_H

/* Include Files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus

extern "C" {

#endif

  /* Function Declarations */
  void extract_features_from_raw_data(real_T data[600], real_T sample_number,
    emxArray_real_T *data_features);
  void extract_features_from_raw_data_api(const mxArray * const prhs[2], const
    mxArray *plhs[1]);
  void extract_features_from_raw_data_atexit(void);
  void extract_features_from_raw_data_initialize(void);
  void extract_features_from_raw_data_terminate(void);
  void extract_features_from_raw_data_xil_shutdown(void);
  void extract_features_from_raw_data_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for _coder_extract_features_from_raw_data_api.h
 *
 * [EOF]
 */
