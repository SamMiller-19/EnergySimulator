regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    varnames=["Date",regionNames];
    
    %Variables to set
    
    %Set Peak loads for Wind generators kW for all the locations here,
    %comment to remove them
    
    
    winCalgary = 4000;
    winCentral = 4000;
    winEdmonton = 0;
    winSouth = 4500;
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


    
   
    AlbertaGridModelling(winPeakTable,solPeakTable,startCapacity,maxCapacity,0)