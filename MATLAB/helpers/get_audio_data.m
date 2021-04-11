%% Get audio data from folder
% This command: cd denissvichkarev/Projects/
% set the current dir and then you can use this method
function x = get_audio_data(folderName) 
    dataPath = insertAfter('TremorDetection/web/iOS//', "iOS/", folderName);
    files = dir(strcat(dataPath, '*.m4a'));

    N = length(files);
    audio_data = [];
  
    columns = {
       'y', 'fs', 'filename'
    };
        
    for i = 1:N
        features = {};
        [y, fs] = audioread(files(i).name);
        
        features = [features y];
        features = [features fs];
        features = [features files(i).name];
        
        T = array2table(features, 'VariableNames', columns);
        audio_data = [audio_data; T];
    end
    
    x = audio_data;
end