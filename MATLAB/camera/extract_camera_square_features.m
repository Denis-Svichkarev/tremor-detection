% Extract camera square features in timewindow
function data_features = extract_camera_square_features(data, time)
    index = 1;
    samples_per_sec = 30;
    timewindow_size = time * samples_per_sec;

    measurement_time = data.timestamp(end);
    data_features = cell(22, 1);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            
            [amplitudes, frequencies] = get_frequencies_spectrum(data.area(j + 1:j + timewindow_size));
            [freq, amp, M, S, M2, maxValue, minValue, ...
                        I, Q, SK, K, M_T, S_T, M2_T, ...
                        maxValue_T, minValue_T, ...
                        I_T, Q_T] = get_features(amplitudes, frequencies);

             % Frequency domain features
                    
             data_features{1, index} = amp;
             data_features{2, index} = M;
             data_features{3, index} = S;
             data_features{4, index} = M2;
             data_features{5, index} = maxValue;
             data_features{6, index} = minValue;
             data_features{7, index} = I;
             data_features{8, index} = Q;
             data_features{9, index} = SK;
             data_features{10, index} = K;
                     
             % Time domain features
                    
             data_features{11, index} = Q_T;
             data_features{12, index} = M_T;
             data_features{13, index} = S_T;
             data_features{14, index} = M2_T;
             data_features{15, index} = maxValue_T;
             data_features{16, index} = minValue_T;
             data_features{17, index} = I_T;
                    
             index = index + 1;
        end
    end
end