function label = classify_accelerometer_data(X)
    model = loadLearnerForCoder('SVM_Accelerometer_Model');
    label = predict(model,X);
end