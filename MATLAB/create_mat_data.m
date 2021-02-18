%% Data for classificator with three classes

accelerometer_data = readtable('accelerometer_data.csv');
save('accelerometer_data.mat');

%% Data for classificator with two classes: Action and Motionless

accelerometer_data_ACT_MOT = readtable('accelerometer_data_ACT_MOT.csv');
save('accelerometer_data_ACT_MOT.mat');

%% Data for classificator with two classes: Tremor and Movement

accelerometer_data_TRE_MOV = readtable('accelerometer_data_TRE_MOV.csv');
save('accelerometer_data_TRE_MOV.mat');
