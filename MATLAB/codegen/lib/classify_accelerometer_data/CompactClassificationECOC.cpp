//
// File: CompactClassificationECOC.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 17:46:08
//

// Include Files
#include "CompactClassificationECOC.h"
#include "CompactClassificationSVM.h"
#include "classify_accelerometer_data_types.h"
#include "minOrMax.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <string.h>

// Function Definitions
//
// Arguments    : const double Xin[48]
//                cell_wrap_0 labels[1]
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
        void CompactClassificationECOC::predict(const double Xin[48],
          cell_wrap_0 labels[1]) const
        {
          double M[9];
          double negloss[3];
          double scores[2];
          double b_labels;
          double pscore_idx_0;
          double pscore_idx_1;
          double pscore_idx_2;
          double y;
          int c;
          int i;
          int k;
          bool b[3];
          bool b_y;
          bool exitg1;
          for (c = 0; c < 9; c++) {
            b_labels = this->CodingMatrix[c];
            M[c] = b_labels;
            if (b_labels == 0.0) {
              M[c] = rtNaN;
            }
          }

          this->BinaryLearners[0].predict(Xin, (&b_labels), scores);
          pscore_idx_0 = scores[1];
          this->BinaryLearners[1].predict(Xin, (&b_labels), scores);
          pscore_idx_1 = scores[1];
          this->BinaryLearners[2].predict(Xin, (&b_labels), scores);
          pscore_idx_2 = scores[1];
          for (k = 0; k < 3; k++) {
            y = 0.0;
            c = 0;
            b_labels = 1.0 - M[k] * pscore_idx_0;
            if ((0.0 > b_labels) || rtIsNaN(b_labels)) {
              b_labels = 0.0;
            }

            if (!rtIsNaN(b_labels)) {
              y = b_labels;
              c = 1;
            }

            b_labels = 1.0 - M[k + 3] * pscore_idx_1;
            if ((0.0 > b_labels) || rtIsNaN(b_labels)) {
              b_labels = 0.0;
            }

            if (!rtIsNaN(b_labels)) {
              y += b_labels;
              c++;
            }

            b_labels = 1.0 - M[k + 6] * pscore_idx_2;
            if ((0.0 > b_labels) || rtIsNaN(b_labels)) {
              b_labels = 0.0;
            }

            if (!rtIsNaN(b_labels)) {
              y += b_labels;
              c++;
            }

            if (c == 0) {
              y = rtNaN;
            } else {
              y /= static_cast<double>(c);
            }

            negloss[k] = -(y / 2.0);
          }

          b[0] = rtIsNaN(negloss[0]);
          b[1] = rtIsNaN(negloss[1]);
          b[2] = rtIsNaN(negloss[2]);
          b_y = true;
          k = 0;
          exitg1 = false;
          while ((!exitg1) && (k <= 2)) {
            if (!b[k]) {
              b_y = false;
              exitg1 = true;
            } else {
              k++;
            }
          }

          internal::maximum(this->Prior, &b_labels, &k);
          c = this->ClassNamesLength[k - 1];
          labels[0].f1.size[0] = 1;
          labels[0].f1.size[1] = c;
          for (i = 0; i < c; i++) {
            labels[0].f1.data[i] = this->ClassNames[(k + 3 * i) - 1];
          }

          if (!b_y) {
            internal::maximum(negloss, &b_labels, &k);
            i = k;
            if (k < 0) {
              i = 0;
            }

            c = this->ClassNamesLength[i - 1];
            if (k < 0) {
              k = 0;
            }

            labels[0].f1.size[0] = 1;
            labels[0].f1.size[1] = c;
            for (i = 0; i < c; i++) {
              labels[0].f1.data[i] = this->ClassNames[(k + 3 * i) - 1];
            }
          }
        }
      }
    }
  }
}

//
// File trailer for CompactClassificationECOC.cpp
//
// [EOF]
//
