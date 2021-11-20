function [accData, audioData, cameraData] = getDataFromChunk(startTime, finishTime, measurement)
    cameraFPS = 30;

    accData = measurement.accData(measurement.accData.timestamp >= startTime & measurement.accData.timestamp <= finishTime, :);
    
    audioStart = uint8(startTime * measurement.audioData.fs{1});
    audioFinish = uint8(finishTime * measurement.audioData.fs{1});
    audioData = measurement.audioData.y{1}(audioStart + 1:audioFinish + 1);
    
    cameraData = measurement.cameraData(measurement.cameraData.timestamp >= startTime * cameraFPS & measurement.cameraData.timestamp <= finishTime * cameraFPS, :);
end