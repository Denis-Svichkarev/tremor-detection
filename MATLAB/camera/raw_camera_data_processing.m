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

processed_px1 = raw_camera_data_proprocessing(sample.px1); 
processed_py1 = raw_camera_data_proprocessing(sample.py1); 

processed_px2 = raw_camera_data_proprocessing(sample.px2); 
processed_py2 = raw_camera_data_proprocessing(sample.py2); 

processed_px3 = raw_camera_data_proprocessing(sample.px3); 
processed_py3 = raw_camera_data_proprocessing(sample.py3); 

processed_px4 = raw_camera_data_proprocessing(sample.px4); 
processed_py4 = raw_camera_data_proprocessing(sample.py4); 

plot(sample.timestamp, processed_px1, 'b');
plot(sample.timestamp, processed_py1, 'r');

plot(sample.timestamp, processed_px2, 'b');
plot(sample.timestamp, processed_py2, 'r');

plot(sample.timestamp, processed_px3, 'b');
plot(sample.timestamp, processed_py3, 'r');

plot(sample.timestamp, processed_px4, 'b');
plot(sample.timestamp, processed_py4, 'r');