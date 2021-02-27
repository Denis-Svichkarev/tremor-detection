%% Get audio data from folder
function x = get_audio_data(folderName) 
    dataPath = insertAfter('../web/iOS//', "iOS/", folderName);
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