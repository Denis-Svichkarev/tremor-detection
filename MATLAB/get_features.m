% Extract 3-9 Hz frequencies and basic characteristics
function [freq, amp, M, S, M2, maxValue, minValue] = get_features(amplitudes, frequencies, color)
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

%     plot(freq, amp, color); hold on;
%     title('X(t), 4 sec')
%     xlabel('f (Hz)')
%     ylabel('A')

    % Basic features

    M = mean(amp);
    S = std(amp);
    M2 = median(amp);
    maxValue = max(amp);
    minValue = min(amp);
end
 