//
// File: main.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:42:55
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
#include "extract_features_from_raw_data.h"
#include "extract_features_from_raw_data_terminate.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <string.h>

// Function Declarations
static void argInit_1x600_real_T(double result[600]);
static double argInit_real_T();
static void main_extract_features_from_raw_data();

// Function Definitions
//
// Arguments    : double result[600]
// Return Type  : void
//
static void argInit_1x600_real_T(double result[600])
{
  // Loop over the array to initialize each element.
  for (int idx1 = 0; idx1 < 600; idx1++) {
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
static void main_extract_features_from_raw_data()
{
  coder::array<double, 2U> data_features;
  double dv[600];

  // Initialize function 'extract_features_from_raw_data' input arguments.
  // Initialize function input argument 'data'.
  // Call the entry-point 'extract_features_from_raw_data'.
  argInit_1x600_real_T(dv);
  extract_features_from_raw_data(dv, argInit_real_T(), data_features);
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
  main_extract_features_from_raw_data();

  // Terminate the application.
  // You do not need to do this more than one time.
  extract_features_from_raw_data_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
