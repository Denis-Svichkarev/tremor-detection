%% Test ACC-AUD model

is_Matlab=false; % false for MATLAB Coder

testData1 = load('TremorDetection/MATLAB/model_data/TEST_ACC_AUD_MOV_STA.mat').TEST_ACC_AUD_MOV_STA;
%testData1 = load('TremorDetection/MATLAB/model_data/TEST_ACC_AUD_TRE_MOV.mat').TEST_ACC_AUD_TRE_MOV;
%testData1 = load('TremorDetection/MATLAB/model_data/TEST_ACC_AUD_TRE_STA.mat').TEST_ACC_AUD_TRE_STA;

for i = 1:size(testData1, 1)    
    if is_Matlab
        [label, p1, p2, p3] = mtlb_classify_acc_aud(table2array(testData1(i,1:end-1)));
    else 
        [label, p1, p2, p3] = classify_acc_aud(table2array(testData1(i,1:end-1)));
    end
    
    i
    testData1(i,end:end)
    label
    p1
    p2
    p3
end