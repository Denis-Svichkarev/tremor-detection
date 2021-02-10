% Preprocessing

%% Welch

close all
clear all

movementData = get_tremor_data("Simulation/data6");
simulationData = get_tremor_data("Simulation/data1");

pxx1 = pwelch(movementData{1}.z(401:801));
pxx2 = pwelch(simulationData{1}.z(401:801));

plot(pxx1, 'b'); hold on;
plot(pxx2, 'r'); hold on;

%% Extract 3-9 Hz frequencies

close all
clear all

movementData = get_tremor_data("Simulation/data6");
simulationData = get_tremor_data("Simulation/data1");

[amplitudes1, frequencies1] = get_frequencies_spectrum(movementData{1}.z(1:401));
[amplitudes2, frequencies2] = get_frequencies_spectrum(simulationData{1}.z(1:401));

% plot(frequencies, amplitudes, 'r'); hold on;
% title('X(t), 4 sec')
% xlabel('f (Hz)')
% ylabel('A')

rangedFrequencies1 = [];
rangedAmplitudess1 = [];

for i = 1:length(frequencies1)
    if frequencies1(i) >= 3 && frequencies1(i) <= 9 
        rangedFrequencies1 = [rangedFrequencies1, frequencies1(i)];
        rangedAmplitudess1 = [rangedAmplitudess1, amplitudes1(i)];
    end
end

rangedFrequencies2 = [];
rangedAmplitudess2 = [];

for i = 1:length(frequencies2)
    if frequencies2(i) >= 3 && frequencies2(i) <= 9 
        rangedFrequencies2 = [rangedFrequencies2, frequencies2(i)];
        rangedAmplitudess2 = [rangedAmplitudess2, amplitudes2(i)];
    end
end

plot(rangedFrequencies1, rangedAmplitudess1, 'b'); hold on;
plot(rangedFrequencies2, rangedAmplitudess2, 'r'); hold on;
title('X(t), 4 sec')
xlabel('f (Hz)')
ylabel('A')

% Basic features

m1 = mean(rangedAmplitudess1);
m2 = mean(rangedAmplitudess2);

%% Extract features from data

close all
clear all

data1 = get_tremor_data("Simulation/data1");
data6 = get_tremor_data("Simulation/data6");

timewindow_size_milisec = 400;

[data1_features] = extract_features_in_timewindow(data1, timewindow_size_milisec, 'r');
[data6_features] = extract_features_in_timewindow(data6, timewindow_size_milisec, 'b');

data1_M = [];
for i = 1:length(data1_features)
    data1_M = [data1_M; data1_features{i, 1}];
end

data6_M = [];
for i = 1:length(data6_features)
    data6_M = [data6_M; data6_features{i, 1}];
end

plot(data1_M, 'r'); hold on;
plot(data6_M, 'b'); hold on;
title('Mean')
xlabel('x')
ylabel('y')


%% FFT

close all
clear all

movementData = get_tremor_data("Movement");
simulationData = get_tremor_data("Simulation");

N = length(movementData);

for i = 1:N
    [amplitudes, frequencies] = get_frequencies_spectrum(movementData{i}.x);

    plot(frequencies, amplitudes, 'r'); hold on;
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('A')
end

M = length(simulationData);

for i = 1:M
    [amplitudes, frequencies] = get_frequencies_spectrum(simulationData{i}.x);

    plot(frequencies, amplitudes, 'b'); hold on;
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('A')
end