%% Classify without prediction values

close all
clear all

test_accelerometer_data = readtable('test_accelerometer_data.csv');
 
label1 = classify_accelerometer_data(table2array(test_accelerometer_data(1,:)));
label2 = classify_accelerometer_data(table2array(test_accelerometer_data(2,:)));
label3 = classify_accelerometer_data(table2array(test_accelerometer_data(3,:)));

label1
label2
label3

data16 = get_tremor_data("All");
sample = data16{6};

chunk = [];
offset = 0;
timewindow = 200;

a = [];
b = [];
c = [];

for i = 1:floor(size(sample, 1) / timewindow)
    offset = (i - 1) * timewindow;
    chunk = [];
    
    for j = offset+1:offset+timewindow
        chunk = [chunk sample.x(j) sample.y(j) sample.z(j)];
    end
    
    [data_features] = extract_features_from_raw_data(chunk, timewindow);
    label = classify_accelerometer_data(data_features);
    a = [a label];
end