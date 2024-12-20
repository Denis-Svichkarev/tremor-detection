function table = createTableFromCameraFeatures(dataFeatures, class)
    columns = {
        'AMP_X_1_1', 'AMP_X_1_2', 'AMP_X_1_3', 'AMP_X_1_4', ...
        'AMP_X_2_1', 'AMP_X_2_2', 'AMP_X_2_3', 'AMP_X_2_4', ...
        'AMP_X_3_1', 'AMP_X_3_2', 'AMP_X_3_3', 'AMP_X_3_4', ...
        'AMP_X_4_1', 'AMP_X_4_2', 'AMP_X_4_3', 'AMP_X_4_4', ...
        'AMP_Y_1_1', 'AMP_Y_1_2', 'AMP_Y_1_3', 'AMP_Y_1_4', ...
        'AMP_Y_2_1', 'AMP_Y_2_2', 'AMP_Y_2_3', 'AMP_Y_2_4', ...
        'AMP_Y_3_1', 'AMP_Y_3_2', 'AMP_Y_3_3', 'AMP_Y_3_4', ...
        'AMP_Y_4_1', 'AMP_Y_4_2', 'AMP_Y_4_3', 'AMP_Y_4_4', ...
        'M_X_1', 'M_X_2', 'M_X_3', 'M_X_4', 'M_Y_1', 'M_Y_2', 'M_Y_3', 'M_Y_4', ...
        'S_X_1', 'S_X_2', 'S_X_3', 'S_X_4', 'S_Y_1', 'S_Y_2', 'S_Y_3', 'S_Y_4', ...
        'M2_X_1', 'M2_X_2', 'M2_X_3', 'M2_X_4', 'M2_Y_1', 'M2_Y_2', 'M2_Y_3', 'M2_Y_4', ...
        'maxValue_X_1', 'maxValue_X_2', 'maxValue_X_3', 'maxValue_X_4', 'maxValue_Y_1', 'maxValue_Y_2', 'maxValue_Y_3', 'maxValue_Y_4', ...
        'minValue_X_1', 'minValue_X_2', 'minValue_X_3', 'minValue_X_4', 'minValue_Y_1', 'minValue_Y_2', 'minValue_Y_3', 'minValue_Y_4', ...
        'I_X_1', 'I_X_2', 'I_X_3', 'I_X_4', 'I_Y_1', 'I_Y_2', 'I_Y_3', 'I_Y_4', ...
        'Q_X_1', 'Q_X_2', 'Q_X_3', 'Q_X_4', 'Q_Y_1', 'Q_Y_2', 'Q_Y_3', 'Q_Y_4', ...
        'SK_X_1', 'SK_X_2', 'SK_X_3', 'SK_X_4', 'SK_Y_1', 'SK_Y_2', 'SK_Y_3', 'SK_Y_4', ...
        'K_X_1', 'K_X_2', 'K_X_3', 'K_X_4', 'K_Y_1', 'K_Y_2', 'K_Y_3', 'K_Y_4', ...
        'Q_T_X_1', 'Q_T_X_2', 'Q_T_X_3', 'Q_T_X_4', 'Q_T_Y_1', 'Q_T_Y_2', 'Q_T_Y_3', 'Q_T_Y_4', ...
        'M_T_X_1', 'M_T_X_2', 'M_T_X_3', 'M_T_X_4', 'M_T_Y_1', 'M_T_Y_2', 'M_T_Y_3', 'M_T_Y_4', ...
        'S_T_X_1', 'S_T_X_2', 'S_T_X_3', 'S_T_X_4', 'S_T_Y_1', 'S_T_Y_2', 'S_T_Y_3', 'S_T_Y_4', ...
        'M2_T_X_1', 'M2_T_X_2', 'M2_T_X_3', 'M2_T_X_4', 'M2_T_Y_1', 'M2_T_Y_2', 'M2_T_Y_3', 'M2_T_Y_4', ...
        'maxValue_T_X_1', 'maxValue_T_X_2', 'maxValue_T_X_3', 'maxValue_T_X_4', 'maxValue_T_Y_1', 'maxValue_T_Y_2', 'maxValue_T_Y_3', 'maxValue_T_Y_4', ...
        'minValue_T_X_1', 'minValue_T_X_2', 'minValue_T_X_3', 'minValue_T_X_4', 'minValue_T_Y_1', 'minValue_T_Y_2', 'minValue_T_Y_3', 'minValue_T_Y_4', ...
        'I_T_X_1', 'I_T_X_2', 'I_T_X_3', 'I_T_X_4', 'I_T_Y_1', 'I_T_Y_2', 'I_T_Y_3', 'I_T_Y_4', ...
        'AMP_SQ_1', 'AMP_SQ_2', 'AMP_SQ_3', 'AMP_SQ_4', ...
        'M_SQ', 'S_SQ', 'M2_SQ', 'maxValue_SQ', 'minValue_SQ', 'I_SQ', 'Q_SQ', 'SK_SQ', 'K_SQ', ...
        'Q_T_SQ', 'M_T_SQ', 'S_T_SQ', 'M2_T_SQ', 'maxValue_T_SQ', 'minValue_T_SQ', 'I_T_SQ', ...
        'CLASS'
    };
    
    allFeatures = {};
    
    for i = 1:size(dataFeatures, 1)
        features = {};
        
        for j = 1:8
            for z = 1:4
                features = [features dataFeatures{i, j}(z)];
            end
        end
        
        for j = 9:136
            features = [features dataFeatures{i, j}];
        end
        
        for j = 137:137
            for z = 1:4
                features = [features dataFeatures{i, j}(z)];
            end
        end
        
        for j = 138:153
            features = [features dataFeatures{i, j}];
        end
        
        features = [features class];
        allFeatures = [allFeatures; features];
    end
    
	table = array2table(allFeatures, 'VariableNames', columns);
end