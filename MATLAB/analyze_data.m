%% - Butterworth filter at 0.3 Hz

close all
clear all

% Data

%movementsTable = readtable('T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-Ivv8OB-2021_02_02_12_08_24-1.0.csv');
%tremorTable = readtable('ST-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-stszwC-2021_02_02_12_09_21-1.0.csv');

movementsTable = readtable('T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-ozUYeJ-2021_02_03_08_13_22-1.0.csv');
tremorTable = readtable('ST-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-Dr4wdB-2021_02_03_08_14_08-1.0.csv');

movementTimestamps = movementsTable.timestamp;
movementValues = movementsTable.x;

tremorTimestamps = tremorTable.timestamp;
tremorValues = tremorTable.x;

% Filter

[a, b] = butter(3, 0.3, 'high');

filteredMovementValues=filtfilt(a, b, movementValues);
filteredTremorValues=filtfilt(a, b, tremorValues);

plot(timestamps, values, 'bo--'); hold on;
xlabel('Timestamp');
ylabel('X');

plot(movementTimestamps, filteredMovementValues, 'rx-'); hold on;
plot(tremorTimestamps, filteredTremorValues, 'bx--'); hold on;
xlabel('Timestamp');
ylabel('X');

%% - Spectrum

close all
clear all

% Data

%movementsTable = readtable('T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-Ivv8OB-2021_02_02_12_08_24-1.0.csv');
%tremorTable = readtable('ST-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-stszwC-2021_02_02_12_09_21-1.0.csv');

movementsTable = readtable('T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-ozUYeJ-2021_02_03_08_13_22-1.0.csv');
tremorTable = readtable('ST-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-Dr4wdB-2021_02_03_08_14_08-1.0.csv');

movementTimestamps = movementsTable.timestamp;
movementValues = movementsTable.x;

tremorTimestamps = tremorTable.timestamp;
tremorValues = tremorTable.x;

% Spectrum

timewindow_1 = movementValues;
timewindow_2 = tremorValues(1:end);

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

plot(f_1, P1_1, 'r'); hold on;
plot(f_2, P1_2, 'b'); hold on;

title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')