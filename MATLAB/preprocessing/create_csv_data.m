%% Load data

close all
clear all

data1 = get_tremor_data("Simulation/data1");
data2 = get_tremor_data("Simulation/data2");
data3 = get_tremor_data("Simulation/data3");
data4 = get_tremor_data("Simulation/data4");
data5 = get_tremor_data("Simulation/data5");
data6 = get_tremor_data("Simulation/data6");
data7 = get_tremor_data("Simulation/data7");
data8 = get_tremor_data("Simulation/data8");
data9 = get_tremor_data("Simulation/data9");
data10 = get_tremor_data("Simulation/data10");
data11 = get_tremor_data("Simulation/data11");
data12 = get_tremor_data("Simulation/data12");
data13 = get_tremor_data("Simulation/data13");
data14 = get_tremor_data("Simulation/data14");
data15 = get_tremor_data("Simulation/data15");
data16 = get_tremor_data("Simulation/data16");

timewindow_size_milisec = 200;

data1_features = extract_features_in_timewindow(data1, timewindow_size_milisec);
data2_features = extract_features_in_timewindow(data2, timewindow_size_milisec);
data3_features = extract_features_in_timewindow(data3, timewindow_size_milisec);
data4_features = extract_features_in_timewindow(data4, timewindow_size_milisec);
data5_features = extract_features_in_timewindow(data5, timewindow_size_milisec);
data6_features = extract_features_in_timewindow(data6, timewindow_size_milisec);
data7_features = extract_features_in_timewindow(data7, timewindow_size_milisec);
data8_features = extract_features_in_timewindow(data8, timewindow_size_milisec);
data9_features = extract_features_in_timewindow(data9, timewindow_size_milisec);
data10_features = extract_features_in_timewindow(data10, timewindow_size_milisec);
data11_features = extract_features_in_timewindow(data11, timewindow_size_milisec);
data12_features = extract_features_in_timewindow(data12, timewindow_size_milisec);
data13_features = extract_features_in_timewindow(data13, timewindow_size_milisec);
data14_features = extract_features_in_timewindow(data14, timewindow_size_milisec);
data15_features = extract_features_in_timewindow(data15, timewindow_size_milisec);
data16_features = extract_features_in_timewindow(data16, timewindow_size_milisec);

all_features = {data1_features, data2_features, data3_features, data4_features, data5_features ...
    data6_features, data7_features, data8_features, data9_features, data10_features, data11_features ...
    data12_features, data13_features, data14_features, data15_features, data16_features};

%% Data for classificator with three classes: Tremor, Movement, Motionless

class1 = 'Tremor';
class2 = 'Movement';
class3 = 'Motionless';

table = [];

for i = 1:size(all_features, 2)
    class = '';
    
    if (i >= 1 && i <= 12)
        class = class1;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
    
    if (i >= 13 && i <= 15)
        class = class2;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
    
    if (i == 16)
        class = class3;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
end

writetable(table, '/csv_data/train_acc_data_TRE_MOV_MOT.csv');

%% Data for classificator with two classes: Action and Motionless

class1 = 'Action';
class2 = 'Motionless';

table = [];

for i = 1:size(all_features, 2)
    class = '';
    
    if (i >= 1 && i <= 15)
        class = class1;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
    
    if (i == 16)
        class = class2;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
end

writetable(table, 'csv_data/train_acc_data_ACT_MOT.csv');

%% Data for classificator with two classes: Tremor and Movement

class1 = 'Tremor';
class2 = 'Movement';

table = [];

for i = 1:size(all_features, 2)
    class = '';
    
    if (i >= 1 && i <= 12)
        class = class1;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
    
    if (i >= 13 && i <= 15)
        class = class2;
        T = fill_table_with_features(all_features{i}, class);
        table = [table; T];
    end
end

writetable(table, 'csv_data/train_acc_data_TRE_MOV.csv');