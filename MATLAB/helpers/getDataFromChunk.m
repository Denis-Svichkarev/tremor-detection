function [accData, audioData, cameraData] = getDataFromChunk(startTime, finishTime, measurement)
    cameraFPS = 30;

    accData = measurement.accData(measurement.accData.timestamp >= startTime & measurement.accData.timestamp <= finishTime, :);
    
    audioStart = startTime * measurement.audioData.fs{1};
    audioFinish = finishTime * measurement.audioData.fs{1};
    audioData = measurement.audioData.y{1}(audioStart:audioFinish);
    
    cameraData = measurement.cameraData(measurement.cameraData.timestamp >= startTime * cameraFPS & measurement.cameraData.timestamp <= finishTime * cameraFPS, :);
end