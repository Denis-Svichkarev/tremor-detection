%% Data for classificator with three classes: Tremor, Movement, Motionless

accelerometer_data = readtable('csv_data/train_acc_data_TRE_MOV_MOT.csv');
save('models/acc_data_TRE_MOV_MOT.mat');

%% Data for classificator with two classes: Action and Motionless

accelerometer_data_ACT_MOT = readtable('csv_data/train_acc_data_ACT_MOT.csv');
save('models/acc_data_ACT_MOT.mat');

%% Data for classificator with two classes: Tremor and Movement

accelerometer_data_TRE_MOV = readtable('csv_data/train_acc_data_TRE_MOV.csv');
save('models/acc_data_TRE_MOV.mat');
