clear all
close all

fileName = 'T-1-000C18A0_4C4E_40AF_B8F6_FF6B72C7B61E-iPhone12,1-Apple-2NK6lY-2021_02_21_16_50_56-1.0.m4a';
[data, fs] = audioread(fileName);

N = length(data);

time = (1:length(data)) / fs;

data_1 = data(1:ceil(length(data)/2));
data_2 = data(ceil(length(data)/2):length(data));

time_1 = time(1:ceil(length(time)/2));
time_2 = time(ceil(length(time)/2):length(time));

[amp_1, freq_1] = get_frequencies_spectrum(data_1); 
[amp_2, freq_2] = get_frequencies_spectrum(data_2); 

hold on;
plot(freq_1, amp_1, 'r');
plot(freq_2, amp_2, 'b');

xlabel('Time');
ylabel('Amplitude');
fprintf('Information of the sound file "%s":\n', fileName);
fprintf('Duration= %g seconds\n', length(data)/fs);
fprintf('Number of samples %g:\n', N);
fprintf('Sampling rate = %g samples/second\n', fs);

% Finding the phase

t = time_1;

C1 = data_1;
C2 = data_2;

C1s = [mean(C1); 2*std(C1)];
C2s = [mean(C2); 2*std(C2)];
sinsum = C1 + C2;
sinsums = [mean(sinsum); 2*std(sinsum)];
c_fcn = @(theta) sqrt(C1s(2).^2 + C2s(2).^2 + 2*C1s(2).*C2s(2).*cos(theta)) - sinsums(2);
theta = fzero(c_fcn, 1);
thetadeg = theta*180/pi;
phi_fcn = @(theta) atan2(C2s(2).*sin(theta), C1s(2) + C2s(2).*cos(theta));
phi = fminsearch(@(b)norm(phi_fcn(b)), 1);
figure
plot(t, C1,   t, C2,    t, sinsum)
grid
legend('Ch 1', 'Ch 2', 'Ch 1 + Ch 2', 'Location','best')
text(250, 2, sprintf('\\theta = %.3f rad = %.3f\\circ', theta, thetadeg))