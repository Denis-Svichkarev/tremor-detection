% Preprocessing

close all
clear all

movementData = get_tremor_data("Movement");
simulationData = get_tremor_data("Simulation");

% Butterworth filter at 0.3 Hz

movementTimestamps = movementData{1}.timestamp;
movementValues = movementData{1}.x;

tremorTimestamps = simulationData{1}.timestamp;
tremorValues = simulationData{1}.x;

[a, b] = butter(3, 0.3, 'high');

filteredMovementValues = filtfilt(a, b, movementValues);
filteredTremorValues = filtfilt(a, b, tremorValues);

plot(movementTimestamps, filteredMovementValues, 'r'); hold on;
plot(tremorTimestamps, filteredTremorValues, 'b'); hold on;
xlabel('Timestamp');
ylabel('X');