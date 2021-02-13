//
// File: CompactClassificationSVM.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 17:46:08
//

// Include Files
#include "CompactClassificationSVM.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const double Xin[48]
//                double *labels
//                double scores[2]
// Return Type  : void
//
namespace coder
{
  namespace classreg
  {
    namespace learning
    {
      namespace classif
      {
        void CompactClassificationSVM::predict(const double Xin[48], double
          *labels, double scores[2]) const
        {
          double f;
          int k;
          bool b[2];
          bool b_tmp;
          bool exitg1;
          bool y;
          f = 0.0;
          for (k = 0; k < 48; k++) {
            f += Xin[k] * this->Beta[k];
          }

          f += this->Bias;
          scores[0] = -f;
          scores[1] = f;
          b[0] = rtIsNaN(-f);
          b_tmp = rtIsNaN(f);
          b[1] = b_tmp;
          y = true;
          k = 0;
          exitg1 = false;
          while ((!exitg1) && (k <= 1)) {
            if (!b[k]) {
              y = false;
              exitg1 = true;
            } else {
              k++;
            }
          }

          if ((this->Prior[0] < this->Prior[1]) || (rtIsNaN(this->Prior[0]) && (
                !rtIsNaN(this->Prior[1])))) {
            k = 1;
          } else {
            k = 0;
          }

          *labels = this->ClassNames[k];
          if (!y) {
            if ((-f < f) || (rtIsNaN(-f) && (!b_tmp))) {
              k = 1;
            } else {
              k = 0;
            }

            *labels = this->ClassNames[k];
          }
        }
      }
    }
  }
}

//
// File trailer for CompactClassificationSVM.cpp
//
// [EOF]
//
