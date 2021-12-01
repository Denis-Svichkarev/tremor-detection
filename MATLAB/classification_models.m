%% Data for classification model #1

TRAIN_ACC_MOV_STA = readtable('TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.csv');
save('TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.mat');

TRAIN_ACC_TRE_MOV = readtable('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.csv');
save('TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.mat');

TEST_ACC_MOV_STA = readtable('TremorDetection/MATLAB/model_data/TEST_ACC_MOV_STA.csv');
save('TremorDetection/MATLAB/model_data/TEST_ACC_MOV_STA.mat');

TEST_ACC_TRE_MOV = readtable('TremorDetection/MATLAB/model_data/TEST_ACC_TRE_MOV.csv');
save('TremorDetection/MATLAB/model_data/TEST_ACC_TRE_MOV.mat');
