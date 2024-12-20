function table = createTableFromFeatures(dataFeatures, class)
    columns = {
        'AMP_X_1', 'AMP_X_2', 'AMP_X_3', 'AMP_X_4', 'AMP_X_5', 'AMP_X_6', 'AMP_X_7', 'AMP_X_8', 'AMP_X_9', 'AMP_X_10', 'AMP_X_11', 'AMP_X_12', 'AMP_X_13', ...
        'AMP_Y_1', 'AMP_Y_2', 'AMP_Y_3', 'AMP_Y_4', 'AMP_Y_5', 'AMP_Y_6', 'AMP_Y_7', 'AMP_Y_8', 'AMP_Y_9', 'AMP_Y_10', 'AMP_Y_11', 'AMP_Y_12', 'AMP_Y_13', ...
        'AMP_Z_1', 'AMP_Z_2', 'AMP_Z_3', 'AMP_Z_4', 'AMP_Z_5', 'AMP_Z_6', 'AMP_Z_7', 'AMP_Z_8', 'AMP_Z_9', 'AMP_Z_10', 'AMP_Z_11', 'AMP_Z_12', 'AMP_Z_13', ...
        'M_X', 'M_Y', 'M_Z', 'S_X', 'S_Y', 'S_Z', 'M2_X', 'M2_Y', 'M2_Z', ...
        'maxValue_X', 'maxValue_Y', 'maxValue_Z', 'minValue_X', 'minValue_Y', 'minValue_Z', 'I_X', 'I_Y', 'I_Z', ...
        'Q_X', 'Q_Y', 'Q_Z', 'SK_X', 'SK_Y', 'SK_Z', 'K_X', 'K_Y', 'K_Z', ...
        'M_T_X', 'M_T_Y', 'M_T_Z', 'S_T_X', 'S_T_Y', 'S_T_Z', 'M2_T_X', 'M2_T_Y', 'M2_T_Z', ...
        'maxValue_T_X', 'maxValue_T_Y', 'maxValue_T_Z', 'minValue_T_X', 'minValue_T_Y', 'minValue_T_Z', 'I_T_X', 'I_T_Y', 'I_T_Z', ...
        'Q_T_X', 'Q_T_Y', 'Q_T_Z', ...
        'CLASS'
    };
    
    allFeatures = {};
    
    for i = 1:size(dataFeatures, 1)
        features = {};
        
        for j = 1:3
            for z = 1:13
                features = [features dataFeatures{i, j}(z)];
            end
        end
        
        for j = 4:51
            features = [features dataFeatures{i, j}];
        end
        
        features = [features class];
        allFeatures = [allFeatures; features];
    end
    
	table = array2table(allFeatures, 'VariableNames', columns);
end