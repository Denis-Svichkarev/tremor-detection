% FFT spectrum from signal
function [amplitudes, frequencies] = get_frequencies_spectrum(signal) 
    timewindow = signal;
    Fs = 100; % sampling frequency

    L = length(timewindow);
    Y = fft(timewindow);

    P2 = abs(Y / L);
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2 * P1(2:end-1);
    f = Fs * (0:floor(L/2))/L;

    amplitudes = P1;
    frequencies = f;
    
    % fs = 100;               % sampling frequency
    % t = 0:(1/fs):(10-1/fs); % time vector
    % 
    % n = length(timewindow);
    % X = fft(timewindow);
    % 
    % f = (0:n-1)*(fs/n);     %frequency range
    % power = abs(X).^2/n;    %power
    % plot(f, power); hold on;
end