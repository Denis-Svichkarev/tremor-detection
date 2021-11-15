%% Load data

close all
clear all

data = get_acc_data("Research");
%data = get_acc_data("Simulation/data15");
sample = data{6};

%sample = get_acc_data_with_filename("All", "T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-b9ZYjX-2021_09_19_08_04_28-1.0.csv");
%sample = get_acc_data_with_filename("All", "T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-pRtGrV-2021_09_19_08_03_35-1.0.csv");

%% Plot axis data 

hold on;
xlabel('x');
ylabel('y');
sgtitle('File example: 40 seconds measurement');

subplot(4, 1, 1);
plot(sample.timestamp, sample.x, 'r');
title('X-axis, accelerometer data.');

subplot(4, 1, 2);
plot(sample.timestamp, sample.y, 'g');
title('Y-axis, accelerometer data.');

subplot(4, 1, 3);
plot(sample.timestamp, sample.z, 'b');
title('Z-axis, accelerometer data.');

%% Plot FFT data

subplot(4, 1, 4);
hold on;
title('X, Y, Z axis, FFT');

measurement_time = floor(size(sample, 1) / 100);
timewindow_size = 200; % 2 seconds window
data_features = extract_acc_features(sample, timewindow_size);
t = floor(sample.timestamp(end));

[fft_X_x, fft_X_y, fft_Y_x, fft_Y_y, fft_Z_x, fft_Z_y] = get_acc_max_fft(data_features, t);

plot(fft_X_x, fft_X_y, 'r');
plot(fft_Y_x, fft_Y_y, 'g');
plot(fft_Z_x, fft_Z_y, 'b');

%% Comparison of Tremor and Static Maximum values of FFT

close all
clear all

hold on;
title('Comparison of Tremor and Static Maximum frequency values of FFT');
xlabel('Time');
ylabel('Amplitude');

legend();

sample1 = get_acc_data_with_filename("All", "T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-b9ZYjX-2021_09_19_08_04_28-1.0.csv");
sample2 = get_acc_data_with_filename("All", "T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-pRtGrV-2021_09_19_08_03_35-1.0.csv");

t1 = floor(sample1.timestamp(end));
t2 = floor(sample2.timestamp(end));

timewindow_size = 200;

data_features1 = extract_acc_features(sample1, timewindow_size);
data_features2 = extract_acc_features(sample2, timewindow_size);

[fft_X_x_1, fft_X_y_1, fft_Y_x_1, fft_Y_y_1, fft_Z_x_1, fft_Z_y_1] = get_acc_max_fft(data_features1, t1);
[fft_X_x_2, fft_X_y_2, fft_Y_x_2, fft_Y_y_2, fft_Z_x_2, fft_Z_y_2] = get_acc_max_fft(data_features2, t2);

plot(fft_X_x_1, fft_X_y_1, 'Color', '#FF0000', 'DisplayName', 'Tremor X-axis');
plot(fft_Y_x_1, fft_Y_y_1, 'Color', '#FF8700', 'DisplayName', 'Tremor Y-axis');
plot(fft_Z_x_1, fft_Z_y_1, 'Color', '#FFE400', 'DisplayName', 'Tremor Z-axis');

plot(fft_X_x_2, fft_X_y_2, 'Color', '#55FF00', 'DisplayName', 'Static X-axis');
plot(fft_Y_x_2, fft_Y_y_2, 'Color', '#00FF78', 'DisplayName', 'Static Y-axis');
plot(fft_Z_x_2, fft_Z_y_2, 'Color', '#00FFC9', 'DisplayName', 'Static Z-axis');