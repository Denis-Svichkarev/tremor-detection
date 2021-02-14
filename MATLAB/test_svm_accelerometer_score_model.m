%% Classify with prediction values

close all
clear all

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
    [a1, b1, c1, d1] = classify_scored_accelerometer_data(data_features);
    a = [a d1(1)];
    b = [b d1(2)];
    c = [c d1(3)];
end

plot(a, 'r'); hold on;
plot(b, 'b'); hold on;
plot(c, 'g'); hold on;