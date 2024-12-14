data = get_raw_camera_data("All");

sample = data{1};

%% Plot area data 

hold on;
xlabel('x');
ylabel('y');
title('Camera data area example');
plot(sample.timestamp, sample.area, 'r');

%% Process points 

processed_px1 = raw_camera_data_preprocessing(sample.px1); 
processed_py1 = raw_camera_data_preprocessing(sample.py1); 

processed_px2 = raw_camera_data_preprocessing(sample.px2); 
processed_py2 = raw_camera_data_preprocessing(sample.py2); 

processed_px3 = raw_camera_data_preprocessing(sample.px3); 
processed_py3 = raw_camera_data_preprocessing(sample.py3); 

processed_px4 = raw_camera_data_preprocessing(sample.px4); 
processed_py4 = raw_camera_data_preprocessing(sample.py4); 

%% Plot points 

plot(sample.timestamp, processed_px1, 'b');
plot(sample.timestamp, processed_py1, 'r');

plot(sample.timestamp, processed_px2, 'b');
plot(sample.timestamp, processed_py2, 'r');
 
plot(sample.timestamp, processed_px3, 'b');
plot(sample.timestamp, processed_py3, 'r');
 
plot(sample.timestamp, processed_px4, 'b');
plot(sample.timestamp, processed_py4, 'r');

%% Get camera features

timestamp = sample.timestamp;
px1 = processed_px1';
py1 = processed_py1';
px2 = processed_px2';
py2 = processed_py2';
px3 = processed_px3';
py3 = processed_py3';
px4 = processed_px4';
py4 = processed_py4';

processed_sample = table(timestamp, px1, py1, px2, py2, px3, py3, px4, py4);

timewindow_size = 2; % 2 seconds window
data_features = extract_camera_features(processed_sample, timewindow_size);

%% Plot camera features

t = floor(timewindow_size * floor(processed_sample.timestamp(end) / 60));

% Point 1

fft_p1X_x = (1:t);
fft_p1X_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 9});
    j = i * 2;
    fft_p1X_y(j) = amp_max_x;
    fft_p1X_y(j - 1) = amp_max_x;
end

plot(fft_p1X_x, fft_p1X_y, 'r'); 
title('Camera rect points FFT, X, Y axes');
hold on;

fft_p1Y_x = (1:t);
fft_p1Y_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 13});
    j = i * 2;
    fft_p1Y_y(j) = amp_max_x;
    fft_p1Y_y(j - 1) = amp_max_x;
end

plot(fft_p1Y_x, fft_p1Y_y, 'b');

% Point 2

fft_p2X_x = (1:t);
fft_p2X_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 10});
    j = i * 2;
    fft_p2X_y(j) = amp_max_x;
    fft_p2X_y(j - 1) = amp_max_x;
end

plot(fft_p2X_x, fft_p2X_y, 'r'); hold on;

fft_p2Y_x = (1:t);
fft_p2Y_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 14});
    j = i * 2;
    fft_p2Y_y(j) = amp_max_x;
    fft_p2Y_y(j - 1) = amp_max_x;
end

plot(fft_p2Y_x, fft_p2Y_y, 'b');

% Point 3

fft_p3X_x = (1:t);
fft_p3X_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 11});
    j = i * 2;
    fft_p3X_y(j) = amp_max_x;
    fft_p3X_y(j - 1) = amp_max_x;
end

plot(fft_p3X_x, fft_p3X_y, 'r'); hold on;

fft_p3Y_x = (1:t);
fft_p3Y_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 15});
    j = i * 2;
    fft_p3Y_y(j) = amp_max_x;
    fft_p3Y_y(j - 1) = amp_max_x;
end

plot(fft_p3Y_x, fft_p3Y_y, 'b');

% Point 4

fft_p4X_x = (1:t);
fft_p4X_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 12});
    j = i * 2;
    fft_p4X_y(j) = amp_max_x;
    fft_p4X_y(j - 1) = amp_max_x;
end

plot(fft_p4X_x, fft_p4X_y, 'r'); hold on;

fft_p4Y_x = (1:t);
fft_p4Y_y = (1:t);

for i = 1:t/2
    amp_max_x = max(data_features{i, 16});
    j = i * 2;
    fft_p4Y_y(j) = amp_max_x;
    fft_p4Y_y(j - 1) = amp_max_x;
end

plot(fft_p4Y_x, fft_p4Y_y, 'b');

%% Average camera FFT

average_fft_x = fft_p1X_x;
average_fft_y = (1:t);

for i = 1:size(fft_p1X_y, 2)
    average_fft_y(i) = mean([fft_p1X_y(i), fft_p2X_y(i), fft_p3X_y(i), fft_p4X_y(i)]);
end

plot(average_fft_x, average_fft_y, 'b');
title('Average camera FFT');

%% Max camera FFT

max_fft_x = fft_p1X_x;
max_fft_y = (1:t);

for i = 1:size(fft_p1X_y, 2)
    max_fft_y(i) = max([fft_p1X_y(i), fft_p2X_y(i), fft_p3X_y(i), fft_p4X_y(i)]);
end

plot(max_fft_x, max_fft_y, 'b');
title('Max camera FFT');


