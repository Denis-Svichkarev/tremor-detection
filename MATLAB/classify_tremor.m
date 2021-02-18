function [label, p] = classify_tremor(X)
    model = loadLearnerForCoder('SVM_Accelerometer_Tremor_Model');
    [label, p] = predict(model,X);
end