close all
clear all

%% Load data

trainData_ACC_MOV_STA = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.mat').TRAIN_ACC_MOV_STA;
trainData_ACC_TRE_MOV = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.mat').TRAIN_ACC_TRE_MOV;
trainData_ACC_TRE_STA = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_STA.mat').TRAIN_ACC_TRE_STA;

YTrain_ACC_MOV_STA = trainData_ACC_MOV_STA{:, end};
YTrain_ACC_TRE_MOV = trainData_ACC_TRE_MOV{:, end};
YTrain_ACC_TRE_STA = trainData_ACC_TRE_STA{:, end};

model_ACC_MOV_STA = load('MODEL_ACC_MOV_STA').model;
model_ACC_TRE_MOV = load('MODEL_ACC_TRE_MOV').model;
model_ACC_TRE_STA = load('MODEL_ACC_TRE_STA').model;

model_ACC_MOV_STA.ScoreTransform = 'logit';
model_ACC_TRE_MOV.ScoreTransform = 'logit';
model_ACC_TRE_STA.ScoreTransform = 'logit';

%% Calculate performance

resp_ACC_MOV_STA = strcmp(YTrain_ACC_MOV_STA(:,:), 'Movement');
resp_ACC_TRE_MOV = strcmp(YTrain_ACC_TRE_MOV(:,:), 'Tremor');
resp_ACC_TRE_STA = strcmp(YTrain_ACC_TRE_STA(:,:), 'Tremor');

[~, score_svm_ACC_MOV_STA] = resubPredict(model_ACC_MOV_STA);
[~, score_svm_ACC_TRE_MOV] = resubPredict(model_ACC_TRE_MOV);
[~, score_svm_ACC_TRE_STA] = resubPredict(model_ACC_TRE_STA);

[Xsvm_ACC_MOV_STA, Ysvm_ACC_MOV_STA, Tsvm_ACC_MOV_STA, AUCsvm_ACC_MOV_STA] = perfcurve(resp_ACC_MOV_STA, score_svm_ACC_MOV_STA(:, logical([1, 0])), 'true');
[Xsvm_ACC_TRE_MOV, Ysvm_ACC_TRE_MOV, Tsvm_ACC_TRE_MOV, AUCsvm_ACC_TRE_MOV] = perfcurve(resp_ACC_TRE_MOV, score_svm_ACC_TRE_MOV(:, logical([1, 0])), 'true');
[Xsvm_ACC_TRE_STA, Ysvm_ACC_TRE_STA, Tsvm_ACC_TRE_STA, AUCsvm_ACC_TRE_STA] = perfcurve(resp_ACC_TRE_STA, score_svm_ACC_TRE_STA(:, logical([1, 0])), 'true');

AUCsvm_ACC_MOV_STA
AUCsvm_ACC_TRE_MOV
AUCsvm_ACC_TRE_STA

AUCsvm_ACC = (AUCsvm_ACC_MOV_STA + AUCsvm_ACC_TRE_MOV + AUCsvm_ACC_TRE_STA) / 3;

%% Plot

figure(1)
hold on;
plot(Xsvm_ACC_MOV_STA, Ysvm_ACC_MOV_STA, 'LineWidth', 2);
plot(Xsvm_ACC_TRE_MOV, Ysvm_ACC_TRE_MOV, 'LineWidth', 2);
plot(Xsvm_ACC_TRE_STA, Ysvm_ACC_TRE_STA, 'LineWidth', 2);

legend(['Model #1 AUC: ' num2str(AUCsvm_ACC)])
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC curves for SVM classification')

%% Interpolate to get same time resolution

x = linspace(0, 1, 100);

Xsvm_ACC_MOV_STA_Unique = Xsvm_ACC_MOV_STA + (linspace(0, 1, length(Xsvm_ACC_MOV_STA))*1E-10)'; 
Xsvm_ACC_TRE_MOV_Unique = Xsvm_ACC_TRE_MOV + (linspace(0, 1, length(Xsvm_ACC_TRE_MOV))*1E-10)'; 
Xsvm_ACC_TRE_STA_Unique = Xsvm_ACC_TRE_STA + (linspace(0, 1, length(Xsvm_ACC_TRE_STA))*1E-10)'; 

yy1 = interp1(Xsvm_ACC_MOV_STA_Unique, Ysvm_ACC_MOV_STA, x);
yy2 = interp1(Xsvm_ACC_TRE_MOV_Unique, Ysvm_ACC_TRE_MOV, x);
yy3 = interp1(Xsvm_ACC_TRE_STA_Unique, Ysvm_ACC_TRE_STA, x);

y = mean([yy1; yy2; yy3], 1);

middle_x = (0:0.1:1);
middle_y = (0:0.1:1);

hold on;
axes('NextPlot', 'add');
%plot(Xsvm_ACC_MOV_STA_Unique, Ysvm_ACC_MOV_STA, 'r', Xsvm_ACC_TRE_MOV_Unique, Ysvm_ACC_TRE_MOV, 'g', Xsvm_ACC_TRE_STA_Unique, Ysvm_ACC_TRE_STA, 'b', x, y, 'k')
plot(x, y, 'LineWidth', 2)
plot(middle_x, middle_y, 'LineWidth', 2, 'LineStyle', '--')

legend(['Model #1 AUC: ' num2str(AUCsvm_ACC)])
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC curves for SVM classification')
