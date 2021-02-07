% Preprocessing

close all
clear all

movementData = get_tremor_data("Movement");
simulationData = get_tremor_data("Simulation");

% FFT

N = length(movementData);

for i = 1:N
    [amplitudes, frequencies] = get_frequencies_spectrum(movementData{i}.y);

    plot(frequencies, amplitudes, 'r'); hold on;
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('A')
end

M = length(simulationData);

for i = 1:M
    [amplitudes, frequencies] = get_frequencies_spectrum(simulationData{i}.y);

    plot(frequencies, amplitudes, 'b'); hold on;
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('A')
end