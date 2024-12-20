% Extract features in timewindow
function data_features = extractAccFeatures(data, time)
    index = 1;
    
    timewindow_size = time * 100;
    measurement_time = size(data, 1);
    data_features = cell(floor(measurement_time / timewindow_size), 54);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            [amplitudes_X, frequencies_X] = get_frequencies_spectrum(data.x(j + 1:j + timewindow_size));
            [freq_X, amp_X, M_X, S_X, M2_X, maxValue_X, minValue_X, ...
                I_X, Q_X, SK_X, K_X, M_T_X, S_T_X, M2_T_X, ...
                    maxValue_T_X, minValue_T_X, ...
                        I_T_X, Q_T_X] = get_features(amplitudes_X, frequencies_X);

            [amplitudes_Y, frequencies_Y] = get_frequencies_spectrum(data.y(j + 1:j + timewindow_size));
            [freq_Y, amp_Y, M_Y, S_Y, M2_Y, maxValue_Y, minValue_Y, ...
                I_Y, Q_Y, SK_Y, K_Y, M_T_Y, S_T_Y, M2_T_Y, ...
                    maxValue_T_Y, minValue_T_Y, ...
                        I_T_Y, Q_T_Y] = get_features(amplitudes_Y, frequencies_Y);

            [amplitudes_Z, frequencies_Z] = get_frequencies_spectrum(data.z(j + 1:j + timewindow_size));
            [freq_Z, amp_Z, M_Z, S_Z, M2_Z, maxValue_Z, minValue_Z, ...
                I_Z, Q_Z, SK_Z, K_Z, M_T_Z, S_T_Z, M2_T_Z, ...
                    maxValue_T_Z, minValue_T_Z, ...
                        I_T_Z, Q_T_Z] = get_features(amplitudes_Z, frequencies_Z);

             % Frequency domain features
                    
             data_features{index, 1} = amp_X;
             data_features{index, 2} = amp_Y;
             data_features{index, 3} = amp_Z;
                    
             data_features{index, 4} = M_X;
             data_features{index, 5} = M_Y;
             data_features{index, 6} = M_Z;
                    
             data_features{index, 7} = S_X;
             data_features{index, 8} = S_Y;
             data_features{index, 9} = S_Z;
                    
             data_features{index, 10} = M2_X;
             data_features{index, 11} = M2_Y;
             data_features{index, 12} = M2_Z;
                    
             data_features{index, 13} = maxValue_X;
             data_features{index, 14} = maxValue_Y;
             data_features{index, 15} = maxValue_Z;
                    
             data_features{index, 16} = minValue_X;
             data_features{index, 17} = minValue_Y;
             data_features{index, 18} = minValue_Z;

             data_features{index, 19} = I_X;
             data_features{index, 20} = I_Y;
             data_features{index, 21} = I_Z;
                    
             data_features{index, 22} = Q_X;
             data_features{index, 23} = Q_Y;
             data_features{index, 24} = Q_Z;
                    
             data_features{index, 25} = SK_X;
             data_features{index, 26} = SK_Y;
             data_features{index, 27} = SK_Z;
                    
             data_features{index, 28} = K_X;
             data_features{index, 29} = K_Y;
             data_features{index, 30} = K_Z;
                    
             % Time domain features
                    
             data_features{index, 31} = M_T_X;
             data_features{index, 32} = M_T_Y;
             data_features{index, 33} = M_T_Z;
                    
             data_features{index, 34} = S_T_X;
             data_features{index, 35} = S_T_Y;
             data_features{index, 36} = S_T_Z;
                    
             data_features{index, 37} = M2_T_X;
             data_features{index, 38} = M2_T_Y;
             data_features{index, 39} = M2_T_Z;
                    
             data_features{index, 40} = maxValue_T_X;
             data_features{index, 41} = maxValue_T_Y;
             data_features{index, 42} = maxValue_T_Z;
                    
             data_features{index, 43} = minValue_T_X;
             data_features{index, 44} = minValue_T_Y;
             data_features{index, 45} = minValue_T_Z;
                    
             data_features{index, 46} = I_T_X;
             data_features{index, 47} = I_T_Y;
             data_features{index, 48} = I_T_Z;
                    
             data_features{index, 49} = Q_T_X;
             data_features{index, 50} = Q_T_Y;
             data_features{index, 51} = Q_T_Z;
                    
             index = index + 1;
        end
    end
end