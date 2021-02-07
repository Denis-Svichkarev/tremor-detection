% Preprocessing

%% Extract 3-9 Hz frequencies

close all
clear all

movementData = get_tremor_data("Movement");
simulationData = get_tremor_data("Simulation");

[amplitudes1, frequencies1] = get_frequencies_spectrum(movementData{1}.x(1:401));
[amplitudes2, frequencies2] = get_frequencies_spectrum(simulationData{1}.x(1:401));

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