
function StorageRequired = AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)

    
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

    %We also have a loses tab on this, we just factor this into the 
    
    
    [Exports, instantBatteryPower, batteryCapacity,minimumCapacity] = SolveLoadBalancing(solGeneration,winGeneration,Load,startCapacity,maxCapacity);

    StorageRequired=-(startCapacity-minimumCapacity);

    PlotOutputs(Exports,instantBatteryPower,batteryCapacity,solGeneration,winGeneration,Load);
end






