% Extract features in timewindow
function [data_features] = extract_features_in_timewindow(data, timewindow_size_milisec, color)
    data_features = cell(length(data));
    index = 1;

    for i = 1:length(data)    
        measurement_time = length(data{i}.x);

        if measurement_time > 0
            for j = 1:timewindow_size_milisec:measurement_time
                if j + timewindow_size_milisec <= measurement_time
                    
                    [amplitudes_X, frequencies_X] = get_frequencies_spectrum(data{i}.x(j:j + timewindow_size_milisec));
                    [freq_X, amp_X, M_X, S_X, M2_X, maxValue_X, minValue_X] = get_features(amplitudes_X, frequencies_X, color);

                    [amplitudes_Y, frequencies_Y] = get_frequencies_spectrum(data{i}.y(j:j + timewindow_size_milisec));
                    [freq_Y, amp_Y, M_Y, S_Y, M2_Y, maxValue_Y, minValue_Y] = get_features(amplitudes_Y, frequencies_Y, color);

                    [amplitudes_Z, frequencies_Z] = get_frequencies_spectrum(data{i}.z(j:j + timewindow_size_milisec));
                    [freq_Z, amp_Z, M_Z, S_Z, M2_Z, maxValue_Z, minValue_Z] = get_features(amplitudes_Z, frequencies_Z, color);

                    data_features{index, 1} = freq_X;
                    data_features{index, 2} = freq_Y;
                    data_features{index, 3} = freq_Z;
                    
                    data_features{index, 4} = amp_X;
                    data_features{index, 5} = amp_Y;
                    data_features{index, 6} = amp_Z;
                    
                    data_features{index, 7} = M_X;
                    data_features{index, 8} = M_Y;
                    data_features{index, 9} = M_Z;
                    
                    data_features{index, 10} = S_X;
                    data_features{index, 11} = S_Y;
                    data_features{index, 12} = S_Z;
                    
                    data_features{index, 13} = M2_X;
                    data_features{index, 14} = M2_Y;
                    data_features{index, 15} = M2_Z;
                    
                    data_features{index, 16} = maxValue_X;
                    data_features{index, 17} = maxValue_Y;
                    data_features{index, 18} = maxValue_Z;
                    
                    data_features{index, 19} = minValue_X;
                    data_features{index, 20} = minValue_Y;
                    data_features{index, 21} = minValue_Z;

                    index = index + 1;
                end
            end
        end
    end
end