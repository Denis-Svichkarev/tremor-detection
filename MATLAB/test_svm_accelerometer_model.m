close all
clear all

model = loadLearnerForCoder('SVM_Accelerometer_Model');

test_accelerometer_data = readtable('test_accelerometer_data.csv');

label1 = classify_accelerometer_data(table2array(test_accelerometer_data(1,:)));
label2 = classify_accelerometer_data(table2array(test_accelerometer_data(2,:)));
label3 = classify_accelerometer_data(table2array(test_accelerometer_data(3,:)));

label1
label2
label3