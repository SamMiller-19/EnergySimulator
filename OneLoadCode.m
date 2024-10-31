regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    varnames=["Date",regionNames];
    
    %Variables to set
    
    %Set Peak loads for Wind generators kW for all the locations here,
    %comment to remove them
    
    
    winCalgary = 000;
    winCentral = 000;
    winEdmonton = 0;
    winSouth = 000;
    winNorthEast = 0;
    winNorthWest = 0;
    
    %Make a wind data array, and turn it into an array
    winPeak=[winSouth winCalgary winCentral winEdmonton winNorthEast winNorthWest];
    winPeakTable=array2table(winPeak,"VariableNames",regionNames);
    
    
    %Set Peak loads for Solar generators kW for all the locations here,
    %comment to remove them
    
    solCalgary = 12000;
    solCentral = 12000;
    solEdmonton = 7000;
    solSouth = 12000;
    solNorthEast = 7000;
    solNorthWest = 7000;
    
    solPeak=[solCalgary solCentral solEdmonton solNorthEast solNorthWest solSouth];
    solPeakTable=array2table(solPeak,"VariableNames",regionNames);

    %Set start capcity in MWh
    startCapacity = 10000;
    maxCapacity = 100000;

   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)