%% Load current data

close all
clear all

measurements = sync_measurement_data("Research");

%% Label measurement

measurement = measurements{2};

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
measurements{2} = measurement;
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

