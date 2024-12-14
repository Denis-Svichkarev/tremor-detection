% Extract features in timewindow
function data_features = extract_acc_features(data, timewindow_size)
    index = 1;
    
    measurement_time = size(data, 1);
    data_features = cell(floor(measurement_time / timewindow_size), 3);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            [amplitudes_X, frequencies_X] = get_frequencies_spectrum(data.x(j + 1:j + timewindow_size));
            [freq_X, amp_X, M_X, S_X, M2_X, maxValue_X, minValue_X, ...
                ecdf_f_X, ecdf_x_X, I_X, Q_X, SK_X, K_X, M_T_X, S_T_X, M2_T_X, ...
                    maxValue_T_X, minValue_T_X, ecdf_f_T_X, ...
                        ecdf_x_T_X, I_T_X, Q_T_X] = get_features(amplitudes_X, frequencies_X);

            [amplitudes_Y, frequencies_Y] = get_frequencies_spectrum(data.y(j + 1:j + timewindow_size));
            [freq_Y, amp_Y, M_Y, S_Y, M2_Y, maxValue_Y, minValue_Y, ...
                ecdf_f_Y, ecdf_x_Y, I_Y, Q_Y, SK_Y, K_Y, M_T_Y, S_T_Y, M2_T_Y, ...
                    maxValue_T_Y, minValue_T_Y, ecdf_f_T_Y, ...
                        ecdf_x_T_Y, I_T_Y, Q_T_Y] = get_features(amplitudes_Y, frequencies_Y);

            [amplitudes_Z, frequencies_Z] = get_frequencies_spectrum(data.z(j + 1:j + timewindow_size));
            [freq_Z, amp_Z, M_Z, S_Z, M2_Z, maxValue_Z, minValue_Z, ...
                ecdf_f_Z, ecdf_x_Z, I_Z, Q_Z, SK_Z, K_Z, M_T_Z, S_T_Z, M2_T_Z, ...
                    maxValue_T_Z, minValue_T_Z, ecdf_f_T_Z, ...
                        ecdf_x_T_Z, I_T_Z, Q_T_Z] = get_features(amplitudes_Z, frequencies_Z);

             % Frequency domain features
                    
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
                    
             data_features{index, 22} = ecdf_f_X;
             data_features{index, 23} = ecdf_f_Y;
             data_features{index, 24} = ecdf_f_Z;
 
             data_features{index, 25} = ecdf_x_X;
             data_features{index, 26} = ecdf_x_Y;
             data_features{index, 27} = ecdf_x_Z;
                    
             data_features{index, 28} = I_X;
             data_features{index, 29} = I_Y;
             data_features{index, 30} = I_Z;
                    
             data_features{index, 31} = Q_X;
             data_features{index, 32} = Q_Y;
             data_features{index, 33} = Q_Z;
                    
             data_features{index, 34} = SK_X;
             data_features{index, 35} = SK_Y;
             data_features{index, 36} = SK_Z;
                    
             data_features{index, 37} = K_X;
             data_features{index, 38} = K_Y;
             data_features{index, 39} = K_Z;
                    
             % Time domain features
                    
             data_features{index, 40} = M_T_X;
             data_features{index, 41} = M_T_Y;
             data_features{index, 42} = M_T_Z;
                    
             data_features{index, 43} = S_T_X;
             data_features{index, 44} = S_T_Y;
             data_features{index, 45} = S_T_Z;
                    
             data_features{index, 46} = M2_T_X;
             data_features{index, 47} = M2_T_Y;
             data_features{index, 48} = M2_T_Z;
                    
             data_features{index, 49} = maxValue_T_X;
             data_features{index, 50} = maxValue_T_Y;
             data_features{index, 51} = maxValue_T_Z;
                    
             data_features{index, 52} = minValue_T_X;
             data_features{index, 53} = minValue_T_Y;
             data_features{index, 54} = minValue_T_Z;
                    
             data_features{index, 55} = ecdf_f_T_X;
             data_features{index, 56} = ecdf_f_T_Y;
             data_features{index, 57} = ecdf_f_T_Z;
                    
             data_features{index, 58} = ecdf_x_T_X;
             data_features{index, 59} = ecdf_x_T_Y;
             data_features{index, 60} = ecdf_x_T_Z;
                    
             data_features{index, 61} = I_T_X;
             data_features{index, 62} = I_T_Y;
             data_features{index, 63} = I_T_Z;
                    
             data_features{index, 64} = Q_T_X;
             data_features{index, 65} = Q_T_Y;
             data_features{index, 66} = Q_T_Z;
                    
             index = index + 1;
        end
    end
end