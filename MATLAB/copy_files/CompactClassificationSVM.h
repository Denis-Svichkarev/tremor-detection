//
// File: CompactClassificationSVM.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 19:14:56
//
#ifndef COMPACTCLASSIFICATIONSVM_H
#define COMPACTCLASSIFICATIONSVM_H

// Include Files
#include "rtwtypes.h"
#include <cstddef>
#include <cstdlib>

// Type Declarations
struct cell_wrap_0;

// Type Definitions
namespace coder
{
  namespace classreg
  {
    namespace learning
    {
      namespace coderutils
      {
        namespace svm
        {
          enum KernelFunction
          {
            linear = 1,                // Default value
            gaussian = 2,
            rbf = 2,
            polynomial = 3
          };
        }
      }

      namespace classif
      {
        class CompactClassificationSVM
        {
         public:
          void predict(const double Xin[87], cell_wrap_0 labels[1], double
                       scores[2]) const;
          double Alpha[11];
          double Bias;
          double SupportVectorsT[957];
          double Scale;
          double Order;
          coderutils::svm::KernelFunction b_KernelFunction;
          char ClassNames[16];
          int ClassNamesLength[2];
          double Prior[2];
          bool ClassLogicalIndices[2];
          double Cost[4];
          double ScoreTransformArguments[2];
        };

        class b_CompactClassificationSVM
        {
         public:
          void predict(const double Xin[87], cell_wrap_0 labels[1], double
                       scores[2]) const;
          double Alpha[9];
          double Bias;
          double SupportVectorsT[783];
          double Scale;
          double Order;
          coderutils::svm::KernelFunction b_KernelFunction;
          char ClassNames[16];
          int ClassNamesLength[2];
          double Prior[2];
          bool ClassLogicalIndices[2];
          double Cost[4];
          double ScoreTransformArguments[2];
        };
      }
    }
  }
}

#endif

//
// File trailer for CompactClassificationSVM.h
//
// [EOF]
//
