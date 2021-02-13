//
// File: classify_accelerometer_data.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 13-Feb-2021 17:46:08
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
  static const double dv[48] = { -0.6647508164692546, -0.4852437529330571,
    -0.44605167373079108, -0.40349340540906431, -0.38858739699218126,
    -0.33434284664790132, -0.3327874055390303, -0.30308720177423021,
    -0.27550843600154062, -0.26014603147295889, -0.26046033437378907,
    -0.23264369676771668, -0.21548668075641819, -0.56535009135842273,
    -0.41549966524600546, -0.37957694096324796, -0.37180793030250592,
    -0.32401688341714174, -0.30132869344962637, -0.27253852458346128,
    -0.2718558439888899, -0.273022133254194, -0.26676653986716514,
    -0.23377697950699253, -0.21911198776504612, -0.22022771361741955,
    -0.668328556301273, -0.54585809537413588, -0.47781691717785146,
    -0.41697325595549373, -0.35667532709057143, -0.33610448728047282,
    -0.304727225395068, -0.31140540091300989, -0.333528414837593,
    -0.32081113309410669, -0.36108642176658057, -0.34657870773104033,
    -0.31868296237523119, -0.35404535991291797, -0.31652922517847076,
    -0.39219822348403294, -0.18784051461891815, -0.154125788128342,
    -0.22065465281398783, -0.31951415510319231, -0.30303669015245532,
    -0.36039133367512577 };

  static const double dv1[48] = { -0.66375068241063606, -0.60317061273156281,
    -0.55966716253102822, -0.59274328052403136, -0.71794519374529986,
    -0.640144860999998, -0.6941280634054634, -0.6955632257288723,
    -0.642468801651045, -0.63898844971902491, -0.6292631239788764,
    -0.61835076715839277, -0.5529533074763392, -0.4451224022878113,
    -0.45137708738544091, -0.41944318679107329, -0.51780548041155527,
    -0.51240249088169887, -0.4744724169313545, -0.53042725073917207,
    -0.5609937479628504, -0.54599437098510573, -0.58954592628050551,
    -0.57469542193180811, -0.54845265304270951, -0.47713591810932565,
    -0.81992002959365506, -0.93415993269184816, -0.95979955546335549,
    -1.1245484037825708, -1.0861540868454205, -1.2470529164520627,
    -1.3330936031311982, -1.5032535950553192, -1.3271723268894546,
    -1.3140029670109914, -1.4118310175773936, -1.2269530136672337,
    -1.054058365883106, -0.63454904092773612, -0.5113744887492625,
    -1.1801538318495086, -0.331361879731224, -0.26826647282670135,
    -0.70459341133807474, -0.5874932740821539, -0.488931595345924,
    -1.060964303276787 };

  static const double dv2[48] = { 0.49909885746879618, 0.46454281901429223,
    0.053085226176622737, -0.37596734210599259, -0.7794546440740574,
    -0.86229170514004994, -1.1388872014442524, -1.2654286460079796,
    -1.1284301309007823, -1.2641870798497965, -0.8918303747895393,
    -1.1228381340803542, -0.72461922548448565, 0.69354383926582219,
    0.585693166257536, 0.40592945731181618, -0.14268580897854127,
    -0.17595656205268034, -0.43861486570572428, -0.64054962752829736,
    -0.67833314076752138, -0.74068616459473646, -0.87808574056143551,
    -0.878550568578651, -0.77327893769768952, -0.57961772405746259,
    0.017045942165552927, -0.57641899269911812, -0.96884419848560732,
    -2.2426319898418523, -2.5784310203865006, -3.0872800561618412,
    -4.032502925377913, -3.8085730648268528, -3.0518826006571302,
    -3.4096884175322826, -2.5637428310728816, -2.5710441597722218,
    -1.7512292043639262, -0.65670827547827559, -0.32624559059135128,
    -2.3557864245394295, -0.55459625711941329, -0.3153570960665909,
    -1.9304483670795909, -0.56318567974272926, -0.26233530474452527,
    -1.8758436190768228 };

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
  model.BinaryLearners[0].Bias = -0.91001799424267715;
  model.BinaryLearners[0].Scale = 1.0;
  model.BinaryLearners[0].Prior[0] = 0.75;
  model.BinaryLearners[0].Prior[1] = 0.25;
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
  model.BinaryLearners[1].Bias = -0.54715860236124336;
  model.BinaryLearners[1].Scale = 1.0;
  model.BinaryLearners[1].Prior[0] = 0.8;
  model.BinaryLearners[1].Prior[1] = 0.2;
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
  model.BinaryLearners[2].Bias = 1.2062267002402702;
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
  model.Prior[0] = 0.125;
  model.ScoreType[1] = 'n';
  model.Prior[1] = 0.375;
  model.ScoreType[2] = 'f';
  model.Prior[2] = 0.5;
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
