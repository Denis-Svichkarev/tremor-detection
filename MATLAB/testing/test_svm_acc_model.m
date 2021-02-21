%% Test SVM model

close all
clear all

is_Matlab=false;

%data = get_tremor_data("All");
%sample = data{6};

data = get_tremor_data("Simulation/data15");
sample = data{1};

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
    if is_Matlab
        [label, p1, p2, p3] = mtlb_classify_accelerometer(data_features);
    else
        [label, p1, p2, p3] = classify_accelerometer(data_features);  
    end
    a = [a p1];
    b = [b p2];
    c = [c p3];
end

hold on;
plot(a, 'r');
plot(b, 'g');
plot(c, 'b');