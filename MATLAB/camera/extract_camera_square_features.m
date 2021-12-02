% Extract camera square features in timewindow
function data_features = extract_camera_square_features(data, time)
    index = 1;
    samples_per_sec = 30;
    timewindow_size = time * samples_per_sec;
    measurement_time = size(data, 1);

    data_features = cell(floor(measurement_time / timewindow_size), 17);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            
            [amplitudes, frequencies] = get_frequencies_spectrum(data.area(j + 1:j + timewindow_size));
            [freq, amp, M, S, M2, maxValue, minValue, ...
                        I, Q, SK, K, M_T, S_T, M2_T, ...
                        maxValue_T, minValue_T, ...
                        I_T, Q_T] = get_features(amplitudes, frequencies);

             % Frequency domain features
                    
             data_features{index, 1} = amp;
             data_features{index, 2} = M;
             data_features{index, 3} = S;
             data_features{index, 4} = M2;
             data_features{index, 5} = maxValue;
             data_features{index, 6} = minValue;
             data_features{index, 7} = I;
             data_features{index, 8} = Q;
             data_features{index, 9} = SK;
             data_features{index, 10} = K;
                     
             % Time domain features
                    
             data_features{index, 11} = Q_T;
             data_features{index, 12} = M_T;
             data_features{index, 13} = S_T;
             data_features{index, 14} = M2_T;
             data_features{index, 15} = maxValue_T;
             data_features{index, 16} = minValue_T;
             data_features{index, 17} = I_T;
                    
             index = index + 1;
        end
    end
end