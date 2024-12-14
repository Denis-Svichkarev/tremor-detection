% Extract camera features in timewindow
function data_features = extract_camera_features(data, time)
    index = 1;
    samples_per_sec = 30;
    timewindow_size = time * samples_per_sec;
    measurement_time = size(data, 1);
    
    data_features = cell(floor(measurement_time / timewindow_size), 136);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            
            % point 1
            
            [amplitudes_X1, frequencies_X1] = get_frequencies_spectrum(data.px1(j + 1:j + timewindow_size));
            [freq_X1, amp_X1, M_X1, S_X1, M2_X1, maxValue_X1, minValue_X1, ...
                        I_X1, Q_X1, SK_X1, K_X1, M_T_X1, S_T_X1, M2_T_X1, ...
                        maxValue_T_X1, minValue_T_X1, ...
                        I_T_X1, Q_T_X1] = get_features(amplitudes_X1, frequencies_X1);

            [amplitudes_Y1, frequencies_Y1] = get_frequencies_spectrum(data.py1(j + 1:j + timewindow_size));
            [freq_Y1, amp_Y1, M_Y1, S_Y1, M2_Y1, maxValue_Y1, minValue_Y1, ...
                        I_Y1, Q_Y1, SK_Y1, K_Y1, M_T_Y1, S_T_Y1, M2_T_Y1, ...
                        maxValue_T_Y1, minValue_T_Y1, ...
                        I_T_Y1, Q_T_Y1] = get_features(amplitudes_Y1, frequencies_Y1);
                    
            % point 2
                   
            [amplitudes_X2, frequencies_X2] = get_frequencies_spectrum(data.px2(j + 1:j + timewindow_size));
            [freq_X2, amp_X2, M_X2, S_X2, M2_X2, maxValue_X2, minValue_X2, ...
                        I_X2, Q_X2, SK_X2, K_X2, M_T_X2, S_T_X2, M2_T_X2, ...
                        maxValue_T_X2, minValue_T_X2, ...
                        I_T_X2, Q_T_X2] = get_features(amplitudes_X2, frequencies_X2);

            [amplitudes_Y2, frequencies_Y2] = get_frequencies_spectrum(data.py2(j + 1:j + timewindow_size));
            [freq_Y2, amp_Y2, M_Y2, S_Y2, M2_Y2, maxValue_Y2, minValue_Y2, ...
                        I_Y2, Q_Y2, SK_Y2, K_Y2, M_T_Y2, S_T_Y2, M2_T_Y2, ...
                        maxValue_T_Y2, minValue_T_Y2, ...
                        I_T_Y2, Q_T_Y2] = get_features(amplitudes_Y2, frequencies_Y2);

            % point 3
            
            [amplitudes_X3, frequencies_X3] = get_frequencies_spectrum(data.px3(j + 1:j + timewindow_size));
            [freq_X3, amp_X3, M_X3, S_X3, M2_X3, maxValue_X3, minValue_X3, ...
                        I_X3, Q_X3, SK_X3, K_X3, M_T_X3, S_T_X3, M2_T_X3, ...
                        maxValue_T_X3, minValue_T_X3, ...
                        I_T_X3, Q_T_X3] = get_features(amplitudes_X3, frequencies_X3);

            [amplitudes_Y3, frequencies_Y3] = get_frequencies_spectrum(data.py3(j + 1:j + timewindow_size));
            [freq_Y3, amp_Y3, M_Y3, S_Y3, M2_Y3, maxValue_Y3, minValue_Y3, ...
                        I_Y3, Q_Y3, SK_Y3, K_Y3, M_T_Y3, S_T_Y3, M2_T_Y3, ...
                        maxValue_T_Y3, minValue_T_Y3, ...
                        I_T_Y3, Q_T_Y3] = get_features(amplitudes_Y3, frequencies_Y3);
                    
             % point 4
             
            [amplitudes_X4, frequencies_X4] = get_frequencies_spectrum(data.px4(j + 1:j + timewindow_size));
            [freq_X4, amp_X4, M_X4, S_X4, M2_X4, maxValue_X4, minValue_X4, ...
                        I_X4, Q_X4, SK_X4, K_X4, M_T_X4, S_T_X4, M2_T_X4, ...
                        maxValue_T_X4, minValue_T_X4, ...
                        I_T_X4, Q_T_X4] = get_features(amplitudes_X4, frequencies_X4);

            [amplitudes_Y4, frequencies_Y4] = get_frequencies_spectrum(data.py4(j + 1:j + timewindow_size));
            [freq_Y4, amp_Y4, M_Y4, S_Y4, M2_Y4, maxValue_Y4, minValue_Y4, ...
                        I_Y4, Q_Y4, SK_Y4, K_Y4, M_T_Y4, S_T_Y4, M2_T_Y4, ...
                        maxValue_T_Y4, minValue_T_Y4, ...
                        I_T_Y4, Q_T_Y4] = get_features(amplitudes_Y4, frequencies_Y4);
             

             % Frequency domain features
            
             data_features{index, 1} = amp_X1;
             data_features{index, 2} = amp_X2;
             data_features{index, 3} = amp_X3;
             data_features{index, 4} = amp_X4;
             data_features{index, 5} = amp_Y1;
             data_features{index, 6} = amp_Y2;
             data_features{index, 7} = amp_Y3;
             data_features{index, 8} = amp_Y4;
                    
             data_features{index, 9} = M_X1;
             data_features{index, 10} = M_X2;
             data_features{index, 11} = M_X3;
             data_features{index, 12} = M_X4;
             data_features{index, 13} = M_Y1;
             data_features{index, 14} = M_Y2;
             data_features{index, 15} = M_Y3;
             data_features{index, 16} = M_Y4;
                    
             data_features{index, 17} = S_X1;
             data_features{index, 18} = S_X2;
             data_features{index, 19} = S_X3;
             data_features{index, 20} = S_X4;
             data_features{index, 21} = S_Y1;
             data_features{index, 22} = S_Y2;
             data_features{index, 23} = S_Y3;
             data_features{index, 24} = S_Y4;
                    
             data_features{index, 25} = M2_X1;
             data_features{index, 26} = M2_X2;
             data_features{index, 27} = M2_X3;
             data_features{index, 28} = M2_X4;
             data_features{index, 29} = M2_Y1;
             data_features{index, 30} = M2_Y2;
             data_features{index, 31} = M2_Y3;
             data_features{index, 32} = M2_Y4;
                    
             data_features{index, 33} = maxValue_X1;
             data_features{index, 34} = maxValue_X2;
             data_features{index, 35} = maxValue_X3;
             data_features{index, 36} = maxValue_X4;
             data_features{index, 37} = maxValue_Y1;
             data_features{index, 38} = maxValue_Y2;
             data_features{index, 39} = maxValue_Y3;
             data_features{index, 40} = maxValue_Y4;
                    
             data_features{index, 41} = minValue_X1;
             data_features{index, 42} = minValue_X2;
             data_features{index, 43} = minValue_X3;
             data_features{index, 44} = minValue_X4;
             data_features{index, 45} = minValue_Y1;
             data_features{index, 46} = minValue_Y2;
             data_features{index, 47} = minValue_Y3;
             data_features{index, 48} = minValue_Y4;
                     
             data_features{index, 49} = I_X1;
             data_features{index, 50} = I_X2;
             data_features{index, 51} = I_X3;
             data_features{index, 52} = I_X4;
             data_features{index, 53} = I_Y1;
             data_features{index, 54} = I_Y2;
             data_features{index, 55} = I_Y3;
             data_features{index, 56} = I_Y4;
                    
             data_features{index, 57} = Q_X1;
             data_features{index, 58} = Q_X2;
             data_features{index, 59} = Q_X3;
             data_features{index, 60} = Q_X4;
             data_features{index, 61} = Q_Y1;
             data_features{index, 62} = Q_Y2;
             data_features{index, 63} = Q_Y3;
             data_features{index, 64} = Q_Y4;
                    
             data_features{index, 65} = SK_X1;
             data_features{index, 66} = SK_X2;
             data_features{index, 67} = SK_X3;
             data_features{index, 68} = SK_X4;
             data_features{index, 69} = SK_Y1;
             data_features{index, 70} = SK_Y2;
             data_features{index, 71} = SK_Y3;
             data_features{index, 72} = SK_Y4;
                    
             data_features{index, 73} = K_X1;
             data_features{index, 74} = K_X2;
             data_features{index, 75} = K_X3;
             data_features{index, 76} = K_X4;
             data_features{index, 77} = K_Y1;
             data_features{index, 78} = K_Y2;
             data_features{index, 79} = K_Y3;
             data_features{index, 80} = K_Y4;
                     
             % Time domain features
                    
             data_features{index, 81} = Q_T_X1;
             data_features{index, 82} = Q_T_X2;
             data_features{index, 83} = Q_T_X3;
             data_features{index, 84} = Q_T_X4;
             data_features{index, 85} = Q_T_Y1;
             data_features{index, 86} = Q_T_Y2;
             data_features{index, 87} = Q_T_Y3;
             data_features{index, 88} = Q_T_Y4;
             
             data_features{index, 89} = M_T_X1;
             data_features{index, 90} = M_T_X2;
             data_features{index, 91} = M_T_X3;
             data_features{index, 92} = M_T_X4;
             data_features{index, 93} = M_T_Y1;
             data_features{index, 94} = M_T_Y2;
             data_features{index, 95} = M_T_Y3;
             data_features{index, 96} = M_T_Y4;
             
             data_features{index, 97} = S_T_X1;
             data_features{index, 98} = S_T_X2;
             data_features{index, 99} = S_T_X3;
             data_features{index, 100} = S_T_X4;
             data_features{index, 101} = S_T_Y1;
             data_features{index, 102} = S_T_Y2;
             data_features{index, 103} = S_T_Y3;
             data_features{index, 104} = S_T_Y4;
                    
             data_features{index, 105} = M2_T_X1;
             data_features{index, 106} = M2_T_X2;
             data_features{index, 107} = M2_T_X3;
             data_features{index, 108} = M2_T_X4;
             data_features{index, 109} = M2_T_Y1;
             data_features{index, 110} = M2_T_Y2;
             data_features{index, 111} = M2_T_Y3;
             data_features{index, 112} = M2_T_Y4;
             
             data_features{index, 113} = maxValue_T_X1;
             data_features{index, 114} = maxValue_T_X2;
             data_features{index, 115} = maxValue_T_X3;
             data_features{index, 116} = maxValue_T_X4;
             data_features{index, 117} = maxValue_T_Y1;
             data_features{index, 118} = maxValue_T_Y2;
             data_features{index, 119} = maxValue_T_Y3;
             data_features{index, 120} = maxValue_T_Y4;
             
             data_features{index, 121} = minValue_T_X1;
             data_features{index, 122} = minValue_T_X2;
             data_features{index, 123} = minValue_T_X3;
             data_features{index, 124} = minValue_T_X4;
             data_features{index, 125} = minValue_T_Y1;
             data_features{index, 126} = minValue_T_Y2;
             data_features{index, 127} = minValue_T_Y3;
             data_features{index, 128} = minValue_T_Y4;
                    
             data_features{index, 129} = I_T_X1;
             data_features{index, 130} = I_T_X2;
             data_features{index, 131} = I_T_X3;
             data_features{index, 132} = I_T_X4;
             data_features{index, 133} = I_T_Y1;
             data_features{index, 134} = I_T_Y2;
             data_features{index, 135} = I_T_Y3;
             data_features{index, 136} = I_T_Y4;
                    
             index = index + 1;
        end
    end
end