% Extract audio frequencies and basic characteristics
function [freq, amp, M, S, M2, maxValue, minValue, ecdf_f, ecdf_x, I, Q, SK, K, W, M_T, S_T, M2_T, maxValue_T, minValue_T, ecdf_f_T, ecdf_x_T, I_T, Q_T] = get_audio_features(amplitudes, frequencies)
    min_tremor_freq = 15900;
    max_tremor_freq = 16100;

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
    [ecdf_f, ecdf_x] = ecdf(amp);
    %E = entropy(amp);
    I = iqr(amp);
    Q = trapz(amp);
    
    SK = skewness(amp);
    K = kurtosis(amp);
    W = pwelch(amp);
        
    % Time domain features

    M_T = mean(amplitudes);
    S_T = std(amplitudes);
    M2_T = median(amplitudes);
    maxValue_T = max(amplitudes);
    minValue_T = min(amplitudes);
    [ecdf_f_T, ecdf_x_T] = ecdf(amplitudes);
    %E_T = entropy(amplitudes);
    I_T = iqr(amplitudes);
    Q_T = trapz(amplitudes);
end
 