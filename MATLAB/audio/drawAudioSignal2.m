function [cut_amp, cut_freq] = drawAudioSignal2(y, fs, filename, color) 
    minLimit = 15900;
    maxLimit = 16100;

    N = length(y);

    %time = (1:length(y)) / fs;
    [amp, freq] = get_audio_spectrum(y); 
    [cut_amp, cut_freq] = extractFreqRange(amp, freq, minLimit, maxLimit);

    hold on;
    %plot(freq, amp, 'g');
    plot(cut_freq, cut_amp, 'Color', color);
    xlabel('Frequence');
    ylabel('Amplitude');

    fprintf('Information of the sound file "%s":\n', filename);
    fprintf('Duration= %g seconds\n', length(y)/fs);
    fprintf('Number of samples %g:\n', N);
    fprintf('Sampling rate = %g samples/second\n', fs);
end