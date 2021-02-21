%% Copy .h and .cpp from function folder to copy_files folder

function_name = "classify_action";
ignored_names = ["action_types", "tremor_types"];

%% Delete all files

myFolder = '/Users/denissvichkarev/Projects/TremorDetection/MATLAB/copy_files';

if isfolder(myFolder)
    rmdir(myFolder,'s');
end

mkdir /Users/denissvichkarev/Projects/TremorDetection/MATLAB copy_files

%% Copy necessary files

folder_path = strcat('/Users/denissvichkarev/Projects/TremorDetection/MATLAB/classify_functions/codegen/lib/', function_name);
cd(folder_path)
filenames = dir;
for i = 1:length(filenames)
    [filepath, name, ext] = fileparts(filenames(i).name);
    ignore=false;
    
    for j = 1:length(ignored_names)
        if contains(name, ignored_names(j))
            ignore=true;
            break;
        end
    end
    
    if ~ignore && contains(name, function_name) && (ext == ".h" || ext == ".cpp")
        copyfile(filenames(i).name, '/Users/denissvichkarev/Projects/TremorDetection/MATLAB/copy_files/')
    end
end

cd('/Users/denissvichkarev/Projects/TremorDetection/MATLAB/')