%% Sync measurements data
% Be sure you are in this directory: cd denissvichkarev/Projects/
function data = sync_measurement_data(folderName)
    path = '/Users/denissvichkarev/Projects/TremorDetection/MATLAB/measurements.mat';
    previousMeasurements = {};
    
    if isfile(path)
        previousMeasurements = load(path).previousMeasurements;
    end
    
    dataPath = insertAfter('TremorDetection/web/iOS//', "iOS/", folderName);
    directory = dir(dataPath);
    filenames = {directory(:).name}';
    
    accFiles = filenames(startsWith(filenames, 'ACT-'));
    audioFiles = filenames(startsWith(filenames, 'AUT-'));
    camFiles = filenames(startsWith(filenames, 'RCT-'));
    videoFiles = filenames(startsWith(filenames, 'CAT-'));
    
    N = length(accFiles);
    measurements = cell(N);
    
    for i = 1:N
        measurement = struct;
        
        % accelerometer
         
        accStr = erase(accFiles{i}, ".csv");
        accStr = erase(accStr, "ACT-");
        
        skip = 0;
        
        for j = 1:length(previousMeasurements)
            if previousMeasurements{j}.fileName == accStr
                skip = 1;
                break; 
            end
        end
        
        if skip == 1
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
        previousMeasurements{end+1} = measurement;
    end
    
    save('/Users/denissvichkarev/Projects/TremorDetection/MATLAB/measurements.mat', 'previousMeasurements');
    data = previousMeasurements;
end