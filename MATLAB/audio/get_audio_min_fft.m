%% Get audio min FFT
function [fft_x, fft_y] = get_audio_min_fft(data_features, t) 
    fft_x = (1:t);
    fft_y = (1:t);

    for i = 1:size(data_features, 2)
        amp_max_x = min(data_features{1, i});
        j = i * 2;
        if j < size(fft_y, 2)
            fft_y(j) = amp_max_x;
            fft_y(j - 1) = amp_max_x;
        end
    end

    if size(data_features, 2) * 2 < t
        for i = size(data_features, 2) * 2 : t
            fft_y(i) = 0;
        end
    end
end