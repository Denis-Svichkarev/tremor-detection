//
// File: CompactClassificationSVM.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:58:09
//
#ifndef COMPACTCLASSIFICATIONSVM_H
#define COMPACTCLASSIFICATIONSVM_H

// Include Files
#include "rtwtypes.h"
#include <cstddef>
#include <cstdlib>

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
      }

      namespace classif
      {
        class CompactClassificationSVM
        {
         public:
          void predict(const double Xin[48], double *labels, double scores[2])
            const;
          double Beta[48];
          double Bias;
          double Scale;
          double ClassNames[2];
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
