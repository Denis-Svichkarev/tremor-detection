/*
 * File: _coder_classify_tremor_api.h
 *
 * MATLAB Coder version            : 5.1
 * C/C++ source code generated on  : 18-Feb-2021 11:04:08
 */

#ifndef _CODER_CLASSIFY_TREMOR_API_H
#define _CODER_CLASSIFY_TREMOR_API_H

/* Include Files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Type Definitions */
#ifndef struct_emxArray_char_T_1x8
#define struct_emxArray_char_T_1x8

struct emxArray_char_T_1x8
{
  char_T data[8];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_char_T_1x8*/

#ifndef typedef_emxArray_char_T_1x8
#define typedef_emxArray_char_T_1x8

typedef struct emxArray_char_T_1x8 emxArray_char_T_1x8;

#endif                                 /*typedef_emxArray_char_T_1x8*/

#ifndef typedef_cell_wrap_0
#define typedef_cell_wrap_0

typedef struct {
  emxArray_char_T_1x8 f1;
} cell_wrap_0;

#endif                                 /*typedef_cell_wrap_0*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus

extern "C" {

#endif

  /* Function Declarations */
  void classify_tremor(real_T X[48], cell_wrap_0 label[1], real_T p[2]);
  void classify_tremor_api(const mxArray * const prhs[1], int32_T nlhs, const
    mxArray *plhs[2]);
  void classify_tremor_atexit(void);
  void classify_tremor_initialize(void);
  void classify_tremor_terminate(void);
  void classify_tremor_xil_shutdown(void);
  void classify_tremor_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for _coder_classify_tremor_api.h
 *
 * [EOF]
 */
