%% Get tremor data from folder with filename
% This command: cd denissvichkarev/Projects/
% set the current dir and then you can use this method
function x = get_acc_data_with_filename(folderName, filename) 
    dataPath = insertAfter('TremorDetection/web/iOS//', "iOS/", folderName);
    files = dir(strcat(dataPath, '*.csv'));

    N = length(files);

    for i = 1:N
        if filename == files(i).name
            x = readtable(strcat(dataPath, files(i).name));
            return;
        end
    end
end