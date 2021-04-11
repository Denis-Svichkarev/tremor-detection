data = get_raw_camera_data("All");

sample = data{1};

%% Plot area data 

hold on;
xlabel('x');
ylabel('y');
title('Camera data area example');
plot(sample.timestamp, sample.area, 'r');

%% Plot one point 

hold on;
xlabel('x');
ylabel('y');
title('Camera data one point example');
plot(sample.timestamp, sample.px1, 'r');
plot(sample.timestamp, sample.py1, 'b');