%% Preprocessing

close all
clear all

data1 = get_tremor_data("Simulation/data1");
data6 = get_tremor_data("Simulation/data6");

timewindow_size_milisec = 400;

[data1_features] = extract_features_in_timewindow(data1, timewindow_size_milisec, 'r');
[data6_features] = extract_features_in_timewindow(data6, timewindow_size_milisec, 'b');

%% Plot Mean values

data1_M = [];
for i = 1:length(data1_features)
    data1_M = [data1_M; data1_features{i, 7}];
end

data6_M = [];
for i = 1:length(data6_features)
    data6_M = [data6_M; data6_features{i, 7}];
end

plot(data1_M, 'r'); hold on;
plot(data6_M, 'b'); hold on;
title('Mean (x axis)')
xlabel('x')
ylabel('y')
