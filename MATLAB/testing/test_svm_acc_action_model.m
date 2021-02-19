%% Action / Motionless

close all
clear all

data16 = get_tremor_data("All");
sample = data16{6};

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
    [label, p] = classify_action(data_features);
    a = [a p];
end

plot(a, 'r'); hold on;