/*
 * File: _coder_classify_accelerometer_data_api.h
 *
 * MATLAB Coder version            : 5.1
 * C/C++ source code generated on  : 13-Feb-2021 17:46:08
 */

#ifndef _CODER_CLASSIFY_ACCELEROMETER_DATA_API_H
#define _CODER_CLASSIFY_ACCELEROMETER_DATA_API_H

/* Include Files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Type Definitions */
#ifndef struct_emxArray_char_T_1x10
#define struct_emxArray_char_T_1x10

struct emxArray_char_T_1x10
{
  char_T data[10];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_char_T_1x10*/

#ifndef typedef_emxArray_char_T_1x10
#define typedef_emxArray_char_T_1x10

typedef struct emxArray_char_T_1x10 emxArray_char_T_1x10;

#endif                                 /*typedef_emxArray_char_T_1x10*/

#ifndef typedef_cell_wrap_0
#define typedef_cell_wrap_0

typedef struct {
  emxArray_char_T_1x10 f1;
} cell_wrap_0;

#endif                                 /*typedef_cell_wrap_0*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus

extern "C" {

#endif

  /* Function Declarations */
  void classify_accelerometer_data(real_T X[48], cell_wrap_0 label[1]);
  void classify_accelerometer_data_api(const mxArray * const prhs[1], const
    mxArray *plhs[1]);
  void classify_accelerometer_data_atexit(void);
  void classify_accelerometer_data_initialize(void);
  void classify_accelerometer_data_terminate(void);
  void classify_accelerometer_data_xil_shutdown(void);
  void classify_accelerometer_data_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for _coder_classify_accelerometer_data_api.h
 *
 * [EOF]
 */
