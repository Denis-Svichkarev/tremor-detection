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
chunk.classificaion = 2; % 1 - PHT, 2 - Mov, 3 - Static

chunk.accData = getAccelerometerDataFromChunk(chunk.startTime, chunk.finishTime, measurement);
chunk.audioData = getAudioDataFromChunk(chunk.startTime, chunk.finishTime, measurement);
chunk.cameraData = getCameraDataFromChunk(chunk.startTime, chunk.finishTime, measurement);

chunks{end+1} = chunk;

%%% Save label data

measurement.chunks = chunks;
measurement.isLabeled = 'true';
measurements{1} = measurement;
save('/Users/denissvichkarev/Projects/TremorDetection/MATLAB/measurements.mat', 'measurements');
    
%% Get chunk data test

measurement = measurements{1};

chunks = {};

if isfield(measurement, 'chunks') 
    chunks = measurement.chunks; 
end

accData = {};
audioData = {};
cameraData = {};

for i = 1:length(chunks)
   chunks{i}.accData = getAccelerometerDataFromChunk(chunks{i}.startTime, chunks{i}.finishTime, measurement);
   %chunks{i}.audioData = getAudioDataFromChunk(chunks{i}.startTime, chunks{i}.finishTime, measurement);
   %chunks{i}.cameraData = getCameraDataFromChunk(chunks{i}.startTime, chunks{i}.finishTime, measurement);
end

chunks{1}.accData

