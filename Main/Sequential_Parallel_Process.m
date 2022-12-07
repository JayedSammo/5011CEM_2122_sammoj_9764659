function Sequential_Parallel_Process(FileName)
%% This Script takes FileName to be tested 

ExploreData(FileName)
LoadAllData(FileName)
LoadHours(FileName)
LoadAllHours(FileName)
Text_NaN_Test(FileName)
SequentialProcessing(FileName)

%% This section runs parallel processing

Results = [];                                       %Array Results
SumT = [];                                          %Array SumTimes
global T3;                                          %Total Process Time

ParallelProcessing(FileName)                        %Run the Parallel Processing Function
Results = [Results; sum(T3)];                       %Record variables in array
SumT = [SumT; sum(T3)];                             %Record Total Processing Time in array



%% This section creates two new arrays and splits SumT array


y1Vals = [];                                        %Array to use y1 as value in plot
y2Vals = [];                                        %Array to use y2 as value in plot
for idx1 = 1: length(SumT)                
    if idx1 <= length(SumT)/2             
        y1Vals = [y1Vals; SumT(idx1)];              %Separate into new array y1Vals
    else
        y2Vals = [y2Vals; SumT(idx1)];              %Separate into new array y2Vals
    end
end

Graphs                                              %Run Graphs function

