%% Preprocessing

close all
clear all

data1 = get_tremor_data("Simulation/data1");
data6 = get_tremor_data("Simulation/data6");

timewindow_size_milisec = 400;

[data1_features] = extract_features_in_timewindow(data1, timewindow_size_milisec, 'r');
[data6_features] = extract_features_in_timewindow(data6, timewindow_size_milisec, 'b');

%% Plot Features

data1_M = [];
for i = 1:size(data1_features, 1)
    data1_M = [data1_M; data1_features{i, 73}];
end

data6_M = [];
for i = 1:size(data6_features, 1)
    data6_M = [data6_M; data6_features{i, 73}];
end

plot(data1_M, 'r'); hold on;
plot(data6_M, 'b'); hold on;
title('Feature (x axis)')
xlabel('x')
ylabel('y')
