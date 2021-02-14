//
// File: classify_accelerometer_data.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 14-Feb-2021 13:23:25
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
// class_model = coder.load('SVM_Accelerometer_Model');
// [a,b,c,d] = predict(class_model.model,X);
// Arguments    : const double X[48]
//                cell_wrap_0 label[1]
// Return Type  : void
//
void classify_accelerometer_data(const double X[48], cell_wrap_0 label[1])
{
  static const double dv[48] = { -3.6378864746838171, -3.16133751994767,
    -2.5959094124167259, -2.3332540063305642, -2.0803954789695251,
    -2.071594451066864, -1.9892657258327349, -1.7865116620487649,
    -1.6802379774620788, -1.6263073227234244, -1.6524063127845308,
    -1.3654452278801101, -1.3845225330084232, -3.7362636551426753,
    -3.03845700235367, -2.5710636943511491, -2.2835807723648136,
    -2.1133268666926019, -1.9666537732903528, -1.8023121542074625,
    -1.7663675849281351, -1.8170986170360708, -1.693670074571602,
    -1.7036456817839687, -1.6332362579171589, -1.4635949077027739,
    -4.2694654131550847, -3.5741171209342428, -3.0599131439819356,
    -2.4756452862046361, -2.1887257223353709, -2.3414976749305656,
    -2.16377339732629, -2.2194715614436307, -2.2909228837901625,
    -2.2608104025766886, -2.1385185745348623, -1.9088070243853319,
    -1.8410997211430606, -2.1050057003965552, -2.1222516186417257,
    -2.5179052251339886, -1.0503086356602094, -1.0250453255519179,
    -1.2017780881945797, -1.9488947021364162, -1.9977052335783954,
    -2.3970333445922956 };

  static const double dv1[48] = { -1.6499521333754472, -1.480749296328367,
    -1.4165027966611219, -1.5280458072323229, -1.5972000129696997,
    -1.5619797935556934, -1.903513199113452, -1.7101199021646232,
    -1.6191431271303158, -1.5981252372847425, -1.4079257462925965,
    -1.3619858663228377, -1.2534799812348643, -1.5941577442873289,
    -1.3269144621973168, -1.2545274986332595, -1.3014292875061577,
    -1.2831471702182038, -1.2959641628386018, -1.3195106639586853,
    -1.3881960373359354, -1.3949100460585286, -1.4159351974828871,
    -1.4645768448530647, -1.3560683836690601, -1.2245086122138515,
    -2.4669114864424828, -2.4652753651099188, -2.4040682628305579,
    -2.589123785532462, -2.7036621780241976, -2.9859228478312638,
    -3.9733794958684245, -3.6372571193247896, -3.3499565602688968,
    -3.220469886039143, -2.8898264063827726, -2.5041370219230612,
    -2.1022115480214847, -1.5452863768973908, -1.355372777788683,
    -2.8686309202768805, -0.89374244311525308, -0.742688413985317,
    -1.7785811344027382, -1.4030887778452745, -1.254064745279295,
    -2.5729242674506345 };

  static const double dv2[48] = { 0.49909885746879251, 0.46454281901428907,
    0.053085226176621758, -0.37596734210599658, -0.77945464407405929,
    -0.86229170514005238, -1.138887201444253, -1.2654286460079804,
    -1.1284301309007823, -1.2641870798497945, -0.89183037478953753,
    -1.1228381340803522, -0.72461922548448565, 0.69354383926581831,
    0.58569316625753376, 0.40592945731181551, -0.1426858089785436,
    -0.17595656205268276, -0.43861486570572583, -0.64054962752829925,
    -0.67833314076752227, -0.7406861645947358, -0.87808574056143673,
    -0.87855056857865266, -0.773278937697687, -0.57961772405746337,
    0.0170459421655499, -0.57641899269912167, -0.968844198485606,
    -2.2426319898418554, -2.5784310203865006, -3.0872800561618381,
    -4.0325029253779139, -3.8085730648268474, -3.0518826006571329,
    -3.4096884175322781, -2.5637428310728771, -2.5710441597722187,
    -1.7512292043639268, -0.6567082754782767, -0.3262455905913525,
    -2.3557864245394282, -0.55459625711941407, -0.31535709606659162,
    -1.9304483670795902, -0.56318567974272959, -0.26233530474452604,
    -1.8758436190768224 };

  static const char cv[30] = { 'M', 'M', 'T', 'o', 'o', 'r', 't', 'v', 'e', 'i',
    'e', 'm', 'o', 'm', 'o', 'n', 'e', 'r', 'l', 'n', ' ', 'e', 't', ' ', 's',
    ' ', ' ', 's', ' ', ' ' };

  static const signed char iv[9] = { 1, -1, 0, 1, 0, -1, 0, 1, -1 };

  coder::classreg::learning::classif::CompactClassificationECOC model;
  int i;
  signed char b_I[9];

  // function [a, b, c, d] = classify_accelerometer_data(X)
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
  model.BinaryLearners[0].Bias = 1.0420951708855513;
  model.BinaryLearners[0].Scale = 1.0;
  model.BinaryLearners[0].Prior[0] = 0.42806183115338881;
  model.BinaryLearners[0].Prior[1] = 0.57193816884661131;
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
  model.BinaryLearners[1].Bias = 1.0769554004552815;
  model.BinaryLearners[1].Scale = 1.0;
  model.BinaryLearners[1].Prior[0] = 0.49947970863683666;
  model.BinaryLearners[1].Prior[1] = 0.50052029136316334;
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
  model.BinaryLearners[2].Bias = 1.2062267002402698;
  std::memcpy(&model.BinaryLearners[0].Beta[0], &dv[0], 48U * sizeof(double));
  std::memcpy(&model.BinaryLearners[1].Beta[0], &dv1[0], 48U * sizeof(double));
  std::memcpy(&model.BinaryLearners[2].Beta[0], &dv2[0], 48U * sizeof(double));
  model.BinaryLearners[2].Scale = 1.0;
  model.BinaryLearners[2].Prior[0] = 0.57142857142857151;
  model.BinaryLearners[2].Prior[1] = 0.4285714285714286;
  model.BinaryLearners[2].Cost[0] = 0.0;
  model.BinaryLearners[2].Cost[1] = 1.0;
  model.BinaryLearners[2].Cost[2] = 1.0;
  model.BinaryLearners[2].Cost[3] = 0.0;
  model.ScoreType[0] = 'i';
  model.Prior[0] = 0.36411809235427706;
  model.ScoreType[1] = 'n';
  model.Prior[1] = 0.27252081756245267;
  model.ScoreType[2] = 'f';
  model.Prior[2] = 0.36336109008327028;
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
