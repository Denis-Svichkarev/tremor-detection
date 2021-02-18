function [label, p] = classify_action(X)
    model = loadLearnerForCoder('SVM_Accelerometer_Action_Model');
    [label, p] = predict(model,X);
end