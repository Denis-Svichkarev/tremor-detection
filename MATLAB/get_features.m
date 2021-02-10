% Extract 3-9 Hz frequencies
function [freq, amp, M] = get_features(amplitudes, frequencies, color)
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
end
 