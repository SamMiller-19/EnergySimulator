
function AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)

    
    %Set up region names, this is important as they're referred to throughout
    %the program

    %First we extract the data
    
    Load = readtable('Data\LoadData2.csv');

    Load=sortrows(Load,1);
    
    solarGenerationFactors = readtable('Data\SolarData.xlsx');
    
    windGenerationFactors = readtable('Data\WindData.xlsx');
    

    % Make sure to remove all wrong years
    toDelete = year(Load.Date)~=2019;
    Load (toDelete,:)=[];
     
    %Get the peak loads, note that this removes any undefined loads
    
    solGeneration = factorToPower(solarGenerationFactors , solPeakTable);
    
    winGeneration = factorToPower(windGenerationFactors , winPeakTable);

    
    [Exports, instantBatteryPower, batteryCapacity,unusedPower,unmetDemand] = SolveLoadBalancing(solGeneration,winGeneration,Load,startCapacity,maxCapacity);

   

    PlotOutputs(solGeneration,winGeneration,Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports);

    %Get the size just for displaying
    [rows, columns]=size(solGeneration);

    fprintf('%d MWh of Battery Capacity at start of sim \n',round(sum(startCapacity)))
    fprintf('%d MWh of Battery Capacity at end of sim\n', round(sum(batteryCapacity{rows,2:7},2)))

    fprintf('maximum battery capacity of the system is set to %d MWh\n',round(sum(maxCapacity)))

    fprintf('Maximum import/export from any location at any time is %d MWh\n',round(max(max(abs(Exports{:,2:7})))))

    fprintf('Total Unused Power is %d MWh\n',round(sum(unusedPower{rows,2:7},2)))

    fprintf('%d MWh of demanded Load was not Supplied',round(sum(unusedPower{rows,2:7},2)))
    
end






