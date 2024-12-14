function [cut_amp, cut_freq] = drawAudioSignal(files, i, color) 
    minLimit = 15900;
    maxLimit = 16100;

    y = files(i,1).y{1};
    fs = files(i,2).fs{1};
    filename = files(i,3).filename{1};

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