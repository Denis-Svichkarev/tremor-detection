% Extract features from raw data
function [data_features] = extract_features_from_raw_data(data, sample_number)
     [amplitudes_X, frequencies_X] = get_frequencies_spectrum(data(1:sample_number));
     [freq_X, amp_X, M_X, S_X, M2_X, maxValue_X, minValue_X, ...
                        I_X, Q_X, SK_X, K_X, M_T_X, S_T_X, M2_T_X, ...
                        maxValue_T_X, minValue_T_X, ...
                        I_T_X, Q_T_X] = get_features(amplitudes_X, frequencies_X);

     [amplitudes_Y, frequencies_Y] = get_frequencies_spectrum(data(sample_number+1:sample_number*2));
     [freq_Y, amp_Y, M_Y, S_Y, M2_Y, maxValue_Y, minValue_Y, ...
                        I_Y, Q_Y, SK_Y, K_Y, M_T_Y, S_T_Y, M2_T_Y, ...
                        maxValue_T_Y, minValue_T_Y, ...
                        I_T_Y, Q_T_Y] = get_features(amplitudes_Y, frequencies_Y);

     [amplitudes_Z, frequencies_Z] = get_frequencies_spectrum(data(sample_number*2+1:sample_number*3));
     [freq_Z, amp_Z, M_Z, S_Z, M2_Z, maxValue_Z, minValue_Z, ...
                        I_Z, Q_Z, SK_Z, K_Z, M_T_Z, S_T_Z, M2_T_Z, ...
                        maxValue_T_Z, minValue_T_Z, ...
                        I_T_Z, Q_T_Z] = get_features(amplitudes_Z, frequencies_Z);
                    
     data_features = [];
     
     for i = 1:size(amp_X, 2)
        data_features = [data_features, amp_X(i)];
     end
     
     for i = 1:size(amp_Y, 2)
        data_features = [data_features, amp_Y(i)];
     end
     
     for i = 1:size(amp_Z, 2)
        data_features = [data_features, amp_Z(i)];
     end
     
     data_features = [data_features, M_X];
     data_features = [data_features, M_Y];
     data_features = [data_features, M_Z];
            
     data_features = [data_features S_X];
     data_features = [data_features S_Y];
     data_features = [data_features S_Z];
                     
     data_features = [data_features M2_X];
     data_features = [data_features M2_Y];
     data_features = [data_features M2_Z];             
end