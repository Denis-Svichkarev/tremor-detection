function [label, p] = classify_tremor(X)
    model = loadLearnerForCoder('SVM_Acc_TRE_MOV_Model');
    [label, p] = predict(model,X);
end