function [a, b, c, d] = classify_scored_accelerometer_data(X)
   class_model = coder.load('SVM_Accelerometer_Score_Model');
   [a,b,c,d] = predict(class_model.model,X);
end