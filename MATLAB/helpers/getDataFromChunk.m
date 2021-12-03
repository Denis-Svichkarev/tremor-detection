function [accData, audioData, cameraData] = getDataFromChunk(startTime, finishTime, measurement)
    accData = measurement.accData(measurement.accData.timestamp >= startTime & measurement.accData.timestamp <= finishTime, :);
    
    audioStart = int32(startTime * measurement.audioData.fs{1});
    audioFinish = int32(finishTime * measurement.audioData.fs{1});
    audioData = struct;
    audioData.y = measurement.audioData.y{1}(audioStart + 1:audioFinish + 1);
    audioData.fs = measurement.audioData.fs{1};

    cameraFPS = 30;
    cameraData = measurement.cameraData(measurement.cameraData.timestamp >= startTime * cameraFPS & measurement.cameraData.timestamp <= finishTime * cameraFPS, :);
end