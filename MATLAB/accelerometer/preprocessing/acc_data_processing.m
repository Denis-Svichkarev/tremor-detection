%% Load data

close all
clear all

data = get_acc_data("All");
%data = get_acc_data("Simulation/data15");
sample = data{6};

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

timewindow_size = 200; % 2 seconds window
data_features = extract_acc_features(sample, timewindow_size);

t = floor(sample.timestamp(end)) + 5;

% X axis

fft_X_x = (1:t);
fft_X_y = (1:t);

for i = 1:size(data_features, 1)
    amp_max_x = max(data_features{i, 4});
    j = i * 2;
    fft_X_y(j) = amp_max_x;
    fft_X_y(j - 1) = amp_max_x;
end

if size(data_features, 1) * 2 < t
    for i = size(data_features, 1) * 2 : t
        fft_X_y(i) = 0;
    end
end

plot(fft_X_x, fft_X_y, 'r');

% Y axis

fft_Y_x = (1:t);
fft_Y_y = (1:t);

for i = 1:size(data_features, 1)
    amp_max_y = max(data_features{i, 5});
    j = i * 2;
    fft_Y_y(j) = amp_max_y;
    fft_Y_y(j - 1) = amp_max_y;
end

if size(data_features, 1) * 2 < t
    for i = size(data_features, 1) * 2 : t
        fft_Y_y(i) = 0;
    end
end

plot(fft_Y_x, fft_Y_y, 'g');

% Z axis

fft_Z_x = (1:t);
fft_Z_y = (1:t);

for i = 1:size(data_features, 1)
    amp_max_z = max(data_features{i, 6});
    j = i * 2;
    fft_Z_y(j) = amp_max_z;
    fft_Z_y(j - 1) = amp_max_z;
end

if size(data_features, 1) * 2 < t
    for i = size(data_features, 1) * 2 : t
        fft_Z_y(i) = 0;
    end
end

plot(fft_Z_x, fft_Z_y, 'b');