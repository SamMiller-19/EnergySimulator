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
    solSouth = 50000;
    solNorthEast = 0;
    solNorthWest = 0;
    
    solPeak=[solCalgary solCentral solEdmonton solNorthEast solNorthWest solSouth];
    solPeakTable=array2table(solPeak,"VariableNames",regionNames);

    %Set start capcity in MWh
    startCapacityCalgary = 410000;
    startCapacityCentral = 410000;
    startCapacityEdmonton = 410000;
    startCapacitySouth = 410000;
    startCapacityNorthEast = 410000;
    startCapacityNorthWest = 410000;
    startCapacity=[startCapacityCalgary startCapacityCentral startCapacityEdmonton startCapacityNorthEast startCapacityNorthWest startCapacitySouth];

    maxCapacityCalgary = 800000;
    maxCapacityCentral = 800000;
    maxCapacityEdmonton = 800000;
    maxCapacitySouth = 800000;
    maxCapacityNorthEast = 800000;
    maxCapacityNorthWest = 8000000;

    maxCapacity=[maxCapacityCalgary maxCapacityCentral maxCapacityEdmonton maxCapacityNorthEast maxCapacityNorthWest maxCapacitySouth];


    
   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)