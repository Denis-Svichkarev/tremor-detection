/*
 * File: _coder_classify_accelerometer_data_api.c
 *
 * MATLAB Coder version            : 5.1
 * C/C++ source code generated on  : 13-Feb-2021 18:58:09
 */

/* Include Files */
#include "_coder_classify_accelerometer_data_api.h"
#include "_coder_classify_accelerometer_data_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131595U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "classify_accelerometer_data",       /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[48];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[48];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *X, const
  char_T *identifier))[48];
static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const cell_wrap_0
  u[1]);

/* Function Definitions */
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T (*)[48]
 */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[48]
{
  real_T (*y)[48];
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T (*)[48]
 */
  static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[48]
{
  static const int32_T dims[2] = { 1, 48 };

  real_T (*ret)[48];
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[48])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *X
 *                const char_T *identifier
 * Return Type  : real_T (*)[48]
 */
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *X, const
  char_T *identifier))[48]
{
  emlrtMsgIdentifier thisId;
  real_T (*y)[48];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(X), &thisId);
  emlrtDestroyArray(&X);
  return y;
}
/*
 * Arguments    : const emlrtStack *sp
 *                const cell_wrap_0 u[1]
 * Return Type  : const mxArray *
 */
  static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const
  cell_wrap_0 u[1])
{
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  int32_T iv1[2];
  int32_T iv[1];
  y = NULL;
  iv[0] = 1;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(1, iv));
  b_y = NULL;
  iv1[0] = u[0].f1.size[0];
  iv1[1] = u[0].f1.size[1];
  m = emlrtCreateCharArray(2, &iv1[0]);
  emlrtInitCharArrayR2013a(sp, u[0].f1.size[1], m, &u[0].f1.data[0]);
  emlrtAssign(&b_y, m);
  emlrtSetCell(y, 0, b_y);
  return y;
}

/*
 * Arguments    : const mxArray * const prhs[1]
 *                const mxArray *plhs[1]
 * Return Type  : void
 */
void classify_accelerometer_data_api(const mxArray * const prhs[1], const
  mxArray *plhs[1])
{
  cell_wrap_0 label[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  real_T (*X)[48];
  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  X = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "X");

  /* Invoke the target function */
  classify_accelerometer_data(*X, label);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&st, label);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void classify_accelerometer_data_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  classify_accelerometer_data_xil_terminate();
  classify_accelerometer_data_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void classify_accelerometer_data_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void classify_accelerometer_data_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_classify_accelerometer_data_api.c
 *
 * [EOF]
 */
