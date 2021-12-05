% Extract audio features in timewindow
function data_features = extractAudioFeatures(data, fs, timewindow)
    index = 1;
    timewindow_size = timewindow * fs;

    measurement_time = size(data, 1);
    data_features = cell(floor(measurement_time / timewindow_size), 18);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            
            [amplitudes_X1, frequencies_X1] = get_frequencies_audio_spectrum(data(j + 1:j + timewindow_size));
            [freq_X1, amp_X1, W, M_X1, S_X1, M2_X1, maxValue_X1, minValue_X1, ...
                        I_X1, Q_X1, SK_X1, K_X1, M_T_X1, S_T_X1, M2_T_X1, ...
                        maxValue_T_X1, minValue_T_X1, ...
                        I_T_X1, Q_T_X1] = get_audio_features(amplitudes_X1, frequencies_X1);
            
            % Frequency domain features
            
             data_features{index, 1} = amp_X1;
             data_features{index, 2} = W;
             data_features{index, 3} = M_X1;
             data_features{index, 4} = S_X1;
             data_features{index, 5} = M2_X1;
             data_features{index, 6} = maxValue_X1;
             data_features{index, 7} = minValue_X1;
             data_features{index, 8} = I_X1;
             data_features{index, 9} = Q_X1;
             data_features{index, 10} = SK_X1;
             data_features{index, 11} = K_X1;
                     
             % Time domain features
                    
             data_features{index, 12} = Q_T_X1;
             data_features{index, 13} = M_T_X1;
             data_features{index, 14} = S_T_X1;
             data_features{index, 15} = M2_T_X1;
             data_features{index, 16} = maxValue_T_X1;
             data_features{index, 17} = minValue_T_X1;
             data_features{index, 18} = I_T_X1;
                    
             index = index + 1;
        end
    end
end