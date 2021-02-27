% Butterworth filter at 0.3 Hz

[a, b] = butter(3, 0.3, 'high');
filteredMovementValues = filtfilt(a, b, amplitudes);
  
plot(frequencies, filteredMovementValues, 'b'); hold on;
xlabel('Timestamp');
ylabel('X');