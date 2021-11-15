%% Get accelerometer max FFT
function [fft_X_x, fft_X_y, fft_Y_x, fft_Y_y, fft_Z_x, fft_Z_y] = get_acc_max_fft(data_features, t) 
    % X axis

    fft_X_x = (1:t);
    fft_X_y = (1:t);

    for i = 1:size(data_features, 1)
        amp_max_x = max(data_features{i, 4});
        j = i * 2;
        fft_X_y(j) = amp_max_x;
        fft_X_y(j - 1) = amp_max_x;
    end

    if size(data_features, 1) * 2 < t
        for i = size(data_features, 1) * 2 : t
            fft_X_y(i) = 0;
        end
    end

    % Y axis

    fft_Y_x = (1:t);
    fft_Y_y = (1:t);

    for i = 1:size(data_features, 1)
        amp_max_y = max(data_features{i, 5});
        j = i * 2;
        fft_Y_y(j) = amp_max_y;
        fft_Y_y(j - 1) = amp_max_y;
    end

    if size(data_features, 1) * 2 < t
        for i = size(data_features, 1) * 2 : t
            fft_Y_y(i) = 0;
        end
    end

    % Z axis

    fft_Z_x = (1:t);
    fft_Z_y = (1:t);

    for i = 1:size(data_features, 1)
        amp_max_z = max(data_features{i, 6});
        j = i * 2;
        fft_Z_y(j) = amp_max_z;
        fft_Z_y(j - 1) = amp_max_z;
    end

    if size(data_features, 1) * 2 < t
        for i = size(data_features, 1) * 2 : t
            fft_Z_y(i) = 0;
        end
    end
end