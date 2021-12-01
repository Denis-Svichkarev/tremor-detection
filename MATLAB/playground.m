%% Load current data

close all
clear all

measurements = sync_measurement_data("Research");

%% Label measurement

measurement = measurements{1};

%%% Label all chunks

chunks = {};

if isfield(measurement, 'chunks') 
    chunks = measurement.chunks; 
end

chunk = struct;
chunk.fileName = measurement.fileName;
chunk.startTime = 10;
chunk.finishTime = 15;
chunk.classification = 3; % 1 - PHT, 2 - Mov, 3 - Static

[accData, audioData, cameraData] = getDataFromChunk(chunk.startTime, chunk.finishTime, measurement);

chunk.accData = accData;
chunk.audioData = audioData;
chunk.cameraData = cameraData;

chunks{end+1} = chunk;

%%% Save label data

measurement.chunks = chunks;
measurement.isLabeled = 'true';
measurements{1} = measurement;
save('/Users/denissvichkarev/Projects/TremorDetection/MATLAB/measurements.mat', 'measurements');
    
%% Get chunk data test

measurement = measurements{2};

chunks = {};

if isfield(measurement, 'chunks') 
    chunks = measurement.chunks; 
end

for i = 1:length(chunks)
    [accData, audioData, cameraData] = getDataFromChunk(chunks{i}.startTime, chunks{i}.finishTime, measurement);
    chunks{i}.accData = accData;
    chunks{i}.audioData = audioData;
    chunks{i}.cameraData = cameraData;
    
    chunks{i}
end

%% Get chunks by classes

tremorChunks = {};
movementChunks = {};
staticChunks = {};

for i = 1:length(measurements)
    measurement = measurements{i};
    
    if isfield(measurement, 'chunks') 
        for j = 1:length(measurement.chunks)
            chunk = measurement.chunks{j};
            
            if chunk.classification == 1
            	tremorChunks{end+1} = chunk;
            elseif chunk.classification == 2
                movementChunks{end+1} = chunk;
            else
                staticChunks{end+1} = chunk; 
            end
        end
    end
end

%% 1. Accelerometer based Classification model

timewindowSizeSec = 2;

staticAccFeatures = {};
tremorAccFeatures = {};
movementAccFeatures = {};

for i = 1:length(staticChunks)
    features = extractAccFeatures(staticChunks{i}.accData, timewindowSizeSec);
    staticAccFeatures = [staticAccFeatures; features];
end

for i = 1:length(tremorChunks)
    features = extractAccFeatures(tremorChunks{i}.accData, timewindowSizeSec);
    tremorAccFeatures = [tremorAccFeatures; features];
end

for i = 1:length(movementChunks)
    features = extractAccFeatures(movementChunks{i}.accData, timewindowSizeSec);
    movementAccFeatures = [movementAccFeatures; features];
end

table_TRE_ACC = createTableFromFeatures(tremorAccFeatures, 'Tremor');
table_MOV_ACC = createTableFromFeatures(movementAccFeatures, 'Movement');
table_STA_ACC = createTableFromFeatures(staticAccFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_ACC = table_TRE_ACC(1:ceil(0.8 * end),:);
table_train_MOV_ACC = table_MOV_ACC(1:ceil(0.8 * end),:);
table_train_STA_ACC = table_STA_ACC(1:ceil(0.8 * end),:);
table_train_MOV_STA_ACC = [table_train_MOV_ACC; table_train_STA_ACC];
table_train_TRE_MOV_ACC = [table_train_TRE_ACC; table_train_MOV_ACC];

writetable(table_train_MOV_STA_ACC, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.csv');
writetable(table_train_TRE_MOV_ACC, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.csv');

table_test_TRE_ACC = table_TRE_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_ACC = table_MOV_ACC(ceil(0.8 * end)+1:end,:);
table_test_STA_ACC = table_STA_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_STA_ACC = [table_test_MOV_ACC; table_test_STA_ACC];
table_test_TRE_MOV_ACC = [table_test_TRE_ACC; table_test_MOV_ACC];

writetable(table_test_MOV_STA_ACC, 'TremorDetection/MATLAB/model_data/TEST_ACC_MOV_STA.csv');
writetable(table_test_TRE_MOV_ACC, 'TremorDetection/MATLAB/model_data/TEST_ACC_TRE_MOV.csv');

%% 2. Camera based Classification model

timewindowSizeSec = 2;

staticCameraFeatures = {};
tremorCameraFeatures = {};
movementCameraFeatures = {};

for i = 1:length(staticChunks)
    features = extract_camera_features(staticChunks{i}.cameraData, timewindowSizeSec);
    staticCameraFeatures = [staticCameraFeatures; features];
end

for i = 1:length(tremorChunks)
    features = extract_camera_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    tremorCameraFeatures = [tremorCameraFeatures; features];
end

for i = 1:length(movementChunks)
    features = extract_camera_features(movementChunks{i}.cameraData, timewindowSizeSec);
    movementCameraFeatures = [movementCameraFeatures; features];
end

table_TRE_CAM = createTableFromFeatures(tremorCameraFeatures, 'Tremor');
table_MOV_CAM = createTableFromFeatures(movementCameraFeatures, 'Movement');
table_STA_CAM = createTableFromFeatures(staticCameraFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_CAM = table_TRE_CAM(1:ceil(0.8 * end),:);
table_train_MOV_CAM = table_MOV_CAM(1:ceil(0.8 * end),:);
table_train_STA_CAM = table_STA_CAM(1:ceil(0.8 * end),:);
table_train_MOV_STA_CAM = [table_train_MOV_CAM; table_train_STA_CAM];
table_train_TRE_MOV_CAM = [table_train_TRE_CAM; table_train_MOV_CAM];

writetable(table_train_MOV_STA_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_MOV_STA.csv');
writetable(table_train_TRE_MOV_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_TRE_MOV.csv');

table_test_TRE_CAM = table_TRE_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_CAM = table_MOV_CAM(ceil(0.8 * end)+1:end,:);
table_test_STA_CAM = table_STA_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_STA_CAM = [table_test_MOV_CAM; table_test_STA_CAM];
table_test_TRE_MOV_CAM = [table_test_TRE_CAM; table_test_MOV_CAM];

writetable(table_test_MOV_STA_CAM, 'TremorDetection/MATLAB/model_data/TEST_CAM_MOV_STA.csv');
writetable(table_test_TRE_MOV_CAM, 'TremorDetection/MATLAB/model_data/TEST_CAM_TRE_MOV.csv');
