function table = fill_table_with_features(data_features, class)
    columns = {
        'FREQ_X_1', 'FREQ_X_2', 'FREQ_X_3', 'FREQ_X_4', 'FREQ_X_5', 'FREQ_X_6', 'FREQ_X_7', 'FREQ_X_8', 'FREQ_X_9', 'FREQ_X_10', 'FREQ_X_11', 'FREQ_X_12', 'FREQ_X_13', ...
        'FREQ_Y_1', 'FREQ_Y_2', 'FREQ_Y_3', 'FREQ_Y_4', 'FREQ_Y_5', 'FREQ_Y_6', 'FREQ_Y_7', 'FREQ_Y_8', 'FREQ_Y_9', 'FREQ_Y_10', 'FREQ_Y_11', 'FREQ_Y_12', 'FREQ_Y_13', ...
        'FREQ_Z_1', 'FREQ_Z_2', 'FREQ_Z_3', 'FREQ_Z_4', 'FREQ_Z_5', 'FREQ_Z_6', 'FREQ_Z_7', 'FREQ_Z_8', 'FREQ_Z_9', 'FREQ_Z_10', 'FREQ_Z_11', 'FREQ_Z_12', 'FREQ_Z_13', ...
        'M_X', 'M_Y', 'M_Z', 'S_X', 'S_Y', 'S_Z', 'M2_X', 'M2_Y', 'M2_Z', ...
        'CLASS'
    };

    min_feature = 7;
    max_feature = 15;
    
    table = [];

    for i = 1:size(data_features, 1)
        features = {};

        for j = 1:13
           features = [features data_features{i, 4}(j)];
        end

        for j = 1:13
           features = [features data_features{i, 5}(j)];
        end

        for j = 1:13
           features = [features data_features{i, 6}(j)];
        end

        for j = min_feature:max_feature
            features = [features data_features{i, j}];
        end

        features = [features class];
        T = array2table(features, 'VariableNames', columns);
        table = [table; T];
    end
end