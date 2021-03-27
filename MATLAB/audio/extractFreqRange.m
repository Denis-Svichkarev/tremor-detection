function [amp, freq] = extractFreqRange(amplitudes, frequencies, minFreq, maxFreq)
    freq = [];
    amp = [];

    maxAmp = 0.00002;
    
    for i = 1:length(frequencies)
        if frequencies(i) >= minFreq && frequencies(i) <= maxFreq 
            freq = [freq, frequencies(i)];
            if amplitudes(i) > maxAmp
                amp = [amp, maxAmp];
            else
                amp = [amp, amplitudes(i)];
            end
        end
    end
end