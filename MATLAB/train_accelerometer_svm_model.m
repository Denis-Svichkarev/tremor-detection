%% SVM model

load accelerometer_data

X = accelerometer_data{:, 1:end-1};
Y = accelerometer_data{:, end}; 

model = fitcecoc(X,Y);
saveLearnerForCoder(model,'SVM_Accelerometer_Model');

%% SVM model with probability

load accelerometer_data

X = accelerometer_data{:, 1:end-1};
Y = accelerometer_data{:, end}; 

classNames = {'Tremor','Movement','Motionless'};
t = templateSVM('Standardize',true,'KernelFunction','gaussian');

model = fitcecoc(X,Y,'Learners',t,'FitPosterior',true, ...
     'ClassNames', classNames, ...
      'Verbose', 2);

%[label,~,~,Posterior] = resubPredict(model,'Verbose',1);

save('SVM_Accelerometer_Score_Model.mat','model');

%% SVM model with probability (Action and Motionless)

load accelerometer_data_ACT_MOT

X = accelerometer_data_ACT_MOT{:, 1:end-1};
Y = accelerometer_data_ACT_MOT{:, end}; 

classNames = {'Action','Motionless'};

classificationSVM = fitcsvm(X, Y, 'Verbose', 1, ... % 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);

%classificationSVM = fitcsvm(X,Y,'KernelScale','auto','Standardize',true,...
%    'OutlierFraction', 0.05);

[model, score] = fitSVMPosterior(classificationSVM);
%[prediction, posterior] = predict(model, X);

saveLearnerForCoder(model,'SVM_Accelerometer_Action_Model');

% test_accelerometer_data = readtable('test_accelerometer_data.csv');
% [label1, p1] = predict(model, table2array(test_accelerometer_data(1,:)));
% [label2, p2] = predict(model, table2array(test_accelerometer_data(2,:)));
% [label3, p3] = predict(model, table2array(test_accelerometer_data(3,:)));

%% SVM model with probability (Tremor and Movement)

load accelerometer_data_TRE_MOV

X = accelerometer_data_TRE_MOV{:, 1:end-1};
Y = accelerometer_data_TRE_MOV{:, end}; 

classNames = {'Tremor','Movement'};

classificationSVM = fitcsvm(X, Y, 'Verbose', 1, ... % 'OptimizeHyperparameters', 'auto', ...
    'ScoreTransform', 'logit', 'ClassNames', classNames);

%classificationSVM = fitcsvm(X,Y,'KernelScale','auto','Standardize',true,...
%    'OutlierFraction', 0.05);

[model, score] = fitSVMPosterior(classificationSVM);
%[prediction, posterior] = predict(model, X);

saveLearnerForCoder(model,'SVM_Accelerometer_Tremor_Model');

test_accelerometer_data = readtable('test_accelerometer_data.csv');
[label1, p1] = predict(model, table2array(test_accelerometer_data(1,:)));
[label2, p2] = predict(model, table2array(test_accelerometer_data(2,:)));
% [label3, p3] = predict(model, table2array(test_accelerometer_data(3,:)));