//
// File: CompactClassificationSVM.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 09-Dec-2021 00:19:42
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
        enum Transform
        {
          Logit = 0,                   // Default value
          Doublelogit,
          Invlogit,
          Ismax,
          Sign,
          Symmetric,
          Symmetricismax,
          Symmetriclogit,
          Identity
        };

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
          double Alpha[215];
          double Bias;
          double SupportVectorsT[18705];
          double Scale;
          double Order;
          coderutils::svm::KernelFunction b_KernelFunction;
          char ClassNames[16];
          int ClassNamesLength[2];
          coderutils::Transform ScoreTransform;
          double Prior[2];
          bool ClassLogicalIndices[2];
          double Cost[4];
        };

        class b_CompactClassificationSVM
        {
         public:
          void predict(const double Xin[87], cell_wrap_0 labels[1], double
                       scores[2]) const;
          double Alpha[124];
          double Bias;
          double SupportVectorsT[10788];
          double Scale;
          double Order;
          coderutils::svm::KernelFunction b_KernelFunction;
          char ClassNames[16];
          int ClassNamesLength[2];
          coderutils::Transform ScoreTransform;
          double Prior[2];
          bool ClassLogicalIndices[2];
          double Cost[4];
        };

        class c_CompactClassificationSVM
        {
         public:
          void predict(const double Xin[87], cell_wrap_0 labels[1], double
                       scores[2]) const;
          double Alpha[52];
          double Bias;
          double SupportVectorsT[4524];
          double Scale;
          double Order;
          coderutils::svm::KernelFunction b_KernelFunction;
          char ClassNames[12];
          int ClassNamesLength[2];
          coderutils::Transform ScoreTransform;
          double Prior[2];
          bool ClassLogicalIndices[2];
          double Cost[4];
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
