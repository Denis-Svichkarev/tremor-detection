%% Spectrum Comparison

close all
clear all

movementData = get_acc_data("Simulation/data14");
simulationData = get_acc_data("Simulation/data1");

timewindow_1 = movementData{2}.x;
timewindow_2 = simulationData{2}.x(1:end);

Fs = 1e2;

L_1 = length(timewindow_1);
L_2 = length(timewindow_2);

Y_1 = fft(timewindow_1);
Y_2 = fft(timewindow_2);

P2_1 = abs(Y_1 / L_1);
P1_1 = P2_1(1:L_1/2+1);
P1_1(2:end-1) = 2 * P1_1(2:end-1);
f_1 = Fs * (0:(L_1/2))/L_1;

P2_2 = abs(Y_2 / L_2);
P1_2 = P2_2(1:L_2/2+1);
P1_2(2:end-1) = 2 * P1_2(2:end-1);
f_2 = Fs * (0:(L_2/2))/L_2;

hold on;

plot(f_1, P1_1, 'b');
plot(f_2, P1_2, 'r');

title('Single-Sided Amplitude Spectrum of X(t) and Y(t)','FontSize', 16)
xlabel('f (Hz)')
ylabel('|P(f)|')
legend('X(t) - Movement example', 'Y(t) - Tremor example','FontSize', 14)