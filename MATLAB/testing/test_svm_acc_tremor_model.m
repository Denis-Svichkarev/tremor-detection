%% Tremor / Movement

close all
clear all

is_Matlab=false;

%data = get_tremor_data("All");
%sample = data{6};

data = get_tremor_data("Simulation/data2");
sample = data{1};

chunk = [];
offset = 0;
timewindow = 200;

a = [];

for i = 1:floor(size(sample, 1) / timewindow)
    offset = (i - 1) * timewindow;
    chunk = [];
    
    for j = offset+1:offset+timewindow
        chunk = [chunk sample.x(j) sample.y(j) sample.z(j)];
    end
    
    [data_features] = extract_features_from_raw_data(chunk, timewindow);
    if is_Matlab
        [label, p] = mtlb_classify_tremor(data_features);
    else
        [label, p] = classify_tremor(data_features);  
    end
    a = [a p(1,1)];
end

plot(a, 'r'); hold on;