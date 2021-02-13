//
// File: CompactClassificationECOC.h
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:58:09
//
#ifndef COMPACTCLASSIFICATIONECOC_H
#define COMPACTCLASSIFICATIONECOC_H

// Include Files
#include "CompactClassificationSVM.h"
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
      namespace classif
      {
        class CompactClassificationECOC
        {
         public:
          void predict(const double Xin[48], cell_wrap_0 labels[1]) const;
          char ClassNames[30];
          int ClassNamesLength[3];
          coderutils::Transform ScoreTransform;
          double Prior[3];
          bool ClassLogicalIndices[3];
          double Cost[9];
          CompactClassificationSVM BinaryLearners[3];
          double CodingMatrix[9];
          char ScoreType[3];
        };
      }
    }
  }
}

#endif

//
// File trailer for CompactClassificationECOC.h
//
// [EOF]
//
