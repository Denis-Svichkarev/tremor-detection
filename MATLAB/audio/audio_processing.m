%% Plot audio

clear all
close all

minLimit = 430;
maxLimit = 450;

files = get_audio_data("All"); 

i = 6;

y = files(i,1).y{1};
fs = files(i,2).fs{1};
filename = files(i,3).filename{1};
    
N = length(y);
        
time = (1:length(y)) / fs;
[amp, freq] = get_audio_spectrum(y); 
[cut_amp, cut_freq] = extractFreqRange(amp, freq, minLimit, maxLimit);

hold on;
%plot(freq, amp, 'b');
plot(cut_freq, cut_amp, 'r');
xlabel('Time');
ylabel('Amplitude');

fprintf('Information of the sound file "%s":\n', filename);
fprintf('Duration= %g seconds\n', length(y)/fs);
fprintf('Number of samples %g:\n', N);
fprintf('Sampling rate = %g samples/second\n', fs);

% Plot template sound

base_audio = '440hz_sound.mp3';
[base_y, base_fs] = audioread(base_audio);
base_y = base_y(:, 1);

base_time = (1:length(base_y)) / base_fs;
[base_amp, base_freq] = get_audio_spectrum(base_y); 
[cut_base_amp, cut_base_freq] = extractFreqRange(base_amp, base_freq, minLimit, maxLimit);

%figure(2);
plot(cut_base_freq, cut_base_amp, 'b');

% TODO: expand base audio instead of this:
%y(size(base_y, 1)+1:end,:) = [];

%[theta, thetadeg, phi] = find_audio_phase(y, base_y, time);

%theta
%thetadeg
%phi

%% Finding the phase

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
plot(t, C1, t, C2, t, sinsum)
grid
legend('Ch 1', 'Ch 2', 'Ch 1 + Ch 2', 'Location','best')
text(250, 2, sprintf('\\theta = %.3f rad = %.3f\\circ', theta, thetadeg))