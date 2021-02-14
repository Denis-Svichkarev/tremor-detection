%% SVM model

load accelerometer_data

X = accelerometer_data{:, [1:end-1]};
Y = accelerometer_data{:, end}; 

model = fitcecoc(X,Y);
saveLearnerForCoder(model,'SVM_Accelerometer_Model');

%% SVM model with score

load accelerometer_data

X = accelerometer_data{:, [1:end-1]};
Y = accelerometer_data{:, end}; 

classNames = {'Tremor','Movement','Motionless'};
t = templateSVM('Standardize',true,'KernelFunction','gaussian');

model = fitcecoc(X,Y,'Learners',t,'FitPosterior',true, ...
     'ClassNames', classNames, ...
      'Verbose', 2);

%[label,~,~,Posterior] = resubPredict(model,'Verbose',1);

save('SVM_Accelerometer_Score_Model.mat','model');