%% SVM accelerometer model (Action and Motionless)

close all
clear all

% ------ Load data ------

trainData = load('models/train_acc_data_ACT_MOT.mat').train_accelerometer_data_ACT_MOT;
testData = load('models/test_acc_data_ACT_MOT.mat').test_accelerometer_data_ACT_MOT;

XTrain = trainData{:, 1:end-1};
YTrain = trainData{:, end}; 

XTest = testData(:,1:end-1);
YTest = testData(:,end);

classNames = {'Action','Motionless'};

% ------ Training ------

classificationSVM = fitcsvm(XTrain, YTrain, 'Verbose', 1, 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);
[model, ~] = fitSVMPosterior(classificationSVM);

% ------ Calculate model performance ------

L = loss(model, XTrain, YTrain);
L

RL = resubLoss(model);
RL

% ------ ROC ------

resp = strcmp(YTrain(:,:),'Action');
[~, score_svm] = resubPredict(model);

[Xsvm, Ysvm, Tsvm, AUCsvm] = perfcurve(resp, score_svm(:, logical([1, 0])), 'true');
AUCsvm

figure(1)
hold off;
plot(Xsvm, Ysvm);

legend('Support Vector Machines')
xlabel('False positive rate'); ylabel('True positive rate');
title(['ROC Curves for SVM classification. AUC: ' num2str(AUCsvm)])

% ------ Confusion matrix ------

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

% ------ Save model ------

saveLearnerForCoder(model, 'models/SVM_Acc_ACT_MOT_Model');
save('models/Mtlb_SVM_Acc_ACT_MOT_Model.mat', 'model');

%% SVM accelerometer model (Tremor and Movement)

close all
clear all

% ------ Load data ------

trainData = load('models/train_acc_data_TRE_MOV.mat').train_accelerometer_data_TRE_MOV;
testData = load('models/test_acc_data_TRE_MOV.mat').test_accelerometer_data_TRE_MOV;

XTrain = trainData{:, 1:end-1};
YTrain = trainData{:, end}; 

XTest = testData(:,1:end-1);
YTest = testData(:,end);

classNames = {'Tremor','Movement'};

% ------ Training ------

classificationSVM = fitcsvm(XTrain, YTrain, 'Verbose', 1, 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);  % 'KernelScale','auto', 'Standardize', true, 'OutlierFraction', 0.05
[model, ~] = fitSVMPosterior(classificationSVM);

% ------ Calculate model performance ------

L = loss(model, XTrain, YTrain);
L

RL = resubLoss(model);
RL

% ------ ROC ------

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

% ------ Confusion matrix ------

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

% ------ Save model ------

saveLearnerForCoder(model, 'models/SVM_Acc_TRE_MOV_Model');
save('models/Mtlb_SVM_Acc_TRE_MOV_Model.mat', 'model');