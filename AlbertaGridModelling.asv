
function AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity,useHydro)

    
    %Set up region names, this is important as they're referred to throughout
    %the program

    %First we extract the data
    
    Load = readtable('Data\LoadData2.csv');

    Load=sortrows(Load,1);
    
    solarGenerationFactors = readtable('Data\SolarData.xlsx');
    
    windGenerationFactors = readtable('Data\WindData.xlsx');
    
    HydroCapacity = readtable('Data\AvailablyHydro.csv'); 
    

    % Make sure to remove all wrong years
    toDelete = year(Load.Date)~=2019;
    Load (toDelete,:)=[];
     
    toDelete = year(HydroCapacity.Date)~=2019;
    HydroCapacity(toDelete,:)=[];
    %Get the peak loads, note that this removes any undefined loads
   

     %Get the size just for displaying
    [rows, columns]=size(Load);  

    %Get rid of hydro if we don't need it
    if(useHydro ==0)
        HydroCapacity{:,2:columns}=zeros(rows,columns-1);
    end
    
    solGeneration = factorToPower(solarGenerationFactors , solPeakTable);
    
    winGeneration = factorToPower(windGenerationFactors , winPeakTable);

    
    [Exports,instantBatteryPower,batteryCapacity,HydroGeneration,unusedPower,unmetDemand] = SolveLoadBalancing(solGeneration,winGeneration, HydroCapacity,Load,startCapacity,maxCapacity);

   

    PlotOutputs(solGeneration,winGeneration,HydroGeneration,Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports);

     

    fprintf('%d MWh of Battery Capacity at start of sim \n',round(sum(startCapacity)))
    fprintf('%d MWh of Battery Capacity at end of sim\n', round(sum(batteryCapacity{rows,2:7},2)))

    fprintf('maximum battery capacity of the system is set to %d GWh\n',round(sum(maxCapacity)/1000))

    fprintf('Total Energy Generated from Wind is %d GWh \n',round(sum(solGeneration{:,2:columns}, "all")/1000))

    fprintf('Total Energy Generated from SOlar is %d GWh\n',round(sum(winGeneration{:,2:columns}, "all")/1000))

    fprintf('Total Energy Generated from Hydro is %d GWh \n',round(sum(HydroGeneration{:,2:columns}, "all")/1000))

    fprintf('Maximum import/export from any location at any time is %d MWh\n',round(max(max(abs(Exports{:,2:7})))))

    fprintf('Total Unused Power is %d GWh\n',round(sum(unusedPower{rows,2:7},2)/1000))

    fprintf('%d MWh of demanded Load was not Supplied\n',round(sum(unmetDemand{rows,2:7},2)))


    %Note costs are taken from Cost Projections for Utility-Scale Battery
    %Storage: 2023 Update from www.nrel.gov/publications. and 
    % https://www.cer-rec.gc.ca/en/data-analysis/energy-markets/market-snapshots/2018/market-snapshot-cost-install-wind-solar-power-in-canada-is-projected-significantly-fall-over-long-term.html
    costPresent=0.48*sum(maxCapacity)+1.4*sum(winPeakTable{:,:})+1.11*sum(solPeakTable{:,:});
    costFuture= 0.22*sum(maxCapacity)+1*sum(winPeakTable{:,:})+0.65*sum(solPeakTable{:,:});

    fprintf('%d$ million Estimated cost of system based on current prices\n',costPresent);
    fprintf('%d$ million Estimated cost of system based on 2040 projected prices\n',costFuture);
    
end






