%% Sync measurements data
% 1. Be sure you are in this directory: cd denissvichkarev/Projects/
% 2. Add all folders and subfolders of TremorDetection folder
function data = sync_measurement_data(folderName)
    path = '/Users/denissvichkarev/Projects/TremorDetection/MATLAB/measurements.mat';
    measurements = {};
    
    if isfile(path)
        measurements = load(path).measurements;
    end
    
    dataPath = insertAfter('TremorDetection/web/iOS//', "iOS/", folderName);
    directory = dir(dataPath);
    filenames = {directory(:).name}';
    
    accFiles = filenames(startsWith(filenames, 'ACT-'));
    audioFiles = filenames(startsWith(filenames, 'AUT-'));
    camFiles = filenames(startsWith(filenames, 'RCT-'));
    videoFiles = filenames(startsWith(filenames, 'CAT-'));
    
    N = length(accFiles);
    
    for i = 1:N
        measurement = struct;
        
        % accelerometer
         
        accStr = erase(accFiles{i}, ".csv");
        accStr = erase(accStr, "ACT-");

        if any(strcmp(cellfun(@(m) m.fileName, measurements, 'uni', false), {accStr}) > 0)
            continue;
        end
        
        accData = readtable(strcat(dataPath, accFiles{i}));
        
        % camera
        
        M = length(camFiles);
        for j = 1:M
            cameraStr = erase(camFiles{j}, ".csv");
            cameraStr = erase(cameraStr, "RCT-");
            
            if cameraStr == accStr
                cameraData = readtable(strcat(dataPath, camFiles{j}));
                measurement.cameraData = cameraData;
            end
        end
        
        % audio
        
        M = length(audioFiles);
        for j = 1:M
            audioStr = erase(audioFiles{j}, ".m4a");
            audioStr = erase(audioStr, "AUT-");
             
            if audioStr == accStr
                [y, fs] = audioread(audioFiles{j});
                columns = {'y', 'fs'};
                
                audioData = {};
                audioData = [audioData y];
                audioData = [audioData fs];
                measurement.audioData = array2table(audioData, 'VariableNames', columns);
            end
        end
        
        % video
        
        M = length(videoFiles);
        for j = 1:M
            videoStr = erase(videoFiles{j}, ".mp4");
            videoStr = erase(videoStr, "CAT-");
            
            if videoStr == accStr
                videoData = VideoReader(videoFiles{j});
                measurement.videoData = videoData;
            end
        end
        
        measurement.accData = accData;
        measurement.fileName = accStr;
        measurement.isLabeled = 'false';
        measurements{end+1} = measurement;
    end
    
    save('/Users/denissvichkarev/Projects/TremorDetection/MATLAB/measurements.mat', 'measurements');
    data = measurements;
end