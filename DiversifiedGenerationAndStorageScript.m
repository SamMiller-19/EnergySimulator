regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    varnames=["Date",regionNames];
    
    %Variables to set
    
    %Set Peak loads for Wind generators kW for all the locations here,
    %comment to remove them
    
    
    winCalgary = 4000;
    winCentral = 4000;
    winEdmonton = 0;
    winSouth = 4000;
    winNorthEast = 0;
    winNorthWest = 0;
    
    %Make a wind data array, and turn it into an array
    winPeak=[winCalgary winCentral winEdmonton winNorthEast winNorthWest winSouth];
    winPeakTable=array2table(winPeak,"VariableNames",regionNames);
    
    
    %Set Peak loads for Solar generators kW for all the locations here,
    %comment to remove them
    
    solCalgary = 4000;
    solCentral = 4000;
    solEdmonton = 4000;
    solSouth = 4000;
    solNorthEast = 4000;
    solNorthWest = 4000;
    
    solPeak=[solCalgary solCentral solEdmonton solNorthEast solNorthWest solSouth];
    solPeakTable=array2table(solPeak,"VariableNames",regionNames);


    maxCapacityCalgary = 750000;
    maxCapacityCentral = 750000;
    maxCapacityEdmonton = 750000;
    maxCapacityNorthEast = 750000;
    maxCapacityNorthWest = 750000;
    maxCapacitySouth = 750000;

    maxCapacity=[maxCapacityCalgary maxCapacityCentral maxCapacityEdmonton maxCapacityNorthEast maxCapacityNorthWest maxCapacitySouth];

    %Set start capcity in quantity of full amount
    startCapacityCalgary = 0.5;
    startCapacityCentral = 0.5;
    startCapacityEdmonton = 0.5;
    startCapacityNorthEast = 0.5;
    startCapacityNorthWest = 0.5;
    startCapacitySouth = 0.5;

    startCapacity=[startCapacityCalgary*maxCapacityCalgary, startCapacityCentral*maxCapacityCentral,...
        startCapacityEdmonton*maxCapacityEdmonton, startCapacityNorthEast*maxCapacityNorthEast,...
        startCapacityNorthWest*maxCapacityNorthWest, startCapacitySouth*maxCapacitySouth];

   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)