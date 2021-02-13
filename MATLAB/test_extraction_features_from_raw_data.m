close all
clear all

data1 = get_tremor_data("Simulation/data15");
x_data = data1{1}.x(201:400);
y_data = data1{1}.y(201:400);
z_data = data1{1}.z(201:400);

%%
data = [x_data.', y_data.', z_data.'];
[data_features] = extract_features_from_raw_data(data, 200);

%label1 = classify_accelerometer_data(data_features);
%label1