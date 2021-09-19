% Extract camera features in timewindow
function data_features = extract_camera_features(data, time)
    index = 1;
    samples_per_sec = 30;
    timewindow_size = time * samples_per_sec;

    measurement_time = data.timestamp(end);
    data_features = cell(round(measurement_time), 4);
     
    for j = 0:timewindow_size:measurement_time
        if j + timewindow_size <= measurement_time
            
            % point 1
            
            [amplitudes_X1, frequencies_X1] = get_frequencies_spectrum(data.px1(j + 1:j + timewindow_size));
            [freq_X1, amp_X1, M_X1, S_X1, M2_X1, maxValue_X1, minValue_X1, ...
                        ecdf_f_X1, ecdf_x_X1, I_X1, Q_X1, SK_X1, K_X1, M_T_X1, S_T_X1, M2_T_X1, ...
                        maxValue_T_X1, minValue_T_X1, ecdf_f_T_X1, ...
                        ecdf_x_T_X1, I_T_X1, Q_T_X1] = get_features(amplitudes_X1, frequencies_X1);

            [amplitudes_Y1, frequencies_Y1] = get_frequencies_spectrum(data.py1(j + 1:j + timewindow_size));
            [freq_Y1, amp_Y1, M_Y1, S_Y1, M2_Y1, maxValue_Y1, minValue_Y1, ...
                        ecdf_f_Y1, ecdf_x_Y1, I_Y1, Q_Y1, SK_Y1, K_Y1, M_T_Y1, S_T_Y1, M2_T_Y1, ...
                        maxValue_T_Y1, minValue_T_Y1, ecdf_f_T_Y1, ...
                        ecdf_x_T_Y1, I_T_Y1, Q_T_Y1] = get_features(amplitudes_Y1, frequencies_Y1);
                    
            % point 2
                   
            [amplitudes_X2, frequencies_X2] = get_frequencies_spectrum(data.px2(j + 1:j + timewindow_size));
            [freq_X2, amp_X2, M_X2, S_X2, M2_X2, maxValue_X2, minValue_X2, ...
                        ecdf_f_X2, ecdf_x_X2, I_X2, Q_X2, SK_X2, K_X2, M_T_X2, S_T_X2, M2_T_X2, ...
                        maxValue_T_X2, minValue_T_X2, ecdf_f_T_X2, ...
                        ecdf_x_T_X2, I_T_X2, Q_T_X2] = get_features(amplitudes_X2, frequencies_X2);

            [amplitudes_Y2, frequencies_Y2] = get_frequencies_spectrum(data.py2(j + 1:j + timewindow_size));
            [freq_Y2, amp_Y2, M_Y2, S_Y2, M2_Y2, maxValue_Y2, minValue_Y2, ...
                        ecdf_f_Y2, ecdf_x_Y2, I_Y2, Q_Y2, SK_Y2, K_Y2, M_T_Y2, S_T_Y2, M2_T_Y2, ...
                        maxValue_T_Y2, minValue_T_Y2, ecdf_f_T_Y2, ...
                        ecdf_x_T_Y2, I_T_Y2, Q_T_Y2] = get_features(amplitudes_Y2, frequencies_Y2);

            % point 3
            
            [amplitudes_X3, frequencies_X3] = get_frequencies_spectrum(data.px3(j + 1:j + timewindow_size));
            [freq_X3, amp_X3, M_X3, S_X3, M2_X3, maxValue_X3, minValue_X3, ...
                        ecdf_f_X3, ecdf_x_X3, I_X3, Q_X3, SK_X3, K_X3, M_T_X3, S_T_X3, M2_T_X3, ...
                        maxValue_T_X3, minValue_T_X3, ecdf_f_T_X3, ...
                        ecdf_x_T_X3, I_T_X3, Q_T_X3] = get_features(amplitudes_X3, frequencies_X3);

            [amplitudes_Y3, frequencies_Y3] = get_frequencies_spectrum(data.py3(j + 1:j + timewindow_size));
            [freq_Y3, amp_Y3, M_Y3, S_Y3, M2_Y3, maxValue_Y3, minValue_Y3, ...
                        ecdf_f_Y3, ecdf_x_Y3, I_Y3, Q_Y3, SK_Y3, K_Y3, M_T_Y3, S_T_Y3, M2_T_Y3, ...
                        maxValue_T_Y3, minValue_T_Y3, ecdf_f_T_Y3, ...
                        ecdf_x_T_Y3, I_T_Y3, Q_T_Y3] = get_features(amplitudes_Y3, frequencies_Y3);
                    
             % point 4
             
            [amplitudes_X4, frequencies_X4] = get_frequencies_spectrum(data.px4(j + 1:j + timewindow_size));
            [freq_X4, amp_X4, M_X4, S_X4, M2_X4, maxValue_X4, minValue_X4, ...
                        ecdf_f_X4, ecdf_x_X4, I_X4, Q_X4, SK_X4, K_X4, M_T_X4, S_T_X4, M2_T_X4, ...
                        maxValue_T_X4, minValue_T_X4, ecdf_f_T_X4, ...
                        ecdf_x_T_X4, I_T_X4, Q_T_X4] = get_features(amplitudes_X4, frequencies_X4);

            [amplitudes_Y4, frequencies_Y4] = get_frequencies_spectrum(data.py4(j + 1:j + timewindow_size));
            [freq_Y4, amp_Y4, M_Y4, S_Y4, M2_Y4, maxValue_Y4, minValue_Y4, ...
                        ecdf_f_Y4, ecdf_x_Y4, I_Y4, Q_Y4, SK_Y4, K_Y4, M_T_Y4, S_T_Y4, M2_T_Y4, ...
                        maxValue_T_Y4, minValue_T_Y4, ecdf_f_T_Y4, ...
                        ecdf_x_T_Y4, I_T_Y4, Q_T_Y4] = get_features(amplitudes_Y4, frequencies_Y4);
             

             % Frequency domain features
                    
             data_features{index, 1} = freq_X1;
             data_features{index, 2} = freq_X2;
             data_features{index, 3} = freq_X3;
             data_features{index, 4} = freq_X4;
             data_features{index, 5} = freq_Y1;
             data_features{index, 6} = freq_Y2;
             data_features{index, 7} = freq_Y3;
             data_features{index, 8} = freq_Y4;
                    
             data_features{index, 9} = amp_X1;
             data_features{index, 10} = amp_X2;
             data_features{index, 11} = amp_X3;
             data_features{index, 12} = amp_X4;
             data_features{index, 13} = amp_Y1;
             data_features{index, 14} = amp_Y2;
             data_features{index, 15} = amp_Y3;
             data_features{index, 16} = amp_Y4;
                    
             data_features{index, 17} = M_X1;
             data_features{index, 18} = M_X2;
             data_features{index, 19} = M_X3;
             data_features{index, 20} = M_X4;
             data_features{index, 21} = M_Y1;
             data_features{index, 22} = M_Y2;
             data_features{index, 23} = M_Y3;
             data_features{index, 24} = M_Y4;
                    
             data_features{index, 25} = S_X1;
             data_features{index, 26} = S_X2;
             data_features{index, 27} = S_X3;
             data_features{index, 28} = S_X4;
             data_features{index, 29} = S_Y1;
             data_features{index, 30} = S_Y2;
             data_features{index, 31} = S_Y3;
             data_features{index, 32} = S_Y4;
                    
             data_features{index, 33} = M2_X1;
             data_features{index, 34} = M2_X2;
             data_features{index, 35} = M2_X3;
             data_features{index, 36} = M2_X4;
             data_features{index, 37} = M2_Y1;
             data_features{index, 38} = M2_Y2;
             data_features{index, 39} = M2_Y3;
             data_features{index, 40} = M2_Y4;
                    
             data_features{index, 41} = maxValue_X1;
             data_features{index, 42} = maxValue_X2;
             data_features{index, 43} = maxValue_X3;
             data_features{index, 44} = maxValue_X4;
             data_features{index, 45} = maxValue_Y1;
             data_features{index, 46} = maxValue_Y2;
             data_features{index, 47} = maxValue_Y3;
             data_features{index, 48} = maxValue_Y4;
                    
             data_features{index, 49} = minValue_X1;
             data_features{index, 50} = minValue_X2;
             data_features{index, 51} = minValue_X3;
             data_features{index, 52} = minValue_X4;
             data_features{index, 53} = minValue_Y1;
             data_features{index, 54} = minValue_Y2;
             data_features{index, 55} = minValue_Y3;
             data_features{index, 56} = minValue_Y4;
             
             data_features{index, 57} = ecdf_f_X1;
             data_features{index, 58} = ecdf_f_X2;
             data_features{index, 59} = ecdf_f_X3;
             data_features{index, 60} = ecdf_f_X4;
             data_features{index, 61} = ecdf_f_Y1;
             data_features{index, 62} = ecdf_f_Y2;
             data_features{index, 63} = ecdf_f_Y3;
             data_features{index, 64} = ecdf_f_Y4;
 
             data_features{index, 65} = ecdf_x_X1;
             data_features{index, 66} = ecdf_x_X2;
             data_features{index, 67} = ecdf_x_X3;
             data_features{index, 68} = ecdf_x_X4;
             data_features{index, 69} = ecdf_x_Y1;
             data_features{index, 70} = ecdf_x_Y2;
             data_features{index, 71} = ecdf_x_Y3;
             data_features{index, 72} = ecdf_x_Y4;
                    
             data_features{index, 73} = I_X1;
             data_features{index, 74} = I_X2;
             data_features{index, 75} = I_X3;
             data_features{index, 76} = I_X4;
             data_features{index, 77} = I_Y1;
             data_features{index, 78} = I_Y2;
             data_features{index, 79} = I_Y3;
             data_features{index, 80} = I_Y4;
                    
             data_features{index, 81} = Q_X1;
             data_features{index, 82} = Q_X2;
             data_features{index, 83} = Q_X3;
             data_features{index, 84} = Q_X4;
             data_features{index, 85} = Q_Y1;
             data_features{index, 86} = Q_Y2;
             data_features{index, 87} = Q_Y3;
             data_features{index, 88} = Q_Y4;
                    
             data_features{index, 89} = SK_X1;
             data_features{index, 90} = SK_X2;
             data_features{index, 91} = SK_X3;
             data_features{index, 92} = SK_X4;
             data_features{index, 93} = SK_Y1;
             data_features{index, 94} = SK_Y2;
             data_features{index, 95} = SK_Y3;
             data_features{index, 96} = SK_Y4;
                    
             data_features{index, 97} = K_X1;
             data_features{index, 98} = K_X2;
             data_features{index, 99} = K_X3;
             data_features{index, 100} = K_X4;
             data_features{index, 101} = K_Y1;
             data_features{index, 102} = K_Y2;
             data_features{index, 103} = K_Y3;
             data_features{index, 104} = K_Y4;
                     
             % Time domain features
                    
             data_features{index, 105} = Q_T_X1;
             data_features{index, 106} = Q_T_X2;
             data_features{index, 107} = Q_T_X3;
             data_features{index, 108} = Q_T_X4;
             data_features{index, 109} = Q_T_Y1;
             data_features{index, 110} = Q_T_Y2;
             data_features{index, 111} = Q_T_Y3;
             data_features{index, 112} = Q_T_Y4;
             
             data_features{index, 113} = M_T_X1;
             data_features{index, 114} = M_T_X2;
             data_features{index, 115} = M_T_X3;
             data_features{index, 116} = M_T_X4;
             data_features{index, 117} = M_T_Y1;
             data_features{index, 118} = M_T_Y2;
             data_features{index, 119} = M_T_Y3;
             data_features{index, 120} = M_T_Y4;
             
             data_features{index, 121} = S_T_X1;
             data_features{index, 122} = S_T_X2;
             data_features{index, 123} = S_T_X3;
             data_features{index, 124} = S_T_X4;
             data_features{index, 125} = S_T_Y1;
             data_features{index, 126} = S_T_Y2;
             data_features{index, 127} = S_T_Y3;
             data_features{index, 128} = S_T_Y4;
                    
             data_features{index, 129} = M2_T_X1;
             data_features{index, 130} = M2_T_X2;
             data_features{index, 131} = M2_T_X3;
             data_features{index, 132} = M2_T_X4;
             data_features{index, 133} = M2_T_Y1;
             data_features{index, 134} = M2_T_Y2;
             data_features{index, 135} = M2_T_Y3;
             data_features{index, 136} = M2_T_Y4;
             
             data_features{index, 137} = maxValue_T_X1;
             data_features{index, 138} = maxValue_T_X2;
             data_features{index, 139} = maxValue_T_X3;
             data_features{index, 140} = maxValue_T_X4;
             data_features{index, 141} = maxValue_T_Y1;
             data_features{index, 142} = maxValue_T_Y2;
             data_features{index, 143} = maxValue_T_Y3;
             data_features{index, 144} = maxValue_T_Y4;
             
             data_features{index, 145} = minValue_T_X1;
             data_features{index, 146} = minValue_T_X2;
             data_features{index, 147} = minValue_T_X3;
             data_features{index, 148} = minValue_T_X4;
             data_features{index, 149} = minValue_T_Y1;
             data_features{index, 150} = minValue_T_Y2;
             data_features{index, 151} = minValue_T_Y3;
             data_features{index, 152} = minValue_T_Y4;
                    
             data_features{index, 153} = ecdf_f_T_X1;
             data_features{index, 154} = ecdf_f_T_X2;
             data_features{index, 155} = ecdf_f_T_X3;
             data_features{index, 156} = ecdf_f_T_X4;
             data_features{index, 157} = ecdf_f_T_Y1;
             data_features{index, 158} = ecdf_f_T_Y2;
             data_features{index, 159} = ecdf_f_T_Y3;
             data_features{index, 160} = ecdf_f_T_Y4;
                    
             data_features{index, 161} = ecdf_x_T_X1;
             data_features{index, 162} = ecdf_x_T_X2;
             data_features{index, 163} = ecdf_x_T_X3;
             data_features{index, 164} = ecdf_x_T_X4;
             data_features{index, 165} = ecdf_x_T_Y1;
             data_features{index, 166} = ecdf_x_T_Y2;
             data_features{index, 167} = ecdf_x_T_Y3;
             data_features{index, 168} = ecdf_x_T_Y4;
                    
             data_features{index, 169} = I_T_X1;
             data_features{index, 170} = I_T_X2;
             data_features{index, 171} = I_T_X3;
             data_features{index, 172} = I_T_X4;
             data_features{index, 173} = I_T_Y1;
             data_features{index, 174} = I_T_Y2;
             data_features{index, 175} = I_T_Y3;
             data_features{index, 176} = I_T_Y4;
                    
             index = index + 1;
        end
    end
end