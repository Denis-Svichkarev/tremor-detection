close all
clear all

%% Load data

trainData_ACC_MOV_STA = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.mat').TRAIN_ACC_MOV_STA;
trainData_ACC_TRE_MOV = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.mat').TRAIN_ACC_TRE_MOV;
trainData_ACC_TRE_STA = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_STA.mat').TRAIN_ACC_TRE_STA;
trainData_CAM_MOV_STA = load('TremorDetection/MATLAB/model_data/TRAIN_CAM_MOV_STA.mat').TRAIN_CAM_MOV_STA;
trainData_CAM_TRE_MOV = load('TremorDetection/MATLAB/model_data/TRAIN_CAM_TRE_MOV.mat').TRAIN_CAM_TRE_MOV;
trainData_CAM_TRE_STA = load('TremorDetection/MATLAB/model_data/TRAIN_CAM_TRE_STA.mat').TRAIN_CAM_TRE_STA;
trainData_AUD_MOV_STA = load('TremorDetection/MATLAB/model_data/TRAIN_AUD_MOV_STA.mat').TRAIN_AUD_MOV_STA;
trainData_AUD_TRE_MOV = load('TremorDetection/MATLAB/model_data/TRAIN_AUD_TRE_MOV.mat').TRAIN_AUD_TRE_MOV;
trainData_AUD_TRE_STA = load('TremorDetection/MATLAB/model_data/TRAIN_AUD_TRE_STA.mat').TRAIN_AUD_TRE_STA;

XTrain_CAM_MOV_STA = trainData_CAM_MOV_STA{:, 1:end-1};
XTrain_CAM_TRE_MOV = trainData_CAM_TRE_MOV{:, 1:end-1};
XTrain_CAM_TRE_STA = trainData_CAM_TRE_STA{:, 1:end-1};

YTrain_ACC_MOV_STA = trainData_ACC_MOV_STA{:, end};
YTrain_ACC_TRE_MOV = trainData_ACC_TRE_MOV{:, end};
YTrain_ACC_TRE_STA = trainData_ACC_TRE_STA{:, end};
YTrain_CAM_MOV_STA = trainData_CAM_MOV_STA{:, end};
YTrain_CAM_TRE_MOV = trainData_CAM_TRE_MOV{:, end};
YTrain_CAM_TRE_STA = trainData_CAM_TRE_STA{:, end};
YTrain_AUD_MOV_STA = trainData_AUD_MOV_STA{:, end};
YTrain_AUD_TRE_MOV = trainData_AUD_TRE_MOV{:, end};
YTrain_AUD_TRE_STA = trainData_AUD_TRE_STA{:, end};

model_ACC_MOV_STA = load('MODEL_ACC_MOV_STA').model;
model_ACC_TRE_MOV = load('MODEL_ACC_TRE_MOV').model;
model_ACC_TRE_STA = load('MODEL_ACC_TRE_STA').model;
model_CAM_MOV_STA = load('MODEL_CAM_MOV_STA').model;
model_CAM_TRE_MOV = load('MODEL_CAM_TRE_MOV').model;
model_CAM_TRE_STA = load('MODEL_CAM_TRE_STA').model;
model_AUD_MOV_STA = load('MODEL_AUD_MOV_STA').model;
model_AUD_TRE_MOV = load('MODEL_AUD_TRE_MOV').model;
model_AUD_TRE_STA = load('MODEL_AUD_TRE_STA').model;

model_ACC_MOV_STA.ScoreTransform = 'logit';
model_ACC_TRE_MOV.ScoreTransform = 'logit';
model_ACC_TRE_STA.ScoreTransform = 'logit';
model_CAM_MOV_STA.ScoreTransform = 'logit';
model_CAM_TRE_MOV.ScoreTransform = 'logit';
model_CAM_TRE_STA.ScoreTransform = 'logit';
model_AUD_MOV_STA.ScoreTransform = 'logit';
model_AUD_TRE_MOV.ScoreTransform = 'logit';
model_AUD_TRE_STA.ScoreTransform = 'logit';

%% Calculate performance

resp_ACC_MOV_STA = strcmp(YTrain_ACC_MOV_STA(:,:), 'Movement');
resp_ACC_TRE_MOV = strcmp(YTrain_ACC_TRE_MOV(:,:), 'Tremor');
resp_ACC_TRE_STA = strcmp(YTrain_ACC_TRE_STA(:,:), 'Tremor');
resp_CAM_MOV_STA = strcmp(YTrain_CAM_MOV_STA, 'Movement');
resp_CAM_TRE_MOV = strcmp(YTrain_CAM_TRE_MOV, 'Tremor');
resp_CAM_TRE_STA = strcmp(YTrain_CAM_TRE_STA, 'Tremor');
resp_AUD_MOV_STA = strcmp(YTrain_AUD_MOV_STA, 'Movement');
resp_AUD_TRE_MOV = strcmp(YTrain_AUD_TRE_MOV, 'Tremor');
resp_AUD_TRE_STA = strcmp(YTrain_AUD_TRE_STA, 'Tremor');

[~, score_svm_ACC_MOV_STA] = resubPredict(model_ACC_MOV_STA);
[~, score_svm_ACC_TRE_MOV] = resubPredict(model_ACC_TRE_MOV);
[~, score_svm_ACC_TRE_STA] = resubPredict(model_ACC_TRE_STA);
[~, score_svm_CAM_MOV_STA] = predict(model_CAM_MOV_STA, XTrain_CAM_MOV_STA);
[~, score_svm_CAM_TRE_MOV] = predict(model_CAM_TRE_MOV, XTrain_CAM_TRE_MOV);
[~, score_svm_CAM_TRE_STA] = predict(model_CAM_TRE_STA, XTrain_CAM_TRE_STA);
[~, score_svm_AUD_MOV_STA] = resubPredict(model_AUD_MOV_STA);
[~, score_svm_AUD_TRE_MOV] = resubPredict(model_AUD_TRE_MOV);
[~, score_svm_AUD_TRE_STA] = resubPredict(model_AUD_TRE_STA);

[Xsvm_ACC_MOV_STA, Ysvm_ACC_MOV_STA, Tsvm_ACC_MOV_STA, AUCsvm_ACC_MOV_STA] = perfcurve(resp_ACC_MOV_STA, score_svm_ACC_MOV_STA(:, logical([1, 0])), 'true');
[Xsvm_ACC_TRE_MOV, Ysvm_ACC_TRE_MOV, Tsvm_ACC_TRE_MOV, AUCsvm_ACC_TRE_MOV] = perfcurve(resp_ACC_TRE_MOV, score_svm_ACC_TRE_MOV(:, logical([1, 0])), 'true');
[Xsvm_ACC_TRE_STA, Ysvm_ACC_TRE_STA, Tsvm_ACC_TRE_STA, AUCsvm_ACC_TRE_STA] = perfcurve(resp_ACC_TRE_STA, score_svm_ACC_TRE_STA(:, logical([1, 0])), 'true');
[Xsvm_CAM_MOV_STA, Ysvm_CAM_MOV_STA, Tsvm_CAM_MOV_STA, AUCsvm_CAM_MOV_STA] = perfcurve(resp_CAM_MOV_STA, score_svm_CAM_MOV_STA(:, logical([1, 0])), 'true');
[Xsvm_CAM_TRE_MOV, Ysvm_CAM_TRE_MOV, Tsvm_CAM_TRE_MOV, AUCsvm_CAM_TRE_MOV] = perfcurve(resp_CAM_TRE_MOV, score_svm_CAM_TRE_MOV(:, logical([1, 0])), 'true');
[Xsvm_CAM_TRE_STA, Ysvm_CAM_TRE_STA, Tsvm_CAM_TRE_STA, AUCsvm_CAM_TRE_STA] = perfcurve(resp_CAM_TRE_STA, score_svm_CAM_TRE_STA(:, logical([1, 0])), 'true');
[Xsvm_AUD_MOV_STA, Ysvm_AUD_MOV_STA, Tsvm_AUD_MOV_STA, AUCsvm_AUD_MOV_STA] = perfcurve(resp_AUD_MOV_STA, score_svm_AUD_MOV_STA(:, logical([1, 0])), 'true');
[Xsvm_AUD_TRE_MOV, Ysvm_AUD_TRE_MOV, Tsvm_AUD_TRE_MOV, AUCsvm_AUD_TRE_MOV] = perfcurve(resp_AUD_TRE_MOV, score_svm_AUD_TRE_MOV(:, logical([1, 0])), 'true');
[Xsvm_AUD_TRE_STA, Ysvm_AUD_TRE_STA, Tsvm_AUD_TRE_STA, AUCsvm_AUD_TRE_STA] = perfcurve(resp_AUD_TRE_STA, score_svm_AUD_TRE_STA(:, logical([1, 0])), 'true');

AUCsvm_ACC = (AUCsvm_ACC_MOV_STA + AUCsvm_ACC_TRE_MOV + AUCsvm_ACC_TRE_STA) / 3;
AUCsvm_CAM = (AUCsvm_CAM_MOV_STA + AUCsvm_CAM_TRE_MOV + AUCsvm_CAM_TRE_STA) / 3;
AUCsvm_AUD = (AUCsvm_AUD_MOV_STA + AUCsvm_AUD_TRE_MOV + AUCsvm_AUD_TRE_STA) / 3;

%% Plot

figure(1)
hold on;
% plot(Xsvm_ACC_MOV_STA, Ysvm_ACC_MOV_STA, 'LineWidth', 2, 'Color', [1 0 0]);
% plot(Xsvm_ACC_TRE_MOV, Ysvm_ACC_TRE_MOV, 'LineWidth', 2, 'Color', [0 1 0]);
% plot(Xsvm_ACC_TRE_STA, Ysvm_ACC_TRE_STA, 'LineWidth', 2, 'Color', [0 0 1]);

% plot(Xsvm_CAM_MOV_STA, Ysvm_CAM_MOV_STA, 'LineWidth', 2, 'Color', [1 0 0]);
% plot(Xsvm_CAM_TRE_MOV, Ysvm_CAM_TRE_MOV, 'LineWidth', 2, 'Color', [0 1 0]);
% plot(Xsvm_CAM_TRE_STA, Ysvm_CAM_TRE_STA, 'LineWidth', 2, 'Color', [0 0 1]);

plot(Xsvm_AUD_MOV_STA, Ysvm_AUD_MOV_STA, 'LineWidth', 2, 'Color', [1 0 0]);
plot(Xsvm_AUD_TRE_MOV, Ysvm_AUD_TRE_MOV, 'LineWidth', 2, 'Color', [0 1 0]);
plot(Xsvm_AUD_TRE_STA, Ysvm_AUD_TRE_STA, 'LineWidth', 2, 'Color', [0 0 1]);

legend(['AUC: ' num2str(AUCsvm_AUD)])
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC curves for SVM classification')

%% Interpolate to get same time resolution

x = linspace(0, 1, 100);

Xsvm_ACC_MOV_STA_Unique = Xsvm_ACC_MOV_STA + (linspace(0, 1, length(Xsvm_ACC_MOV_STA))*1E-10)'; 
Xsvm_ACC_TRE_MOV_Unique = Xsvm_ACC_TRE_MOV + (linspace(0, 1, length(Xsvm_ACC_TRE_MOV))*1E-10)'; 
Xsvm_ACC_TRE_STA_Unique = Xsvm_ACC_TRE_STA + (linspace(0, 1, length(Xsvm_ACC_TRE_STA))*1E-10)'; 
Xsvm_CAM_MOV_STA_Unique = Xsvm_CAM_MOV_STA + (linspace(0, 1, length(Xsvm_CAM_MOV_STA))*1E-10)'; 
Xsvm_CAM_TRE_MOV_Unique = Xsvm_CAM_TRE_MOV + (linspace(0, 1, length(Xsvm_CAM_TRE_MOV))*1E-10)'; 
Xsvm_CAM_TRE_STA_Unique = Xsvm_CAM_TRE_STA + (linspace(0, 1, length(Xsvm_CAM_TRE_STA))*1E-10)'; 
Xsvm_AUD_MOV_STA_Unique = Xsvm_AUD_MOV_STA + (linspace(0, 1, length(Xsvm_AUD_MOV_STA))*1E-10)'; 
Xsvm_AUD_TRE_MOV_Unique = Xsvm_AUD_TRE_MOV + (linspace(0, 1, length(Xsvm_AUD_TRE_MOV))*1E-10)'; 
Xsvm_AUD_TRE_STA_Unique = Xsvm_AUD_TRE_STA + (linspace(0, 1, length(Xsvm_AUD_TRE_STA))*1E-10)'; 

yy1_ACC = interp1(Xsvm_ACC_MOV_STA_Unique, Ysvm_ACC_MOV_STA, x);
yy2_ACC = interp1(Xsvm_ACC_TRE_MOV_Unique, Ysvm_ACC_TRE_MOV, x);
yy3_ACC = interp1(Xsvm_ACC_TRE_STA_Unique, Ysvm_ACC_TRE_STA, x);
yy1_CAM = interp1(Xsvm_CAM_MOV_STA_Unique, Ysvm_CAM_MOV_STA, x);
yy2_CAM = interp1(Xsvm_CAM_TRE_MOV_Unique, Ysvm_CAM_TRE_MOV, x);
yy3_CAM = interp1(Xsvm_CAM_TRE_STA_Unique, Ysvm_CAM_TRE_STA, x);
yy1_AUD = interp1(Xsvm_AUD_MOV_STA_Unique, Ysvm_AUD_MOV_STA, x);
yy2_AUD = interp1(Xsvm_AUD_TRE_MOV_Unique, Ysvm_AUD_TRE_MOV, x);
yy3_AUD = interp1(Xsvm_AUD_TRE_STA_Unique, Ysvm_AUD_TRE_STA, x);

y_ACC = mean([yy1_ACC; yy2_ACC; yy3_ACC], 1);
y_CAM = mean([yy1_CAM; yy2_CAM; yy3_CAM], 1);
y_AUD = mean([yy1_AUD; yy2_AUD; yy3_AUD], 1);

middle_x = (0:0.1:1);
middle_y = (0:0.1:1);

hold on;
axes('NextPlot', 'add');
%plot(Xsvm_ACC_MOV_STA_Unique, Ysvm_ACC_MOV_STA, 'r', Xsvm_ACC_TRE_MOV_Unique, Ysvm_ACC_TRE_MOV, 'g', Xsvm_ACC_TRE_STA_Unique, Ysvm_ACC_TRE_STA, 'b', x, y, 'k')

plot(x, y_ACC, 'LineWidth', 2, 'Color', [1 0 0])
plot(x, y_CAM, 'LineWidth', 2, 'Color', [0 1 0])
plot(x, y_AUD, 'LineWidth', 2, 'Color', [0 0 1])
plot(middle_x, middle_y, 'LineWidth', 2, 'LineStyle', '--')

legend(['Model #1 AUC: ' num2str(AUCsvm_ACC)], ['Model #2 AUC: ' num2str(AUCsvm_CAM)], ['Model #3 AUC: ' num2str(AUCsvm_AUD)])
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC curves for SVM classification')
