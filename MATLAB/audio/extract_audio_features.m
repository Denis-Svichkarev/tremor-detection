% Extract audio features in timewindow
function data_features = extract_audio_features(data, fs, timewindow)
    index = 1;
    timewindow_size = timewindow * fs;

    data_features = cell(22, 1);
     
    for j = 0:timewindow_size:size(data, 2)
        if j + timewindow_size <= size(data, 2)
            
            [amplitudes_X1, frequencies_X1] = get_frequencies_audio_spectrum(data(j + 1:j + timewindow_size));
            [freq_X1, amp_X1, M_X1, S_X1, M2_X1, maxValue_X1, minValue_X1, ...
                        ecdf_f_X1, ecdf_x_X1, I_X1, Q_X1, SK_X1, K_X1, M_T_X1, S_T_X1, M2_T_X1, ...
                        maxValue_T_X1, minValue_T_X1, ecdf_f_T_X1, ...
                        ecdf_x_T_X1, I_T_X1, Q_T_X1] = get_audio_features(amplitudes_X1, frequencies_X1);
            
            % Frequency domain features

             data_features{1, index} = freq_X1;
                    
             data_features{2, index} = amp_X1;
                    
             data_features{3, index} = M_X1;
                    
             data_features{4, index} = S_X1;
                    
             data_features{5, index} = M2_X1;
                    
             data_features{6, index} = maxValue_X1;
                    
             data_features{7, index} = minValue_X1;
             
             data_features{8, index} = ecdf_f_X1;
 
             data_features{9, index} = ecdf_x_X1;
                    
             data_features{10, index} = I_X1;
                    
             data_features{11, index} = Q_X1;
                    
             data_features{12, index} = SK_X1;
                    
             data_features{13, index} = K_X1;
                     
             % Time domain features
                    
             data_features{14, index} = Q_T_X1;
             
             data_features{15, index} = M_T_X1;
             
             data_features{16, index} = S_T_X1;
             
             data_features{17, index} = M2_T_X1;
             
             data_features{18, index} = maxValue_T_X1;
             
             data_features{19, index} = minValue_T_X1;
                    
             data_features{20, index} = ecdf_f_T_X1;
                    
             data_features{21, index} = ecdf_x_T_X1;
                    
             data_features{22, index} = I_T_X1;
                    
             index = index + 1;
        end
    end
end