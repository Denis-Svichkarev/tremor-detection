%% 1. ACC model (MOV-STA)

close all
clear all

%% Load data

trainData = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.mat').TRAIN_ACC_MOV_STA;
testData = load('TremorDetection/MATLAB/model_data/TEST_ACC_MOV_STA.mat').TEST_ACC_MOV_STA;

XTrain = trainData{:, 1:end-1};
YTrain = trainData{:, end}; 

XTest = testData(:,1:end-1);
YTest = testData(:,end);

%% Training

classNames = {'Movement', 'Static'};

classificationSVM = fitcsvm(XTrain, YTrain, 'Verbose', 1, 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);

[model, ~] = fitSVMPosterior(classificationSVM);

%% Calculate model performance

% load existing model in MATLAB
% model = load('MODEL_ACC_MOV_STA').model;

model.ScoreTransform = 'logit';

L = loss(model, XTrain, YTrain);
L

RL = resubLoss(model);
RL

resp = strcmp(YTrain(:,:), 'Movement');
[~, score_svm] = resubPredict(model);

[Xsvm, Ysvm, Tsvm, AUCsvm] = perfcurve(resp, score_svm(:, logical([1, 0])), 'true');
AUCsvm

figure(1)
hold off;
plot(Xsvm, Ysvm);

legend('Support Vector Machines')
xlabel('False positive rate'); ylabel('True positive rate');
title(['ROC Curves for SVM classification. AUC: ' num2str(AUCsvm)])

%% Confusion matrix

figure(2)

testLabels = predict(model, table2array(XTest));
confusionMatrix = confusionchart(table2array(YTest), testLabels);

TP = confusionMatrix.NormalizedValues(1,1);
FP = confusionMatrix.NormalizedValues(1,2);
FN = confusionMatrix.NormalizedValues(2,1);
TN = confusionMatrix.NormalizedValues(2,2);

accuracy = (TP + TN) / (TP + TN + FP + FN);
precision = TP / (TP + FP);
recall = TP / (TP + FN);
F1 = (2 * precision * recall) / (precision + recall);

accuracy
precision
recall
F1

%% Save model

saveLearnerForCoder(model, 'TremorDetection/MATLAB/models/SVM_MODEL_ACC_MOV_STA');
save('TremorDetection/MATLAB/models/MODEL_ACC_MOV_STA.mat', 'model');

%% 2. ACC model (TRE-MOV)

close all
clear all

%% Load data

trainData = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.mat').TRAIN_ACC_TRE_MOV;
testData = load('TremorDetection/MATLAB/model_data/TEST_ACC_TRE_MOV.mat').TEST_ACC_TRE_MOV;

XTrain = trainData{:, 1:end-1};
YTrain = trainData{:, end}; 

XTest = testData(:,1:end-1);
YTest = testData(:,end);

%% Training

classNames = {'Tremor', 'Movement'};

classificationSVM = fitcsvm(XTrain, YTrain, 'Verbose', 1, 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);
[model, ~] = fitSVMPosterior(classificationSVM);

%% Calculate model performance

% load existing model in MATLAB
% model = load('MODEL_ACC_TRE_MOV').model;

model.ScoreTransform = 'logit';

L = loss(model, XTrain, YTrain);
L

RL = resubLoss(model);
RL

resp = strcmp(YTrain(:,:), 'Tremor');
[~, score_svm] = resubPredict(model);

[Xsvm, Ysvm, Tsvm, AUCsvm] = perfcurve(resp, score_svm(:, logical([1, 0])), 'true');
AUCsvm

figure(1)
hold off;
plot(Xsvm, Ysvm);

legend('Support Vector Machines')
xlabel('False positive rate'); ylabel('True positive rate');
title(['ROC Curves for SVM classification. AUC: ' num2str(AUCsvm)])

%% Confusion matrix

figure(2)

testLabels = predict(model, table2array(XTest));
confusionMatrix = confusionchart(table2array(YTest), testLabels);

TP = confusionMatrix.NormalizedValues(1,1);
FP = confusionMatrix.NormalizedValues(1,2);
FN = confusionMatrix.NormalizedValues(2,1);
TN = confusionMatrix.NormalizedValues(2,2);

accuracy = (TP + TN) / (TP + TN + FP + FN);
precision = TP / (TP + FP);
recall = TP / (TP + FN);
F1 = (2 * precision * recall) / (precision + recall);

accuracy
precision
recall
F1

%% Save model

saveLearnerForCoder(model, 'TremorDetection/MATLAB/models/SVM_MODEL_ACC_TRE_MOV');
save('TremorDetection/MATLAB/models/MODEL_ACC_TRE_MOV.mat', 'model');

%% 3. ACC model (TRE-STA)

close all
clear all

%% Load data

trainData = load('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_STA.mat').TRAIN_ACC_TRE_STA;
testData = load('TremorDetection/MATLAB/model_data/TEST_ACC_TRE_STA.mat').TEST_ACC_TRE_STA;

XTrain = trainData{:, 1:end-1};
YTrain = trainData{:, end}; 

XTest = testData(:,1:end-1);
YTest = testData(:,end);

%% Training

classNames = {'Tremor', 'Static'};

classificationSVM = fitcsvm(XTrain, YTrain, 'Verbose', 1, 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);
[model, ~] = fitSVMPosterior(classificationSVM);

%% Calculate model performance

% model = loadLearnerForCoder('SVM_MODEL_ACC_TRE_STA')
model.ScoreTransform = 'logit';

L = loss(model, XTrain, YTrain);
L

RL = resubLoss(model);
RL

resp = strcmp(YTrain(:,:), 'Static');
[~, score_svm] = resubPredict(model);

[Xsvm, Ysvm, Tsvm, AUCsvm] = perfcurve(resp, score_svm(:, logical([1, 0])), 'true');
AUCsvm

figure(1)
hold off;
plot(Xsvm, Ysvm);

legend('Support Vector Machines')
xlabel('False positive rate'); ylabel('True positive rate');
title(['ROC Curves for SVM classification. AUC: ' num2str(AUCsvm)])

%% Confusion matrix

figure(2)

testLabels = predict(model, table2array(XTest));
confusionMatrix = confusionchart(table2array(YTest), testLabels);

TP = confusionMatrix.NormalizedValues(1,1);
FP = confusionMatrix.NormalizedValues(1,2);
FN = confusionMatrix.NormalizedValues(2,1);
TN = confusionMatrix.NormalizedValues(2,2);

accuracy = (TP + TN) / (TP + TN + FP + FN);
precision = TP / (TP + FP);
recall = TP / (TP + FN);
F1 = (2 * precision * recall) / (precision + recall);

accuracy
precision
recall
F1

%% Save model

saveLearnerForCoder(model, 'TremorDetection/MATLAB/models/SVM_MODEL_ACC_TRE_STA');
save('TremorDetection/MATLAB/models/MODEL_ACC_TRE_STA.mat', 'model');