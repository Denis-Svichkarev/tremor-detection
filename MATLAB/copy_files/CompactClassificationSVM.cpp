//
// File: CompactClassificationSVM.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 03-Dec-2021 23:13:20
//

// Include Files
#include "CompactClassificationSVM.h"
#include "Linear.h"
#include "classify_accelerometer_types.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
// Arguments    : const double Xin[87]
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
        void CompactClassificationSVM::predict(const double Xin[87], cell_wrap_0
          labels[1], double scores[2]) const
        {
          double obj[1566];
          double b_Xin[87];
          double dv[18];
          double d;
          double d1;
          int i;
          int k;
          int loop_ub;
          bool b[2];
          bool b_tmp;
          bool exitg1;
          bool y;
          for (i = 0; i < 1566; i++) {
            obj[i] = this->SupportVectorsT[i] / 1.6714765594064072;
          }

          for (i = 0; i < 87; i++) {
            b_Xin[i] = Xin[i] / 1.6714765594064072;
          }

          coder::kernel::Linear(obj, b_Xin, dv);
          d = 0.0;
          for (i = 0; i < 18; i++) {
            d += dv[i] * this->Alpha[i];
          }

          for (i = 0; i < 1566; i++) {
            obj[i] = this->SupportVectorsT[i] / 1.6714765594064072;
          }

          for (i = 0; i < 87; i++) {
            b_Xin[i] = Xin[i] / 1.6714765594064072;
          }

          coder::kernel::Linear(obj, b_Xin, dv);
          d1 = 0.0;
          for (i = 0; i < 18; i++) {
            d1 += dv[i] * this->Alpha[i];
          }

          scores[0] = 1.0 / (std::exp(d + 14.884357379312677) + 1.0);
          scores[1] = 1.0 / (std::exp(-(d1 + 14.884357379312677)) + 1.0);
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

        //
        // Arguments    : const double Xin[87]
        //                cell_wrap_0 labels[1]
        //                double scores[2]
        // Return Type  : void
        //
        void b_CompactClassificationSVM::predict(const double Xin[87],
          cell_wrap_0 labels[1], double scores[2]) const
        {
          double obj[1131];
          double b_Xin[87];
          double dv[13];
          double d;
          double d1;
          int i;
          int k;
          int loop_ub;
          bool b[2];
          bool b_tmp;
          bool exitg1;
          bool y;
          for (i = 0; i < 1131; i++) {
            obj[i] = this->SupportVectorsT[i] / 0.025500262326221813;
          }

          for (i = 0; i < 87; i++) {
            b_Xin[i] = Xin[i] / 0.025500262326221813;
          }

          coder::kernel::b_Linear(obj, b_Xin, dv);
          d = 0.0;
          for (i = 0; i < 13; i++) {
            d += dv[i] * this->Alpha[i];
          }

          for (i = 0; i < 1131; i++) {
            obj[i] = this->SupportVectorsT[i] / 0.025500262326221813;
          }

          for (i = 0; i < 87; i++) {
            b_Xin[i] = Xin[i] / 0.025500262326221813;
          }

          coder::kernel::b_Linear(obj, b_Xin, dv);
          d1 = 0.0;
          for (i = 0; i < 13; i++) {
            d1 += dv[i] * this->Alpha[i];
          }

          scores[0] = 1.0 / (std::exp(d + -0.38865165524811857) + 1.0);
          scores[1] = 1.0 / (std::exp(-(d1 + -0.38865165524811857)) + 1.0);
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

        //
        // Arguments    : const double Xin[87]
        //                cell_wrap_0 labels[1]
        //                double scores[2]
        // Return Type  : void
        //
        void c_CompactClassificationSVM::predict(const double Xin[87],
          cell_wrap_0 labels[1], double scores[2]) const
        {
          double obj[1218];
          double b_Xin[87];
          double dv[14];
          double d;
          double d1;
          int i;
          int k;
          bool b[2];
          bool b_tmp;
          bool exitg1;
          bool y;
          for (i = 0; i < 1218; i++) {
            obj[i] = this->SupportVectorsT[i] / 9.89180666785809;
          }

          for (i = 0; i < 87; i++) {
            b_Xin[i] = Xin[i] / 9.89180666785809;
          }

          coder::kernel::c_Linear(obj, b_Xin, dv);
          d = 0.0;
          for (i = 0; i < 14; i++) {
            d += dv[i] * this->Alpha[i];
          }

          for (i = 0; i < 1218; i++) {
            obj[i] = this->SupportVectorsT[i] / 9.89180666785809;
          }

          for (i = 0; i < 87; i++) {
            b_Xin[i] = Xin[i] / 9.89180666785809;
          }

          coder::kernel::c_Linear(obj, b_Xin, dv);
          d1 = 0.0;
          for (i = 0; i < 14; i++) {
            d1 += dv[i] * this->Alpha[i];
          }

          scores[0] = 1.0 / (std::exp(d + 3.32053161977455) + 1.0);
          scores[1] = 1.0 / (std::exp(-(d1 + 3.32053161977455)) + 1.0);
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

          labels[0].f1.size[0] = 1;
          labels[0].f1.size[1] = 6;
          for (i = 0; i < 6; i++) {
            labels[0].f1.data[i] = this->ClassNames[k + (i << 1)];
          }

          if (!y) {
            if ((scores[0] < scores[1]) || (rtIsNaN(scores[0]) && (!b_tmp))) {
              k = 1;
            } else {
              k = 0;
            }

            labels[0].f1.size[0] = 1;
            labels[0].f1.size[1] = 6;
            for (i = 0; i < 6; i++) {
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