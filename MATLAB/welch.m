%% Welch

close all
clear all

movementData = get_tremor_data("Simulation/data6");
simulationData = get_tremor_data("Simulation/data1");

pxx1 = pwelch(movementData{1}.z(401:801));
pxx2 = pwelch(simulationData{1}.z(401:801));

plot(pxx1, 'b'); hold on;
plot(pxx2, 'r'); hold on;