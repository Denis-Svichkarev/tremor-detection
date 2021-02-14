//
// File: main.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 14-Feb-2021 13:23:25
//

//***********************************************************************
// This automatically generated example C++ main file shows how to call
// entry-point functions that MATLAB Coder generated. You must customize
// this file for your application. Do not modify this file directly.
// Instead, make a copy of this file, modify it, and integrate it into
// your development environment.
//
// This file initializes entry-point function arguments to a default
// size and value before calling the entry-point functions. It does
// not store or use any values returned from the entry-point functions.
// If necessary, it does pre-allocate memory for returned values.
// You can use this file as a starting point for a main function that
// you can deploy in your application.
//
// After you copy the file, and before you deploy it, you must make the
// following changes:
// * For variable-size function arguments, change the example sizes to
// the sizes that your application requires.
// * Change the example values of function arguments to the values that
// your application requires.
// * If the entry-point functions return values, store these values or
// otherwise use them as required by your application.
//
//***********************************************************************

// Include Files
#include "main.h"
#include "classify_accelerometer_data.h"
#include "classify_accelerometer_data_terminate.h"
#include "classify_accelerometer_data_types.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Declarations
static void argInit_1x48_real_T(double result[48]);
static double argInit_real_T();
static void main_classify_accelerometer_data();

// Function Definitions
//
// Arguments    : double result[48]
// Return Type  : void
//
static void argInit_1x48_real_T(double result[48])
{
  // Loop over the array to initialize each element.
  for (int idx1 = 0; idx1 < 48; idx1++) {
    // Set the value of the array element.
    // Change this value to the value that the application requires.
    result[idx1] = argInit_real_T();
  }
}

//
// Arguments    : void
// Return Type  : double
//
static double argInit_real_T()
{
  return 0.0;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_classify_accelerometer_data()
{
  cell_wrap_0 label[1];
  double dv[48];

  // Initialize function 'classify_accelerometer_data' input arguments.
  // Initialize function input argument 'X'.
  // Call the entry-point 'classify_accelerometer_data'.
  argInit_1x48_real_T(dv);
  classify_accelerometer_data(dv, label);
}

//
// Arguments    : int argc
//                const char * const argv[]
// Return Type  : int
//
int main(int, const char * const [])
{
  // The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. 
  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
  main_classify_accelerometer_data();

  // Terminate the application.
  // You do not need to do this more than one time.
  classify_accelerometer_data_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
