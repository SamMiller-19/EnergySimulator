regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    varnames=["Date",regionNames];
    
    %Variables to set
    
    %Set Peak loads for Wind generators kW for all the locations here,
    %comment to remove them
    
    
    winCalgary = 5000;
    winCentral = 5000;
    winEdmonton = 0;
    winSouth = 5000;
    winNorthEast = 0;
    winNorthWest = 0;
    
    %Make a wind data array, and turn it into an array
    winPeak=[winSouth winCalgary winCentral winEdmonton winNorthEast winNorthWest];
    winPeakTable=array2table(winPeak,"VariableNames",regionNames);
    
    
    %Set Peak loads for Solar generators kW for all the locations here,
    %comment to remove them
    
    solCalgary = 5500;
    solCentral = 5500;
    solEdmonton = 5500;
    solSouth = 5500;
    solNorthEast = 5500;
    solNorthWest = 5500;
    
    solPeak=[solCalgary solCentral solEdmonton solNorthEast solNorthWest solSouth];
    solPeakTable=array2table(solPeak,"VariableNames",regionNames);

    %Set start capcity in MWh
    startCapacityCalgary = 0;
    startCapacityCentral = 0;
    startCapacityEdmonton = 0;
    startCapacitySouth = 0;
    startCapacityNorthEast = 0;
    startCapacityNorthWest = 0;
    startCapacity=[startCapacityCalgary startCapacityCentral startCapacityEdmonton startCapacityNorthEast startCapacityNorthWest startCapacitySouth];

    maxCapacityCalgary = 0;
    maxCapacityCentral = 0;
    maxCapacityEdmonton = 0;
    maxCapacitySouth = 0;
    maxCapacityNorthEast = 0;
    maxCapacityNorthWest = 0;

    maxCapacity=[maxCapacityCalgary maxCapacityCentral maxCapacityEdmonton maxCapacityNorthEast maxCapacityNorthWest maxCapacitySouth];


    
   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity)