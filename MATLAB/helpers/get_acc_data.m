%% Get accelerometer data from folder
% Be sure you are in this directory: cd denissvichkarev/Projects/
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