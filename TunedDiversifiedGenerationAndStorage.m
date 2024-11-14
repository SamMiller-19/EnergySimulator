regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    varnames=["Date",regionNames];
    
    %Variables to set
    
    %Set Peak loads for Wind generators kW for all the locations here,
    %comment to remove them
    
    
    winCalgary = 3000;
    winCentral = 1000;
    winEdmonton = 0;
    winSouth = 8000;
    winNorthEast = 0;
    winNorthWest = 0;
    
    %Make a wind data array, and turn it into an array
    winPeak=[winCalgary winCentral winEdmonton winNorthEast winNorthWest winSouth];
    winPeakTable=array2table(winPeak,"VariableNames",regionNames);
    
    
    %Set Peak loads for Solar generators kW for all the locations here,
    %comment to remove them
    
    solCalgary = 3500;
    solCentral = 3000;
    solEdmonton = 3000;
    solSouth = 4000;
    solNorthEast = 2500;
    solNorthWest = 2500;
    
    solPeak=[solCalgary solCentral solEdmonton solNorthEast solNorthWest solSouth];
    solPeakTable=array2table(solPeak,"VariableNames",regionNames);


    maxCapacityCalgary = 450000;
    maxCapacityCentral = 550000;
    maxCapacityEdmonton = 650000;
    maxCapacityNorthEast = 300000;
    maxCapacityNorthWest = 350000;
    maxCapacitySouth = 350000;

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

   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity,0)