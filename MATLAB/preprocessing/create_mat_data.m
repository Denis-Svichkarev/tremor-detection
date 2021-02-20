%% Data for classificator with three classes: Tremor, Movement, Motionless

% accelerometer_data = readtable('csv_data/train_acc_data_TRE_MOV_MOT.csv');
% save('models/acc_data_TRE_MOV_MOT.mat');

%% Train data for classificator with two classes: Action and Motionless

train_accelerometer_data_ACT_MOT = readtable('csv_data/train_acc_data_ACT_MOT.csv');
save('models/train_acc_data_ACT_MOT.mat');

%% Test data for classificator with two classes: Action and Motionless

test_accelerometer_data_ACT_MOT = readtable('csv_data/test_acc_data_ACT_MOT.csv');
save('models/test_acc_data_ACT_MOT.mat');

%% Train data for classificator with two classes: Tremor and Movement

train_accelerometer_data_TRE_MOV = readtable('csv_data/train_acc_data_TRE_MOV.csv');
save('models/train_acc_data_TRE_MOV.mat');

%% Test data for classificator with two classes: Tremor and Movement

test_accelerometer_data_TRE_MOV = readtable('csv_data/test_acc_data_TRE_MOV.csv');
save('models/test_acc_data_TRE_MOV.mat');