function [AllDataMem] = LoadAllData(FileName)
%% Section 2: Load all the model data together

LogFileName = 'MemoryUse.txt';
LogID = fopen('MemoryUse.txt', 'w');

Contents = ncinfo(FileName); % Store the file content information in a variable.

for idx = 1: 8
    AllData(idx,:,:,:) = ncread(FileName, Contents.Variables(idx).Name);
    fprintf('Loading %s\n', Contents.Variables(idx).Name); % display loading information
    fprintf(LogID, 'Loading  %s\n\n', Contents.Variables(idx).Name);
end

AllDataMem = whos('AllData').bytes/1000000;
fprintf('Memory used for all data: %.3f MB\n', AllDataMem)
fprintf(LogID, 'Memory used for all data: %.3f MB\n', AllDataMem);
fclose(LogID);
end