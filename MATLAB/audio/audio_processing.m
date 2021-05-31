%% Plot audio

clear all
close all

files = get_audio_data("AudioTest"); 

[cut_amp1, cut_freq1] = drawAudioSignal(files, 1, [1, 0, 0]); % tremor
[cut_amp2, cut_freq2] = drawAudioSignal(files, 2, [0.3, 0.2, 0]); % tremor with noise
[cut_amp3, cut_freq3] = drawAudioSignal(files, 3, [0, 0.8, 0.9]); % static
[cut_amp4, cut_freq4] = drawAudioSignal(files, 4, [0, 0, 1]); % static with noise

M1 = mean(cut_amp1);
M2 = mean(cut_amp2);
M3 = mean(cut_amp3);
M4 = mean(cut_amp4);

W1 = iqr(cut_amp1);
W2 = iqr(cut_amp2);
W3 = iqr(cut_amp3);
W4 = iqr(cut_amp4);

hold off;
plot(W1, 'Color', [1, 0, 0]);
plot(W2, 'Color', [0.3, 0.2, 0]);
plot(W3, 'Color', [0, 0.8, 0.9]);
plot(W4, 'Color', [0, 0, 1]);

%     M = mean(amp);
%     S = std(amp);
%     M2 = median(amp);
%     maxValue = max(amp);
%     minValue = min(amp);
%     [ecdf_f, ecdf_x] = ecdf(amp);
%     %E = entropy(amp);
%     I = iqr(amp);
%     Q = trapz(amp);
%     
%     SK = skewness(amp);
%     K = kurtosis(amp);
%     W = pwelch(amp);

%% Get features

clear all
close all

files = get_audio_data("All"); 

file_index_1 = 1;
file_index_2 = 2;
file_index_3 = 3;
file_index_4 = 4;

y_1 = files(file_index_1, 1).y{1};
fs_1 = files(file_index_1, 2).fs{1};
filename_1 = files(file_index_1, 3).filename{1};

y_2 = files(file_index_2, 1).y{1};
fs_2 = files(file_index_2, 2).fs{1};
filename_2 = files(file_index_2, 3).filename{1};

y_3 = files(file_index_3, 1).y{1};
fs_3 = files(file_index_3, 2).fs{1};
filename_3 = files(file_index_3, 3).filename{1};

y_4 = files(file_index_4, 1).y{1};
fs_4 = files(file_index_4, 2).fs{1};
filename_4 = files(file_index_4, 3).filename{1};

%% Get features

timewindow = 4; % 2 seconds

signal1 = y_1';
sampleTable1 = table(signal1);
data_features_1 = extract_audio_features(signal1, fs_1, timewindow);

signal2 = y_2';
sampleTable2 = table(signal2);
data_features_2 = extract_audio_features(signal2, fs_2, timewindow);

signal3 = y_3';
sampleTable3 = table(signal3);
data_features_3 = extract_audio_features(signal3, fs_3, timewindow);

signal4 = y_4';
sampleTable4 = table(signal4);
data_features_4 = extract_audio_features(signal4, fs_4, timewindow);

%% Plot FFT

hold on;
plot(data_features_1{1, 1}, data_features_1{1, 2}, 'Color', [1, 0, 0]);
plot(data_features_2{1, 1}, data_features_2{1, 2}, 'Color', [0.7, 0.2, 0]);
plot(data_features_3{1, 1}, data_features_3{1, 2}, 'Color', [0, 0.8, 0.9]);
plot(data_features_4{1, 1}, data_features_4{1, 2}, 'Color', [0, 0, 1]);
title('Audio FFT');

%% Maximum FFT

t1 = floor(size(signal1, 2) / fs_1);
t2 = floor(size(signal1, 2) / fs_1);

fft_x1 = (1:t1);
fft_y1 = (1:t1);

fft_x2 = (1:t2);
fft_y2 = (1:t2);

for i = 1:t1
    amp_max_x = max(data_features_1{i, 2});
    %j = i * 2;
    fft_y1(i) = amp_max_x;
    %fft_y1(j - 1) = amp_max_x;
end

for i = 1:t2
    amp_max_x = max(data_features_2{i, 2});
    %j = i * 2;
    fft_y2(i) = amp_max_x;
    %fft_y2(j - 1) = amp_max_x;
end

plot(fft_x1, fft_y1, 'r'); 
plot(fft_x2, fft_y2, 'b'); 
title('Audio maximum FFT during the measurement');