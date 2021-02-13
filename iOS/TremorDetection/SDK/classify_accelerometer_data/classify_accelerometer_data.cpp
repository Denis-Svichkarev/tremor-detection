//
// File: classify_accelerometer_data.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 18:58:09
//

// Include Files
#include "classify_accelerometer_data.h"
#include "CompactClassificationECOC.h"
#include "CompactClassificationSVM.h"
#include "classify_accelerometer_data_types.h"
#include "rt_nonfinite.h"
#include <cstring>
#include <string.h>

// Function Definitions
//
// Arguments    : const double X[48]
//                cell_wrap_0 label[1]
// Return Type  : void
//
void classify_accelerometer_data(const double X[48], cell_wrap_0 label[1])
{
  static const double dv[48] = { -2.7925544569436527, -2.3221953791569145,
    -2.0293322352328476, -1.7409522330804139, -1.628223347948337,
    -1.5474900847497302, -1.4650614719175812, -1.3635859849012626,
    -1.2439329980565557, -1.1703386801378133, -1.1491137255536534,
    -1.0198688858347935, -1.0222503604835584, -2.847114274198324,
    -2.2903148966194613, -1.8972349861151452, -1.7686721450041618,
    -1.6256110730575286, -1.5108775627984246, -1.33908543124719,
    -1.3098074305556782, -1.32384405021164, -1.2516102326028311,
    -1.2267793728097693, -1.2131775426475602, -1.1520543409617612,
    -3.1217281182574128, -2.6567263136580808, -2.3070784369864357,
    -1.9449503625817735, -1.7957442831543982, -1.8554263773871544,
    -1.6285562440181787, -1.6632739906272973, -1.6482017854747917,
    -1.570388919103705, -1.5743732548094069, -1.4480443830777405,
    -1.4033355731762307, -1.5765307572305476, -1.5966294876022671,
    -1.8936790801778924, -0.79806998112514482, -0.78015892014364452,
    -0.93683309196973774, -1.4491280747739215, -1.4971089486509666,
    -1.78537888712213 };

  static const double dv1[48] = { -1.6704524749931262, -1.4681571476263047,
    -1.4092646487205696, -1.4476821054035669, -1.5640579563311054,
    -1.5215559124875815, -1.8577306911509193, -1.6972180327646202,
    -1.5936306497714896, -1.5687065652997663, -1.3849980485339852,
    -1.3353476410692005, -1.23383014765548, -1.5588329541905186,
    -1.3162203680542612, -1.201820457097392, -1.3629225556214866,
    -1.2882565433743005, -1.2850522946849399, -1.3452764735574507,
    -1.4198065803154016, -1.397647864803143, -1.3840458161276148,
    -1.3882530547669507, -1.2598582392958744, -1.217633211875377,
    -2.4152882023307183, -2.5362961018677996, -2.4063041451087845,
    -2.692039450126809, -2.6857029438653823, -3.0452122697543387,
    -3.9768693683889307, -3.75026501374424, -3.3563071942983846,
    -3.2852182337502875, -2.9440605431257425, -2.50833338181331,
    -2.1700510484096718, -1.5194332324467474, -1.3404328010588238,
    -2.9055344535834151, -0.87885291952438083, -0.7334610294807592,
    -1.7910489216338759, -1.3841773299417959, -1.2392237455645121,
    -2.6108803624386172 };

  static const double dv2[48] = { 0.49909885746879812, 0.46454281901429284,
    0.053085226176621994, -0.3759673421059887, -0.77945464407405551,
    -0.86229170514004849, -1.1388872014442502, -1.2654286460079784,
    -1.1284301309007805, -1.2641870798497978, -0.8918303747895413,
    -1.1228381340803568, -0.7246192254844851, 0.69354383926582308,
    0.585693166257534, 0.40592945731181318, -0.14268580897854014,
    -0.17595656205267821, -0.43861486570572344, -0.64054962752829514,
    -0.67833314076752116, -0.7406861645947368, -0.87808574056143485,
    -0.87855056857864855, -0.77327893769769207, -0.57961772405746315,
    0.017045942165555536, -0.57641899269911667, -0.96884419848561287,
    -2.2426319898418479, -2.5784310203865006, -3.0872800561618439,
    -4.0325029253779077, -3.808573064826851, -3.0518826006571218,
    -3.4096884175322848, -2.5637428310728851, -2.5710441597722218,
    -1.7512292043639235, -0.65670827547827515, -0.3262455905913515,
    -2.3557864245394287, -0.55459625711941207, -0.31535709606659013,
    -1.9304483670795887, -0.56318567974272893, -0.26233530474452416,
    -1.8758436190768246 };

  static const char cv[30] = { 'M', 'M', 'T', 'o', 'o', 'r', 't', 'v', 'e', 'i',
    'e', 'm', 'o', 'm', 'o', 'n', 'e', 'r', 'l', 'n', ' ', 'e', 't', ' ', 's',
    ' ', ' ', 's', ' ', ' ' };

  static const signed char iv[9] = { 1, -1, 0, 1, 0, -1, 0, 1, -1 };

  coder::classreg::learning::classif::CompactClassificationECOC model;
  int i;
  signed char b_I[9];
  for (i = 0; i < 30; i++) {
    model.ClassNames[i] = cv[i];
  }

  model.ClassNamesLength[0] = 10;
  model.ClassLogicalIndices[0] = true;
  model.ClassNamesLength[1] = 8;
  model.ClassLogicalIndices[1] = true;
  model.ClassNamesLength[2] = 6;
  model.ClassLogicalIndices[2] = true;
  model.ScoreTransform = coder::classreg::learning::coderutils::Identity;
  model.BinaryLearners[0].ClassNames[0] = -1.0;
  model.BinaryLearners[0].ClassNamesLength[0] = 1;
  model.BinaryLearners[0].ClassLogicalIndices[0] = true;
  model.BinaryLearners[0].ClassNames[1] = 1.0;
  model.BinaryLearners[0].ClassNamesLength[1] = 1;
  model.BinaryLearners[0].ClassLogicalIndices[1] = true;
  model.BinaryLearners[0].ScoreTransform = coder::classreg::learning::coderutils::
    Identity;
  model.BinaryLearners[0].Bias = 0.069762086581117488;
  model.BinaryLearners[0].Scale = 1.0;
  model.BinaryLearners[0].Prior[0] = 0.54545454545454553;
  model.BinaryLearners[0].Prior[1] = 0.45454545454545453;
  model.BinaryLearners[0].Cost[0] = 0.0;
  model.BinaryLearners[0].Cost[1] = 1.0;
  model.BinaryLearners[0].Cost[2] = 1.0;
  model.BinaryLearners[0].Cost[3] = 0.0;
  model.BinaryLearners[1].ClassNames[0] = -1.0;
  model.BinaryLearners[1].ClassNamesLength[0] = 1;
  model.BinaryLearners[1].ClassLogicalIndices[0] = true;
  model.BinaryLearners[1].ClassNames[1] = 1.0;
  model.BinaryLearners[1].ClassNamesLength[1] = 1;
  model.BinaryLearners[1].ClassLogicalIndices[1] = true;
  model.BinaryLearners[1].ScoreTransform = coder::classreg::learning::coderutils::
    Identity;
  model.BinaryLearners[1].Bias = 1.0233064630655611;
  model.BinaryLearners[1].Scale = 1.0;
  model.BinaryLearners[1].Prior[0] = 0.61538461538461542;
  model.BinaryLearners[1].Prior[1] = 0.38461538461538458;
  model.BinaryLearners[1].Cost[0] = 0.0;
  model.BinaryLearners[1].Cost[1] = 1.0;
  model.BinaryLearners[1].Cost[2] = 1.0;
  model.BinaryLearners[1].Cost[3] = 0.0;
  model.BinaryLearners[2].ClassNames[0] = -1.0;
  model.BinaryLearners[2].ClassNamesLength[0] = 1;
  model.BinaryLearners[2].ClassLogicalIndices[0] = true;
  model.BinaryLearners[2].ClassNames[1] = 1.0;
  model.BinaryLearners[2].ClassNamesLength[1] = 1;
  model.BinaryLearners[2].ClassLogicalIndices[1] = true;
  model.BinaryLearners[2].ScoreTransform = coder::classreg::learning::coderutils::
    Identity;
  model.BinaryLearners[2].Bias = 1.2062267002402689;
  std::memcpy(&model.BinaryLearners[0].Beta[0], &dv[0], 48U * sizeof(double));
  std::memcpy(&model.BinaryLearners[1].Beta[0], &dv1[0], 48U * sizeof(double));
  std::memcpy(&model.BinaryLearners[2].Beta[0], &dv2[0], 48U * sizeof(double));
  model.BinaryLearners[2].Scale = 1.0;
  model.BinaryLearners[2].Prior[0] = 0.5714285714285714;
  model.BinaryLearners[2].Prior[1] = 0.42857142857142855;
  model.BinaryLearners[2].Cost[0] = 0.0;
  model.BinaryLearners[2].Cost[1] = 1.0;
  model.BinaryLearners[2].Cost[2] = 1.0;
  model.BinaryLearners[2].Cost[3] = 0.0;
  model.ScoreType[0] = 'i';
  model.Prior[0] = 0.26315789473684209;
  model.ScoreType[1] = 'n';
  model.Prior[1] = 0.31578947368421051;
  model.ScoreType[2] = 'f';
  model.Prior[2] = 0.42105263157894735;
  for (i = 0; i < 9; i++) {
    model.CodingMatrix[i] = iv[i];
    b_I[i] = 0;
  }

  b_I[0] = 1;
  b_I[4] = 1;
  b_I[8] = 1;
  for (i = 0; i < 9; i++) {
    model.Cost[i] = 1.0 - static_cast<double>(b_I[i]);
  }

  model.predict(X, label);
}

//
// File trailer for classify_accelerometer_data.cpp
//
// [EOF]
//
