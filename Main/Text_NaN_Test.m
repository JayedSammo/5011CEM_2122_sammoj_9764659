function MainTest(FileName)
%% This function combines testing for text and NaNs.


%% This Section tests the data file for text.

Contents = ncinfo(FileName);                            % Store file content
FileID = netcdf.open(FileName,'NC_NOWRITE');

LogFileName = 'AnalysisLog.txt';                        % Record log file
LogID = fopen('AnalysisLog.txt', 'w');                  % Open log file, 'w' replaces the file if present.
fprintf(LogID, '%s: Looking for text data in %s.. \n', datestr(now, 0), FileName);

%% Define plain text variable types
DataTypes = {'NC_Byte', 'NC_Char', 'NC_Short', 'NC_Int', 'NC_Float', 'NC_Double'};

for idx = 0:size(Contents.Variables,2)-1                % loop through each variable
                                                        % read and store data for each variable
    [~, datatype(idx+1), ~, ~] = netcdf.inqVar(FileID,idx);
end

%% display data types
DataInFile = DataTypes(datatype)'

%% find character data types
FindText = strcmp('NC_Char', DataInFile);

%% print results to both terminal and text file
fprintf('Testing file: %s\n', FileName)
if any(FindText)                                        % if text values present
    fprintf('Error, text variables present:\n')
    fprintf(LogID, '%s:Error, text variables present:\n', datestr(now, 0));
else                                                    % if text values not present
    fprintf('All data is numeric, continue analysis.\n')
    fprintf(LogID, '%s: All data is numeric, continue analysis\n', datestr(now, 0));
end
fprintf(LogID, '%s\n', DataInFile{:});


%% This section tests the file for NaNs.

NaNErrors = 0;

StartLat = 1;
StartLon = 1;

for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(FileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]);
    end
    
    %% check for NaNs
    if any(isnan(Data), 'All')                          % if NaNs found
        fprintf('NaNs present\n')
        fprintf(LogID, '%s: NaNs present during hour: %i\n', datestr(now, 0), idxHour);
        fprintf(LogID, '%s: NaNs present\n', datestr(now, 0));
        NaNErrors = 1;
    end
end
    
fprintf('Looking NaNs in file: %s\n', FileName)
fprintf(LogID, 'Testing files: %s\n', FileName);
if NaNErrors
    fprintf('NaN errors present!\n')
    fprintf(LogID, '%s: NaN errors present!\n', datestr(now, 0));
else
    fprintf('No errors!\n')
    fprintf(LogID, '%s: No errors!\n', datestr(now, 0));
end
fclose(LogID);