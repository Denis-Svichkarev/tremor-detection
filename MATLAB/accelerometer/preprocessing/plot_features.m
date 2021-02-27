%% Plot features

close all
clear all

data1 = get_acc_data("Simulation/data1");
data2 = get_acc_data("Simulation/data2");
data3 = get_acc_data("Simulation/data3");
data4 = get_acc_data("Simulation/data4");
data5 = get_acc_data("Simulation/data5");
data6 = get_acc_data("Simulation/data6");
data7 = get_acc_data("Simulation/data7");
data8 = get_acc_data("Simulation/data8");
data9 = get_acc_data("Simulation/data9");
data10 = get_acc_data("Simulation/data10");
data11 = get_acc_data("Simulation/data11");
data12 = get_acc_data("Simulation/data12");
data13 = get_acc_data("Simulation/data13");
data14 = get_acc_data("Simulation/data14");
data15 = get_acc_data("Simulation/data15");
data16 = get_acc_data("Simulation/data16");

timewindow_size_milisec = 200;

[data1_features] = extract_features_in_timewindow(data1, timewindow_size_milisec);
[data2_features] = extract_features_in_timewindow(data2, timewindow_size_milisec);
[data3_features] = extract_features_in_timewindow(data3, timewindow_size_milisec);
[data4_features] = extract_features_in_timewindow(data4, timewindow_size_milisec);
[data5_features] = extract_features_in_timewindow(data5, timewindow_size_milisec);
[data6_features] = extract_features_in_timewindow(data6, timewindow_size_milisec);
[data7_features] = extract_features_in_timewindow(data7, timewindow_size_milisec);
[data8_features] = extract_features_in_timewindow(data8, timewindow_size_milisec);
[data9_features] = extract_features_in_timewindow(data9, timewindow_size_milisec);
[data10_features] = extract_features_in_timewindow(data10, timewindow_size_milisec);
[data11_features] = extract_features_in_timewindow(data11, timewindow_size_milisec);
[data12_features] = extract_features_in_timewindow(data12, timewindow_size_milisec);
[data13_features] = extract_features_in_timewindow(data13, timewindow_size_milisec);
[data14_features] = extract_features_in_timewindow(data14, timewindow_size_milisec);
[data15_features] = extract_features_in_timewindow(data15, timewindow_size_milisec);
[data16_features] = extract_features_in_timewindow(data16, timewindow_size_milisec);

%% Plot Features

selected_feature = 7;

data1_M = [];
for i = 1:size(data1_features, 1)
    data1_M = [data1_M; data1_features{i, selected_feature}];
end

data2_M = [];
for i = 1:size(data2_features, 1)
    data2_M = [data2_M; data2_features{i, selected_feature}];
end

data3_M = [];
for i = 1:size(data3_features, 1)
    data3_M = [data3_M; data3_features{i, selected_feature}];
end

data4_M = [];
for i = 1:size(data4_features, 1)
    data4_M = [data4_M; data4_features{i, selected_feature}];
end

data5_M = [];
for i = 1:size(data5_features, 1)
    data5_M = [data5_M; data5_features{i, selected_feature}];
end

data6_M = [];
for i = 1:size(data6_features, 1)
    data6_M = [data6_M; data6_features{i, selected_feature}];
end

data7_M = [];
for i = 1:size(data7_features, 1)
    data7_M = [data7_M; data7_features{i, selected_feature}];
end

data8_M = [];
for i = 1:size(data8_features, 1)
    data8_M = [data8_M; data8_features{i, selected_feature}];
end

data9_M = [];
for i = 1:size(data9_features, 1)
    data9_M = [data9_M; data9_features{i, selected_feature}];
end

data10_M = [];
for i = 1:size(data10_features, 1)
    data10_M = [data10_M; data10_features{i, selected_feature}];
end

data11_M = [];
for i = 1:size(data11_features, 1)
    data11_M = [data11_M; data11_features{i, selected_feature}];
end

data12_M = [];
for i = 1:size(data12_features, 1)
    data12_M = [data12_M; data12_features{i, selected_feature}];
end

data13_M = [];
for i = 1:size(data13_features, 1)
    data13_M = [data13_M; data13_features{i, selected_feature}];
end

data14_M = [];
for i = 1:size(data14_features, 1)
    data14_M = [data14_M; data14_features{i, selected_feature}];
end

data15_M = [];
for i = 1:size(data15_features, 1)
    data15_M = [data15_M; data15_features{i, selected_feature}];
end

data16_M = [];
for i = 1:size(data16_features, 1)
    data16_M = [data16_M; data16_features{i, selected_feature}];
end

plot(data1_M, 'r'); hold on;
plot(data2_M, 'r'); hold on;
plot(data3_M, 'r'); hold on;
plot(data4_M, 'r'); hold on;
plot(data5_M, 'r'); hold on;
plot(data6_M, 'r'); hold on;
plot(data7_M, 'r'); hold on;
plot(data8_M, 'r'); hold on;
plot(data9_M, 'r'); hold on;
plot(data10_M, 'r'); hold on;
plot(data11_M, 'r'); hold on;
plot(data12_M, 'r'); hold on;
plot(data13_M, 'b'); hold on;
plot(data14_M, 'b'); hold on;
plot(data15_M, 'b'); hold on;
plot(data16_M, 'g'); hold on;

title('Feature (x axis)')
xlabel('x')
ylabel('y')
