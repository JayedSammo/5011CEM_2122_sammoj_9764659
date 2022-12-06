function TestNan(FileName)
%% Script to examine NetCDF data formats and check for NaN
% Note, you would carry out this test each time you load data.
% You should NOT test the whole file at the start

clear all
close all


%% Test a good file
NaNErrors = 0;
%% Set file to test
FileName = '../Model/o3_surface_20180701000000.nc'; % define our test file

Contents = ncinfo(FileName); % Store the file content information in a variable.

LogFileName = 'AnalysisLog.txt';
LogID = fopen('AnalysisLog.txt', 'w');
fprintf(LogID, '%s: Starting analysis for %s.. \n', datestr(now, 0), FileName);

StartLat = 1;
StartLon = 1;

%% this section loops through hours, loads all models for that hour.

for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(FileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]);
    end
    
    % check for NaNs
    if any(isnan(Data), 'All')
        fprintf('NaNs present\n')
        NaNErrors = 1;
    end
end
    
%% This section prints the results to both terminal and text file.

fprintf('Testing files: %s\n', FileName)
fprintf(LogID, 'Testing files: %s\n', FileName);
if NaNErrors
    fprintf('NaN errors present!\n')
    fprintf(LogID, '%s: NaN errors present!\n', datestr(now, 0));
else
    fprintf('No errors!\n')
    fprintf(LogID, '%s: No errors!\n', datestr(now, 0));
end
    
    


%% Test File with Errors
NaNErrors = 0;
%% Set file to test
FileName = '../Model/TestFileNaN.nc'; % define our test file

Contents = ncinfo(FileName); % Store the file content information in a variable.

StartLat = 1;
StartLon = 1;

fprintf('Testing files: %s\n', FileName)
fprintf(LogID, 'Testing files: %s\n', FileName);
for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(FileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]);
    end
    
    % check for NaNs
    if any(isnan(Data), 'All')
        fprintf('NaNs present during hour %i\n', idxHour)
        fprintf(LogID, '%s: NaNs present during hour: %i\n', datestr(now, 0), idxHour);
        NaNErrors = 1;
    end
end
    
if NaNErrors
    fprintf('NaN errors present!\n')
    fprintf(LogID, '%s: NaN errors present!\n', datestr(now, 0));
else
    fprintf('No errors!\n')
    fprintf(LogID, '%s: No errors!:\n', datestr(now, 0));
end

%% Another Test

%% Set file to test

FileName = 'TestFile1NaN.nc'; % define our test file

Contents = ncinfo(FileName); % Store the file content information in a variable.

StartLat = 1;
StartLon = 1;

fprintf('Testing files: %s\n', FileName)
fprintf(LogID, 'Testing files: %s\n', FileName);
for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(FileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]);
    end
    
    % check for NaNs
    if any(isnan(Data), 'All')
        fprintf('NaNs present during hour %i\n', idxHour)
        fprintf(LogID, '%s: NaNs present during hour: %i\n', datestr(now, 0), idxHour);
        NaNErrors = 1;
    end
end
    
if NaNErrors
    fprintf('NaN errors present!\n')
    fprintf(LogID, '%s: NaN errors present!\n', datestr(now, 0));
else
    fprintf('No errors!\n')
    fprintf(LogID, '%s: No errors!:\n', datestr(now, 0));
end
fclose(LogID);
end