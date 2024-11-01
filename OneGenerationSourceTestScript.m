regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    varnames=["Date",regionNames];
    
    %Variables to set
    
    %Set Peak loads for Wind generators kW for all the locations here,
    %comment to remove them
    
    
    winCalgary = 0;
    winCentral = 0;
    winEdmonton = 0;
    winSouth = 0;
    winNorthEast = 0;
    winNorthWest = 0;
    
    %Make a wind data array, and turn it into an array
    winPeak=[winSouth winCalgary winCentral winEdmonton winNorthEast winNorthWest];
    winPeakTable=array2table(winPeak,"VariableNames",regionNames);
    
    
    %Set Peak loads for Solar generators kW for all the locations here,
    %comment to remove them
    
    solCalgary = 0;
    solCentral = 0;
    solEdmonton = 0;
    solSouth = 48000;
    solNorthEast = 0;
    solNorthWest = 0;
    
    solPeak=[solCalgary solCentral solEdmonton solNorthEast solNorthWest solSouth];
    solPeakTable=array2table(solPeak,"VariableNames",regionNames);

    %Set start capcity in MWh
    startCapacityCalgary = 500000;
    startCapacityCentral = 500000;
    startCapacityEdmonton = 500000;
    startCapacitySouth = 500000;
    startCapacityNorthEast = 500000;
    startCapacityNorthWest = 500000;
    startCapacity=[startCapacityCalgary startCapacityCentral startCapacityEdmonton startCapacityNorthEast startCapacityNorthWest startCapacitySouth];

    maxCapacityCalgary = 950000;
    maxCapacityCentral = 950000;
    maxCapacityEdmonton = 950000;
    maxCapacitySouth = 950000;
    maxCapacityNorthEast = 950000;
    maxCapacityNorthWest = 9500000;

    maxCapacity=[maxCapacityCalgary maxCapacityCentral maxCapacityEdmonton maxCapacityNorthEast maxCapacityNorthWest maxCapacitySouth];


    
   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)