%% Replaces one hours worth of data with NaN
clear all
close all

OriginalFileName = '../Model/o3_surface_20180701000000.nc';
NewFileName = 'TestFileNaN.nc';
NewFile1Name = 'TestFile1NaN.nc';
copyfile(OriginalFileName, NewFileName);
copyfile(OriginalFileName, NewFile1Name);

C = ncinfo(NewFileName);
ModelNames = {C.Variables(1:8).Name};


%% Change data to NaN
BadData = NaN(700,400,1);

%% Write to *.nc file
Hour2Replace = 12;
for idx = 1:8
    ncwrite(NewFileName, ModelNames{idx}, BadData, [1, 1, Hour2Replace]);
end


%% Another Test file %%
C1 = ncinfo(NewFile1Name);
ModelsNames = {C1.Variables(1:8).Name};


for hour = 1:8
    for idx = 1:8
        ncwrite(NewFile1Name, ModelsNames{idx}, BadData, [1, 1, hour]);
    end
end