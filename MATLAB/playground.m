%% Load current data

close all
clear all

measurements = sync_measurement_data("Research");

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

%% ### Debug: Label measurement

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
    
%% ### Debug: Get chunk data test

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
table_train_TRE_STA_ACC = [table_train_TRE_ACC; table_train_STA_ACC];

writetable(table_train_MOV_STA_ACC, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_MOV_STA.csv');
writetable(table_train_TRE_MOV_ACC, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_MOV.csv');
writetable(table_train_TRE_STA_ACC, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_TRE_STA.csv');

table_test_TRE_ACC = table_TRE_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_ACC = table_MOV_ACC(ceil(0.8 * end)+1:end,:);
table_test_STA_ACC = table_STA_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_STA_ACC = [table_test_MOV_ACC; table_test_STA_ACC];
table_test_TRE_MOV_ACC = [table_test_TRE_ACC; table_test_MOV_ACC];
table_test_TRE_STA_ACC = [table_test_TRE_ACC; table_test_STA_ACC];

writetable(table_test_MOV_STA_ACC, 'TremorDetection/MATLAB/model_data/TEST_ACC_MOV_STA.csv');
writetable(table_test_TRE_MOV_ACC, 'TremorDetection/MATLAB/model_data/TEST_ACC_TRE_MOV.csv');
writetable(table_test_TRE_STA_ACC, 'TremorDetection/MATLAB/model_data/TEST_ACC_TRE_STA.csv');

%% 2. Camera based Classification model

timewindowSizeSec = 2;

staticCameraFeatures = {};
tremorCameraFeatures = {};
movementCameraFeatures = {};

for i = 1:length(staticChunks)
    features = extract_camera_features(staticChunks{i}.cameraData, timewindowSizeSec);    
    square_features = extract_camera_square_features(staticChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    staticCameraFeatures = [staticCameraFeatures; combined_features];
end

for i = 1:length(tremorChunks)
    features = extract_camera_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    tremorCameraFeatures = [tremorCameraFeatures; combined_features];
end

for i = 1:length(movementChunks)
    features = extract_camera_features(movementChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(movementChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    movementCameraFeatures = [movementCameraFeatures; combined_features];
end

table_TRE_CAM = createTableFromCameraFeatures(tremorCameraFeatures, 'Tremor');
table_MOV_CAM = createTableFromCameraFeatures(movementCameraFeatures, 'Movement');
table_STA_CAM = createTableFromCameraFeatures(staticCameraFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_CAM = table_TRE_CAM(1:ceil(0.8 * end),:);
table_train_MOV_CAM = table_MOV_CAM(1:ceil(0.8 * end),:);
table_train_STA_CAM = table_STA_CAM(1:ceil(0.8 * end),:);
table_train_MOV_STA_CAM = [table_train_MOV_CAM; table_train_STA_CAM];
table_train_TRE_MOV_CAM = [table_train_TRE_CAM; table_train_MOV_CAM];
table_train_TRE_STA_CAM = [table_train_TRE_CAM; table_train_STA_CAM];

writetable(table_train_MOV_STA_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_MOV_STA.csv');
writetable(table_train_TRE_MOV_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_TRE_MOV.csv');
writetable(table_train_TRE_STA_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_TRE_STA.csv');

table_test_TRE_CAM = table_TRE_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_CAM = table_MOV_CAM(ceil(0.8 * end)+1:end,:);
table_test_STA_CAM = table_STA_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_STA_CAM = [table_test_MOV_CAM; table_test_STA_CAM];
table_test_TRE_MOV_CAM = [table_test_TRE_CAM; table_test_MOV_CAM];
table_test_TRE_STA_CAM = [table_test_TRE_CAM; table_test_STA_CAM];

writetable(table_test_MOV_STA_CAM, 'TremorDetection/MATLAB/model_data/TEST_CAM_MOV_STA.csv');
writetable(table_test_TRE_MOV_CAM, 'TremorDetection/MATLAB/model_data/TEST_CAM_TRE_MOV.csv');
writetable(table_test_TRE_STA_CAM, 'TremorDetection/MATLAB/model_data/TEST_CAM_TRE_STA.csv');

%% 3. Audio based Classification model

timewindowSizeSec = 2;

staticAudioFeatures = {};
tremorAudioFeatures = {};
movementAudioFeatures = {};

for i = 1:length(staticChunks)
    features = extractAudioFeatures(staticChunks{i}.audioData.y, staticChunks{i}.audioData.fs, timewindowSizeSec);
    staticAudioFeatures = [staticAudioFeatures; features];
end

for i = 1:length(tremorChunks)
    features = extractAudioFeatures(tremorChunks{i}.audioData.y, tremorChunks{i}.audioData.fs, timewindowSizeSec);
    tremorAudioFeatures = [tremorAudioFeatures; features];
end

for i = 1:length(movementChunks)
    features = extractAudioFeatures(movementChunks{i}.audioData.y, movementChunks{i}.audioData.fs, timewindowSizeSec);
    movementAudioFeatures = [movementAudioFeatures; features];
end

table_TRE_AUD = createTableFromAudioFeatures(tremorAudioFeatures, 'Tremor');
table_MOV_AUD = createTableFromAudioFeatures(movementAudioFeatures, 'Movement');
table_STA_AUD = createTableFromAudioFeatures(staticAudioFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_AUD = table_TRE_AUD(1:ceil(0.8 * end),:);
table_train_MOV_AUD = table_MOV_AUD(1:ceil(0.8 * end),:);
table_train_STA_AUD = table_STA_AUD(1:ceil(0.8 * end),:);
table_train_MOV_STA_AUD = [table_train_MOV_AUD; table_train_STA_AUD];
table_train_TRE_MOV_AUD = [table_train_TRE_AUD; table_train_MOV_AUD];
table_train_TRE_STA_AUD = [table_train_TRE_AUD; table_train_STA_AUD];

writetable(table_train_MOV_STA_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_AUD_MOV_STA.csv');
writetable(table_train_TRE_MOV_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_AUD_TRE_MOV.csv');
writetable(table_train_TRE_STA_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_AUD_TRE_STA.csv');

table_test_TRE_AUD = table_TRE_AUD(ceil(0.8 * end)+1:end,:);
table_test_MOV_AUD = table_MOV_AUD(ceil(0.8 * end)+1:end,:);
table_test_STA_AUD = table_STA_AUD(ceil(0.8 * end)+1:end,:);
table_test_MOV_STA_AUD = [table_test_MOV_AUD; table_test_STA_AUD];
table_test_TRE_MOV_AUD = [table_test_TRE_AUD; table_test_MOV_AUD];
table_test_TRE_STA_AUD = [table_test_TRE_AUD; table_test_STA_AUD];

writetable(table_test_MOV_STA_AUD, 'TremorDetection/MATLAB/model_data/TEST_AUD_MOV_STA.csv');
writetable(table_test_TRE_MOV_AUD, 'TremorDetection/MATLAB/model_data/TEST_AUD_TRE_MOV.csv');
writetable(table_test_TRE_STA_AUD, 'TremorDetection/MATLAB/model_data/TEST_AUD_TRE_STA.csv');

%% 4. Accelerometer, Camera based Classification model

timewindowSizeSec = 2;

staticAccFeatures = {};
tremorAccFeatures = {};
movementAccFeatures = {};

staticCameraFeatures = {};
tremorCameraFeatures = {};
movementCameraFeatures = {};

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

for i = 1:length(staticChunks)
    features = extract_camera_features(staticChunks{i}.cameraData, timewindowSizeSec);    
    square_features = extract_camera_square_features(staticChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    staticCameraFeatures = [staticCameraFeatures; combined_features];
end

for i = 1:length(tremorChunks)
    features = extract_camera_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    tremorCameraFeatures = [tremorCameraFeatures; combined_features];
end

for i = 1:length(movementChunks)
    features = extract_camera_features(movementChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(movementChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    movementCameraFeatures = [movementCameraFeatures; combined_features];
end

S_N1 = size(staticAccFeatures, 1);
S_N2 = size(staticCameraFeatures, 1);

S_MIN = S_N1;

if S_N2 < S_MIN
    S_MIN = S_N2;
end

staticAccFeatures = staticAccFeatures(1:S_MIN,:);
staticCameraFeatures = staticCameraFeatures(1:S_MIN,:);

table_TRE_ACC = createTableFromFeatures(tremorAccFeatures, 'Tremor');
table_MOV_ACC = createTableFromFeatures(movementAccFeatures, 'Movement');
table_STA_ACC = createTableFromFeatures(staticAccFeatures, 'Static');

table_TRE_CAM = createTableFromCameraFeatures(tremorCameraFeatures, 'Tremor');
table_MOV_CAM = createTableFromCameraFeatures(movementCameraFeatures, 'Movement');
table_STA_CAM = createTableFromCameraFeatures(staticCameraFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_ACC = table_TRE_ACC(1:ceil(0.8 * end),:);
table_train_MOV_ACC = table_MOV_ACC(1:ceil(0.8 * end),:);
table_train_STA_ACC = table_STA_ACC(1:ceil(0.8 * end),:);

table_train_TRE_CAM = table_TRE_CAM(1:ceil(0.8 * end),:);
table_train_MOV_CAM = table_MOV_CAM(1:ceil(0.8 * end),:);
table_train_STA_CAM = table_STA_CAM(1:ceil(0.8 * end),:);

table_train_MOV_STA_ACC_CAM = [table_train_MOV_ACC(:,1:end-1), table_train_MOV_CAM; table_train_STA_ACC(:,1:end-1), table_train_STA_CAM];
table_train_TRE_MOV_ACC_CAM = [table_train_TRE_ACC(:,1:end-1), table_train_TRE_CAM; table_train_MOV_ACC(:,1:end-1), table_train_MOV_CAM];
table_train_TRE_STA_ACC_CAM = [table_train_TRE_ACC(:,1:end-1), table_train_TRE_CAM; table_train_STA_ACC(:,1:end-1), table_train_STA_CAM];

writetable(table_train_MOV_STA_ACC_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_CAM_MOV_STA.csv');
writetable(table_train_TRE_MOV_ACC_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_CAM_TRE_MOV.csv');
writetable(table_train_TRE_STA_ACC_CAM, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_CAM_TRE_STA.csv');

table_test_TRE_ACC = table_TRE_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_ACC = table_MOV_ACC(ceil(0.8 * end)+1:end,:);
table_test_STA_ACC = table_STA_ACC(ceil(0.8 * end)+1:end,:);

table_test_TRE_CAM = table_TRE_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_CAM = table_MOV_CAM(ceil(0.8 * end)+1:end,:);
table_test_STA_CAM = table_STA_CAM(ceil(0.8 * end)+1:end,:);

table_test_MOV_STA_ACC_CAM = [table_test_MOV_ACC(:,1:end-1), table_test_MOV_CAM; table_test_STA_ACC(:,1:end-1), table_test_STA_CAM];
table_test_TRE_MOV_ACC_CAM = [table_test_TRE_ACC(:,1:end-1), table_test_TRE_CAM; table_test_MOV_ACC(:,1:end-1), table_test_MOV_CAM];
table_test_TRE_STA_ACC_CAM = [table_test_TRE_ACC(:,1:end-1), table_test_TRE_CAM; table_test_STA_ACC(:,1:end-1), table_test_STA_CAM];

writetable(table_test_MOV_STA_ACC_CAM, 'TremorDetection/MATLAB/model_data/TEST_ACC_CAM_MOV_STA.csv');
writetable(table_test_TRE_MOV_ACC_CAM, 'TremorDetection/MATLAB/model_data/TEST_ACC_CAM_TRE_MOV.csv');
writetable(table_test_TRE_STA_ACC_CAM, 'TremorDetection/MATLAB/model_data/TEST_ACC_CAM_TRE_STA.csv');

%% 5. Accelerometer, Audio based Classification model

timewindowSizeSec = 2;

staticAccFeatures = {};
tremorAccFeatures = {};
movementAccFeatures = {};

staticAudioFeatures = {};
tremorAudioFeatures = {};
movementAudioFeatures = {};

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

for i = 1:length(staticChunks)
    features = extractAudioFeatures(staticChunks{i}.audioData.y, staticChunks{i}.audioData.fs, timewindowSizeSec);
    staticAudioFeatures = [staticAudioFeatures; features];
end

for i = 1:length(tremorChunks)
    features = extractAudioFeatures(tremorChunks{i}.audioData.y, tremorChunks{i}.audioData.fs, timewindowSizeSec);
    tremorAudioFeatures = [tremorAudioFeatures; features];
end

for i = 1:length(movementChunks)
    features = extractAudioFeatures(movementChunks{i}.audioData.y, movementChunks{i}.audioData.fs, timewindowSizeSec);
    movementAudioFeatures = [movementAudioFeatures; features];
end

S_N1 = size(staticAccFeatures, 1);
S_N2 = size(staticAudioFeatures, 1);

S_MIN = S_N1;

if S_N2 < S_MIN
    S_MIN = S_N2;
end

staticAccFeatures = staticAccFeatures(1:S_MIN,:);
staticAudioFeatures = staticAudioFeatures(1:S_MIN,:);

table_TRE_ACC = createTableFromFeatures(tremorAccFeatures, 'Tremor');
table_MOV_ACC = createTableFromFeatures(movementAccFeatures, 'Movement');
table_STA_ACC = createTableFromFeatures(staticAccFeatures, 'Static');

table_TRE_AUD = createTableFromAudioFeatures(tremorAudioFeatures, 'Tremor');
table_MOV_AUD = createTableFromAudioFeatures(movementAudioFeatures, 'Movement');
table_STA_AUD = createTableFromAudioFeatures(staticAudioFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_ACC = table_TRE_ACC(1:ceil(0.8 * end),:);
table_train_MOV_ACC = table_MOV_ACC(1:ceil(0.8 * end),:);
table_train_STA_ACC = table_STA_ACC(1:ceil(0.8 * end),:);

table_train_TRE_AUD = table_TRE_AUD(1:ceil(0.8 * end),:);
table_train_MOV_AUD = table_MOV_AUD(1:ceil(0.8 * end),:);
table_train_STA_AUD = table_STA_AUD(1:ceil(0.8 * end),:);

table_train_MOV_STA_ACC_AUD = [table_train_MOV_ACC(:,1:end-1), table_train_MOV_AUD; table_train_STA_ACC(:,1:end-1), table_train_STA_AUD];
table_train_TRE_MOV_ACC_AUD = [table_train_TRE_ACC(:,1:end-1), table_train_TRE_AUD; table_train_MOV_ACC(:,1:end-1), table_train_MOV_AUD];
table_train_TRE_STA_ACC_AUD = [table_train_TRE_ACC(:,1:end-1), table_train_TRE_AUD; table_train_STA_ACC(:,1:end-1), table_train_STA_AUD];

writetable(table_train_MOV_STA_ACC_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_AUD_MOV_STA.csv');
writetable(table_train_TRE_MOV_ACC_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_AUD_TRE_MOV.csv');
writetable(table_train_TRE_STA_ACC_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_AUD_TRE_STA.csv');

table_test_TRE_ACC = table_TRE_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_ACC = table_MOV_ACC(ceil(0.8 * end)+1:end,:);
table_test_STA_ACC = table_STA_ACC(ceil(0.8 * end)+1:end,:);

table_test_TRE_AUD = table_TRE_AUD(ceil(0.8 * end)+1:end,:);
table_test_MOV_AUD = table_MOV_AUD(ceil(0.8 * end)+1:end,:);
table_test_STA_AUD = table_STA_AUD(ceil(0.8 * end)+1:end,:);

table_test_MOV_STA_ACC_AUD = [table_test_MOV_ACC(:,1:end-1), table_test_MOV_AUD; table_test_STA_ACC(:,1:end-1), table_test_STA_AUD];
table_test_TRE_MOV_ACC_AUD = [table_test_TRE_ACC(:,1:end-1), table_test_TRE_AUD; table_test_MOV_ACC(:,1:end-1), table_test_MOV_AUD];
table_test_TRE_STA_ACC_AUD = [table_test_TRE_ACC(:,1:end-1), table_test_TRE_AUD; table_test_STA_ACC(:,1:end-1), table_test_STA_AUD];

writetable(table_test_MOV_STA_ACC_AUD, 'TremorDetection/MATLAB/model_data/TEST_ACC_AUD_MOV_STA.csv');
writetable(table_test_TRE_MOV_ACC_AUD, 'TremorDetection/MATLAB/model_data/TEST_ACC_AUD_TRE_MOV.csv');
writetable(table_test_TRE_STA_ACC_AUD, 'TremorDetection/MATLAB/model_data/TEST_ACC_AUD_TRE_STA.csv');

%% 6. Camera, Audio based Classification model

timewindowSizeSec = 2;

staticCameraFeatures = {};
tremorCameraFeatures = {};
movementCameraFeatures = {};

staticAudioFeatures = {};
tremorAudioFeatures = {};
movementAudioFeatures = {};

for i = 1:length(staticChunks)
    features = extract_camera_features(staticChunks{i}.cameraData, timewindowSizeSec);    
    square_features = extract_camera_square_features(staticChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    staticCameraFeatures = [staticCameraFeatures; combined_features];
end

for i = 1:length(tremorChunks)
    features = extract_camera_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    tremorCameraFeatures = [tremorCameraFeatures; combined_features];
end

for i = 1:length(movementChunks)
    features = extract_camera_features(movementChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(movementChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    movementCameraFeatures = [movementCameraFeatures; combined_features];
end

for i = 1:length(staticChunks)
    features = extractAudioFeatures(staticChunks{i}.audioData.y, staticChunks{i}.audioData.fs, timewindowSizeSec);
    staticAudioFeatures = [staticAudioFeatures; features];
end

for i = 1:length(tremorChunks)
    features = extractAudioFeatures(tremorChunks{i}.audioData.y, tremorChunks{i}.audioData.fs, timewindowSizeSec);
    tremorAudioFeatures = [tremorAudioFeatures; features];
end

for i = 1:length(movementChunks)
    features = extractAudioFeatures(movementChunks{i}.audioData.y, movementChunks{i}.audioData.fs, timewindowSizeSec);
    movementAudioFeatures = [movementAudioFeatures; features];
end

S_N1 = size(staticCameraFeatures, 1);
S_N2 = size(staticAudioFeatures, 1);

S_MIN = S_N1;

if S_N2 < S_MIN
    S_MIN = S_N2;
end

staticCameraFeatures = staticCameraFeatures(1:S_MIN,:);
staticAudioFeatures = staticAudioFeatures(1:S_MIN,:);

table_TRE_CAM = createTableFromCameraFeatures(tremorCameraFeatures, 'Tremor');
table_MOV_CAM = createTableFromCameraFeatures(movementCameraFeatures, 'Movement');
table_STA_CAM = createTableFromCameraFeatures(staticCameraFeatures, 'Static');

table_TRE_AUD = createTableFromAudioFeatures(tremorAudioFeatures, 'Tremor');
table_MOV_AUD = createTableFromAudioFeatures(movementAudioFeatures, 'Movement');
table_STA_AUD = createTableFromAudioFeatures(staticAudioFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_CAM = table_TRE_CAM(1:ceil(0.8 * end),:);
table_train_MOV_CAM = table_MOV_CAM(1:ceil(0.8 * end),:);
table_train_STA_CAM = table_STA_CAM(1:ceil(0.8 * end),:);

table_train_TRE_AUD = table_TRE_AUD(1:ceil(0.8 * end),:);
table_train_MOV_AUD = table_MOV_AUD(1:ceil(0.8 * end),:);
table_train_STA_AUD = table_STA_AUD(1:ceil(0.8 * end),:);

table_train_MOV_STA_CAM_AUD = [table_train_MOV_CAM(:,1:end-1), table_train_MOV_AUD; table_train_STA_CAM(:,1:end-1), table_train_STA_AUD];
table_train_TRE_MOV_CAM_AUD = [table_train_TRE_CAM(:,1:end-1), table_train_TRE_AUD; table_train_MOV_CAM(:,1:end-1), table_train_MOV_AUD];
table_train_TRE_STA_CAM_AUD = [table_train_TRE_CAM(:,1:end-1), table_train_TRE_AUD; table_train_STA_CAM(:,1:end-1), table_train_STA_AUD];

writetable(table_train_MOV_STA_CAM_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_AUD_MOV_STA.csv');
writetable(table_train_TRE_MOV_CAM_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_AUD_TRE_MOV.csv');
writetable(table_train_TRE_STA_CAM_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_CAM_AUD_TRE_STA.csv');

table_test_TRE_CAM = table_TRE_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_CAM = table_MOV_CAM(ceil(0.8 * end)+1:end,:);
table_test_STA_CAM = table_STA_CAM(ceil(0.8 * end)+1:end,:);

table_test_TRE_AUD = table_TRE_AUD(ceil(0.8 * end)+1:end,:);
table_test_MOV_AUD = table_MOV_AUD(ceil(0.8 * end)+1:end,:);
table_test_STA_AUD = table_STA_AUD(ceil(0.8 * end)+1:end,:);

table_test_MOV_STA_CAM_AUD = [table_test_MOV_CAM(:,1:end-1), table_test_MOV_AUD; table_test_STA_CAM(:,1:end-1), table_test_STA_AUD];
table_test_TRE_MOV_CAM_AUD = [table_test_TRE_CAM(:,1:end-1), table_test_TRE_AUD; table_test_MOV_CAM(:,1:end-1), table_test_MOV_AUD];
table_test_TRE_STA_CAM_AUD = [table_test_TRE_CAM(:,1:end-1), table_test_TRE_AUD; table_test_STA_CAM(:,1:end-1), table_test_STA_AUD];

writetable(table_test_MOV_STA_CAM_AUD, 'TremorDetection/MATLAB/model_data/TEST_CAM_AUD_MOV_STA.csv');
writetable(table_test_TRE_MOV_CAM_AUD, 'TremorDetection/MATLAB/model_data/TEST_CAM_AUD_TRE_MOV.csv');
writetable(table_test_TRE_STA_CAM_AUD, 'TremorDetection/MATLAB/model_data/TEST_CAM_AUD_TRE_STA.csv');

%% 7. Accelerometer, Camera, Audio based Classification model

timewindowSizeSec = 2;

staticAccFeatures = {};
tremorAccFeatures = {};
movementAccFeatures = {};

staticCameraFeatures = {};
tremorCameraFeatures = {};
movementCameraFeatures = {};

staticAudioFeatures = {};
tremorAudioFeatures = {};
movementAudioFeatures = {};

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

for i = 1:length(staticChunks)
    features = extract_camera_features(staticChunks{i}.cameraData, timewindowSizeSec);    
    square_features = extract_camera_square_features(staticChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    staticCameraFeatures = [staticCameraFeatures; combined_features];
end

for i = 1:length(tremorChunks)
    features = extract_camera_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(tremorChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    tremorCameraFeatures = [tremorCameraFeatures; combined_features];
end

for i = 1:length(movementChunks)
    features = extract_camera_features(movementChunks{i}.cameraData, timewindowSizeSec);
    square_features = extract_camera_square_features(movementChunks{i}.cameraData, timewindowSizeSec);
    
    combined_features = [features square_features];
    movementCameraFeatures = [movementCameraFeatures; combined_features];
end

for i = 1:length(staticChunks)
    features = extractAudioFeatures(staticChunks{i}.audioData.y, staticChunks{i}.audioData.fs, timewindowSizeSec);
    staticAudioFeatures = [staticAudioFeatures; features];
end

for i = 1:length(tremorChunks)
    features = extractAudioFeatures(tremorChunks{i}.audioData.y, tremorChunks{i}.audioData.fs, timewindowSizeSec);
    tremorAudioFeatures = [tremorAudioFeatures; features];
end

for i = 1:length(movementChunks)
    features = extractAudioFeatures(movementChunks{i}.audioData.y, movementChunks{i}.audioData.fs, timewindowSizeSec);
    movementAudioFeatures = [movementAudioFeatures; features];
end

S_N1 = size(staticAccFeatures, 1);
S_N2 = size(staticCameraFeatures, 1);
S_N3 = size(staticAudioFeatures, 1);

S_MIN = S_N1;

if S_N2 < S_MIN
    S_MIN = S_N2;
end

if S_N3 < S_MIN
    S_MIN = S_N3;
end

staticAccFeatures = staticAccFeatures(1:S_MIN,:);
staticCameraFeatures = staticCameraFeatures(1:S_MIN,:);
staticAudioFeatures = staticAudioFeatures(1:S_MIN,:);

table_TRE_ACC = createTableFromFeatures(tremorAccFeatures, 'Tremor');
table_MOV_ACC = createTableFromFeatures(movementAccFeatures, 'Movement');
table_STA_ACC = createTableFromFeatures(staticAccFeatures, 'Static');

table_TRE_CAM = createTableFromCameraFeatures(tremorCameraFeatures, 'Tremor');
table_MOV_CAM = createTableFromCameraFeatures(movementCameraFeatures, 'Movement');
table_STA_CAM = createTableFromCameraFeatures(staticCameraFeatures, 'Static');

table_TRE_AUD = createTableFromAudioFeatures(tremorAudioFeatures, 'Tremor');
table_MOV_AUD = createTableFromAudioFeatures(movementAudioFeatures, 'Movement');
table_STA_AUD = createTableFromAudioFeatures(staticAudioFeatures, 'Static');

% 80% TRAIN AND 20% TEST

table_train_TRE_ACC = table_TRE_ACC(1:ceil(0.8 * end),:);
table_train_MOV_ACC = table_MOV_ACC(1:ceil(0.8 * end),:);
table_train_STA_ACC = table_STA_ACC(1:ceil(0.8 * end),:);

table_train_TRE_CAM = table_TRE_CAM(1:ceil(0.8 * end),:);
table_train_MOV_CAM = table_MOV_CAM(1:ceil(0.8 * end),:);
table_train_STA_CAM = table_STA_CAM(1:ceil(0.8 * end),:);

table_train_TRE_AUD = table_TRE_AUD(1:ceil(0.8 * end),:);
table_train_MOV_AUD = table_MOV_AUD(1:ceil(0.8 * end),:);
table_train_STA_AUD = table_STA_AUD(1:ceil(0.8 * end),:);

table_train_MOV_STA_ACC_CAM_AUD = [table_train_MOV_ACC(:,1:end-1), table_train_MOV_CAM(:,1:end-1), table_train_MOV_AUD; table_train_STA_ACC(:,1:end-1), table_train_STA_CAM(:,1:end-1), table_train_STA_AUD];
table_train_TRE_MOV_ACC_CAM_AUD = [table_train_TRE_ACC(:,1:end-1), table_train_TRE_CAM(:,1:end-1), table_train_TRE_AUD; table_train_MOV_ACC(:,1:end-1), table_train_MOV_CAM(:,1:end-1), table_train_MOV_AUD];
table_train_TRE_STA_ACC_CAM_AUD = [table_train_TRE_ACC(:,1:end-1), table_train_TRE_CAM(:,1:end-1), table_train_TRE_AUD; table_train_STA_ACC(:,1:end-1), table_train_STA_CAM(:,1:end-1), table_train_STA_AUD];

writetable(table_train_MOV_STA_ACC_CAM_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_CAM_AUD_MOV_STA.csv');
writetable(table_train_TRE_MOV_ACC_CAM_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_CAM_AUD_TRE_MOV.csv');
writetable(table_train_TRE_STA_ACC_CAM_AUD, 'TremorDetection/MATLAB/model_data/TRAIN_ACC_CAM_AUD_TRE_STA.csv');

table_test_TRE_ACC = table_TRE_ACC(ceil(0.8 * end)+1:end,:);
table_test_MOV_ACC = table_MOV_ACC(ceil(0.8 * end)+1:end,:);
table_test_STA_ACC = table_STA_ACC(ceil(0.8 * end)+1:end,:);

table_test_TRE_CAM = table_TRE_CAM(ceil(0.8 * end)+1:end,:);
table_test_MOV_CAM = table_MOV_CAM(ceil(0.8 * end)+1:end,:);
table_test_STA_CAM = table_STA_CAM(ceil(0.8 * end)+1:end,:);

table_test_TRE_AUD = table_TRE_AUD(ceil(0.8 * end)+1:end,:);
table_test_MOV_AUD = table_MOV_AUD(ceil(0.8 * end)+1:end,:);
table_test_STA_AUD = table_STA_AUD(ceil(0.8 * end)+1:end,:);

table_test_MOV_STA_ACC_CAM_AUD = [table_test_MOV_ACC(:,1:end-1), table_test_MOV_CAM(:,1:end-1), table_test_MOV_AUD; table_test_STA_ACC(:,1:end-1), table_test_STA_CAM(:,1:end-1), table_test_STA_AUD];
table_test_TRE_MOV_ACC_CAM_AUD = [table_test_TRE_ACC(:,1:end-1), table_test_TRE_CAM(:,1:end-1), table_test_TRE_AUD; table_test_MOV_ACC(:,1:end-1), table_test_MOV_CAM(:,1:end-1), table_test_MOV_AUD];
table_test_TRE_STA_ACC_CAM_AUD = [table_test_TRE_ACC(:,1:end-1), table_test_TRE_CAM(:,1:end-1), table_test_TRE_AUD; table_test_STA_ACC(:,1:end-1), table_test_STA_CAM(:,1:end-1), table_test_STA_AUD];

writetable(table_test_MOV_STA_ACC_CAM_AUD, 'TremorDetection/MATLAB/model_data/TEST_ACC_CAM_AUD_MOV_STA.csv');
writetable(table_test_TRE_MOV_ACC_CAM_AUD, 'TremorDetection/MATLAB/model_data/TEST_ACC_CAM_AUD_TRE_MOV.csv');
writetable(table_test_TRE_STA_ACC_CAM_AUD, 'TremorDetection/MATLAB/model_data/TEST_ACC_CAM_AUD_TRE_STA.csv');