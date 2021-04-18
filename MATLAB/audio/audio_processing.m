%% Plot audio

clear all
close all

files = get_audio_data("All"); 

%drawAudioSignal(files, 3, [1, 0, 0]); % tremor
drawAudioSignal(files, 4, [1, 0, 0]); % tremor with noise

%drawAudioSignal(files, 1, [0, 0, 1]); % static
drawAudioSignal(files, 2, [0, 0, 1]); % static with noise

%% Get features

clear all
close all

files = get_audio_data("All"); 

file_index_1 = 3;
file_index_2 = 1;

y_1 = files(file_index_1, 1).y{1};
fs_1 = files(file_index_1, 2).fs{1};
filename_1 = files(file_index_1, 3).filename{1};

y_2 = files(file_index_2, 1).y{1};
fs_2 = files(file_index_2, 2).fs{1};
filename_2 = files(file_index_2, 3).filename{1};

%[tremorAmp, tremorFreq] = drawAudioSignal(y_1, fs_1, filename_1, [1, 0, 0]); % tremor with noise
%[staticAmp, staticFreq] = drawAudioSignal(y_2, fs_2, filename_2, [0, 0, 1]); % static with noise

%[freq, amp, M, S, M2, maxValue, minValue, ecdf_f, ecdf_x, I, Q, SK, K, W, M_T, S_T, M2_T, maxValue_T, minValue_T, ecdf_f_T, ecdf_x_T, I_T, Q_T] = get_audio_features(tremorAmp, tremorFreq);
%[freq_2, amp_2, M_2, S_2, M2_2, maxValue_2, minValue_2, ecdf_f_2, ecdf_x_2, I_2, Q_2, SK_2, K_2, W_2, M_T_2, S_T_2, M2_T_2, maxValue_T_2, minValue_T_2, ecdf_f_T_2, ecdf_x_T_2, I_T_2, Q_T_2] = get_audio_features(staticAmp, staticFreq);
 
%% Get features

timewindow = 2; % 2 seconds

signal1 = y_1';
sampleTable1 = table(signal1);
data_features_1 = extract_audio_features(signal1, fs_1, timewindow);

signal2 = y_2';
sampleTable2 = table(signal2);
data_features_2 = extract_audio_features(signal2, fs_2, timewindow);

%% Plot FFT

hold on;
plot(data_features_1{1, 1}, data_features_1{1, 2}, 'r');
plot(data_features_2{1, 1}, data_features_2{1, 2}, 'b');
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