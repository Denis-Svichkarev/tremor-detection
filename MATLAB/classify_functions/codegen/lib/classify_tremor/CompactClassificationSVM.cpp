//
// File: CompactClassificationSVM.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 19-Feb-2021 19:57:50
//

// Include Files
#include "CompactClassificationSVM.h"
#include "Linear.h"
#include "classify_tremor_types.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
// Arguments    : const double Xin[48]
//                cell_wrap_0 labels[1]
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
        void CompactClassificationSVM::predict(const double Xin[48], cell_wrap_0
          labels[1], double scores[2]) const
        {
          double obj[9024];
          double dv[188];
          double b_Xin[48];
          double d;
          int i;
          int k;
          int loop_ub;
          bool b[2];
          bool b_tmp;
          bool exitg1;
          bool y;
          for (i = 0; i < 9024; i++) {
            obj[i] = this->SupportVectorsT[i] / 0.1116248622170551;
          }

          for (i = 0; i < 48; i++) {
            b_Xin[i] = Xin[i] / 0.1116248622170551;
          }

          coder::kernel::Linear(obj, b_Xin, dv);
          d = 0.0;
          for (i = 0; i < 188; i++) {
            d += dv[i] * this->Alpha[i];
          }

          scores[1] = 1.0 / (std::exp(-0.7673715 * (d + 1.9549047104846822) +
            -0.3849053) + 1.0);
          scores[0] = 1.0 - scores[1];
          b[0] = rtIsNaN(scores[0]);
          b_tmp = rtIsNaN(scores[1]);
          b[1] = b_tmp;
          y = true;
          k = 0;
          exitg1 = false;
          while ((!exitg1) && (k < 2)) {
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

          loop_ub = this->ClassNamesLength[k];
          labels[0].f1.size[0] = 1;
          labels[0].f1.size[1] = this->ClassNamesLength[k];
          for (i = 0; i < loop_ub; i++) {
            labels[0].f1.data[i] = this->ClassNames[k + (i << 1)];
          }

          if (!y) {
            if ((scores[0] < scores[1]) || (rtIsNaN(scores[0]) && (!b_tmp))) {
              k = 1;
            } else {
              k = 0;
            }

            loop_ub = this->ClassNamesLength[k];
            labels[0].f1.size[0] = 1;
            labels[0].f1.size[1] = this->ClassNamesLength[k];
            for (i = 0; i < loop_ub; i++) {
              labels[0].f1.data[i] = this->ClassNames[k + (i << 1)];
            }
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