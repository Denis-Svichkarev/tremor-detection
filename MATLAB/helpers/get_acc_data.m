%% Get tremor data from folder
% This command: cd denissvichkarev/Projects/
% set the current dir and then you can use this method
function x = get_acc_data(folderName) 
    dataPath = insertAfter('TremorDetection/web/iOS//', "iOS/", folderName);
    files = dir(strcat(dataPath, '*.csv'));

    N = length(files);
    data = cell(N);

    for i = 1:N
        table = readtable(strcat(dataPath, files(i).name));
        data(i) = {table};
    end
    
    x = data;
end