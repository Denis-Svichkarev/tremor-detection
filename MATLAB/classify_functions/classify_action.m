function [label, p] = classify_action(X)
    model = loadLearnerForCoder('SVM_Acc_ACT_MOT_Model');
    [label, p] = predict(model,X);
end