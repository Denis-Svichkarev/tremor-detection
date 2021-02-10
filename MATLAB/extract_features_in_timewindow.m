% Extract features in timewindow
function [data_features] = extract_features_in_timewindow(data, timewindow_size_milisec, color)
    data_features = cell(length(data));
    index = 1;

    for i = 1:length(data)    
        % x axis

        measurement_time = length(data{i}.x);

        if measurement_time > 0
            for j = 1:timewindow_size_milisec:measurement_time
                if j + timewindow_size_milisec <= measurement_time
                    [amplitudes, frequencies] = get_frequencies_spectrum(data{i}.x(j:j + timewindow_size_milisec));
                    [freq, amp, M] = get_features(amplitudes, frequencies, color);

                    data_features{index, 1} = M;
                    data_features{index, 2} = freq;
                    data_features{index, 3} = amp;

                    index = index + 1;
                end
            end
        end

        % y axis

        measurement_time = length(data{i}.y);

        if measurement_time > 0
            for j = 1:timewindow_size_milisec:measurement_time
                if j + timewindow_size_milisec <= measurement_time
                    [amplitudes, frequencies] = get_frequencies_spectrum(data{i}.y(j:j + timewindow_size_milisec));
                    [freq, amp, M] = get_features(amplitudes, frequencies, color);

                    data_features{index, 1} = M;
                    data_features{index, 2} = freq;
                    data_features{index, 3} = amp;

                    index = index + 1;
                end
            end
        end

        % z axis

        measurement_time = length(data{i}.z);

        if measurement_time > 0
            for j = 1:timewindow_size_milisec:measurement_time
                if j + timewindow_size_milisec <= measurement_time
                    [amplitudes, frequencies] = get_frequencies_spectrum(data{i}.z(j:j + timewindow_size_milisec));
                    [freq, amp, M] = get_features(amplitudes, frequencies, color);

                    data_features{index, 1} = M;
                    data_features{index, 2} = freq;
                    data_features{index, 3} = amp;

                    index = index + 1;
                end
            end
        end
    end
end