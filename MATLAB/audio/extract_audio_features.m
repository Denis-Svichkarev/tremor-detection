% Extract audio features in timewindow
function data_features = extract_audio_features(data, fs, timewindow)
    index = 1;
    timewindow_size = timewindow * fs;

    measurement_time = size(data, 2) / fs;
    data_features = cell(round(measurement_time), 1);
     
    for j = 0:timewindow_size:size(data, 2)
        if j + timewindow_size <= size(data, 2)
            
            % point 1
            
            [amplitudes_X1, frequencies_X1] = get_frequencies_spectrum(data(j + 1:j + timewindow_size));
            [freq_X1, amp_X1, M_X1, S_X1, M2_X1, maxValue_X1, minValue_X1, ...
                        ecdf_f_X1, ecdf_x_X1, I_X1, Q_X1, SK_X1, K_X1, M_T_X1, S_T_X1, M2_T_X1, ...
                        maxValue_T_X1, minValue_T_X1, ecdf_f_T_X1, ...
                        ecdf_x_T_X1, I_T_X1, Q_T_X1] = get_features(amplitudes_X1, frequencies_X1);
            
             % Frequency domain features
                    
             data_features{index, 1} = freq_X1;
                    
             data_features{index, 2} = amp_X1;
                    
             data_features{index, 3} = M_X1;
                    
             data_features{index, 4} = S_X1;
                    
             data_features{index, 5} = M2_X1;
                    
             data_features{index, 6} = maxValue_X1;
                    
             data_features{index, 7} = minValue_X1;
             
             data_features{index, 8} = ecdf_f_X1;
 
             data_features{index, 9} = ecdf_x_X1;
                    
             data_features{index, 10} = I_X1;
                    
             data_features{index, 11} = Q_X1;
                    
             data_features{index, 12} = SK_X1;
                    
             data_features{index, 13} = K_X1;
                     
             % Time domain features
                    
             data_features{index, 14} = Q_T_X1;
             
             data_features{index, 15} = M_T_X1;
             
             data_features{index, 16} = S_T_X1;
             
             data_features{index, 17} = M2_T_X1;
             
             data_features{index, 18} = maxValue_T_X1;
             
             data_features{index, 19} = minValue_T_X1;
                    
             data_features{index, 20} = ecdf_f_T_X1;
                    
             data_features{index, 21} = ecdf_x_T_X1;
                    
             data_features{index, 22} = I_T_X1;
                    
             index = index + 1;
        end
    end
end