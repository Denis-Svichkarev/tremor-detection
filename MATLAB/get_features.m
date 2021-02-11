% Extract 3-9 Hz frequencies and basic characteristics
function [freq, amp, M, S, M2, maxValue, minValue, ecdf_f, ecdf_x, E, I, Q, SK, K, W, M_T, S_T] = get_features(amplitudes, frequencies, color)
    min_tremor_freq = 3.0;
    max_tremor_freq = 9.0;

    freq = [];
    amp = [];

    for i = 1:length(frequencies)
        if frequencies(i) >= min_tremor_freq && frequencies(i) <= max_tremor_freq 
            freq = [freq, frequencies(i)];
            amp = [amp, amplitudes(i)];
        end
    end

    % Frequency domain features

    M = mean(amp);
    S = std(amp);
    M2 = median(amp);
    maxValue = max(amp);
    minValue = min(amp);
    [ecdf_f,ecdf_x] = ecdf(amp);
    E = entropy(amp);
    I = iqr(amp);
    Q = trapz(amp);
    
    W = pwelch(amp);
    SK = skewness(amp);
    K = kurtosis(amp);
    
    % Time domain features

    M_T = mean(amplitudes);
    S_T = std(amplitudes);
    
end
 