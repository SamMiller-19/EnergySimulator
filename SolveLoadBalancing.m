function [Exports,instantBatteryPower,batteryCapacity,HydroGeneration,unusedPower,unmetDemand] = SolveLoadBalancing(solGeneration,winGeneration,HydroCapacity,Load,StartCapacity,maxCapacity)
    %Get the size of the Load since thi sis generally useful
    [rows,cols]=size(Load);

    %Define some empty arrays for preprossesing
    Exports=zeros([rows cols-1]);
    unusedPower=zeros([rows cols-1]);
    unmetDemand=zeros([rows cols-1]);
    HydroGeneration=zeros([rows cols-1]);
    netPowerHydro = zeros([rows cols-1]);
    instantBatteryPower=zeros([rows cols-1]);


    solGenerationData=table2array(solGeneration(:,2:cols));
    winGenerationData=table2array(winGeneration(:,2:cols));
    HydroCapacityData=table2array(HydroCapacity(:,2:cols));
    LoadData=table2array(Load(:,2:cols));

    
    %We can now find the total sums of generation and Load at a given


    %Now we have the instanteneous Values of both and can find the
    %instanteneous load



    %Find the instanteneous demand at a time
    netPowerNoHydro=solGenerationData+winGenerationData-LoadData;

    
    batteryCapacity(1,:)=StartCapacity;
    
    
    %Go through and calculate the storage at each row
    for i=2:rows

        %Just setting the summing variables to previous values
        unusedPower(i,:)=unusedPower(i-1,:);
        unmetDemand(i,:)=unmetDemand(i-1,:);


        %-------- Hydro Power Processing -------------%
        %Check to see if the whole system's capacity is exceeded for this
        %time step if so we add in some hydro power just add it to
        %netPowerNoHydro as this is the power before balancing but should
        %include all generation sources except battery
        if (sum(netPowerNoHydro(i,:))<0)
            %Then we want to add in hydro power but we need to see if hydro
            %power meets excess demand
            if((-sum(netPowerNoHydro(i,:)))>sum(HydroCapacityData(i,:)))
                %This means we use all the hydro power
                HydroGeneration(i,:)=HydroCapacityData(i,:);
            
            else
                %If it does meet the demand then we only use enough power
                %to meet demand

                %Note this is a simplification it is because we are only 
                %Generating in Calgary, really this should spread it
                %accross all locations
                HydroGeneration(i,1)=-sum(netPowerNoHydro(i,:));
            end
            %Add the insstant hydro power back to the system
            netPowerHydro(i,:)=netPowerNoHydro(i,:)+HydroGeneration(i,:);
            %If we are not needing to use hydro netPowerHydro is just netPower
            %noHydro
        else
            netPowerHydro(i,:)=netPowerNoHydro(i,:);
        end
        %--------  End Hydro Power Processing -------------%


        %---------- Export and battery processing ------------%
            
        
        for j=1:cols-1
            %First see what the necessarry battery power is simply by calculating
            %How much power there is a location by evenly distributing it.
            %This is weighted somewhat so that more power is sent to
            %locations with low battery capacity
            if(sum(netPowerHydro(i,:))<0)
                instantBatteryPower(i,j)=-(sum(netPowerHydro(i,:)) * batteryCapacity(i-1,j)/sum(batteryCapacity(i-1,:)));
            else
                instantBatteryPower(i,j)= -(sum(netPowerHydro(i,:)) * (1-(sum(batteryCapacity(i-1,:))-batteryCapacity(i-1,j))/sum(batteryCapacity(i-1,:))));
            end



            %Calculate Exports as the power before - the battery power
            Exports(i,j) = -(instantBatteryPower(i,j)+netPowerHydro(i,j));


            %Now we calaculate the battery capacity given that we
            %add/subtract the instant battery power
            batteryCapacity(i,j)=batteryCapacity(i-1,j)-instantBatteryPower(i,j);


            %Check if the battery is fully empty or fully fulla nd process
            %accordingly
            if batteryCapacity(i,j)>maxCapacity(j)
                %Have unusedPower as a sum accross time
                unusedPower(i,j)=unusedPower(i,j)+batteryCapacity(i,j)-maxCapacity(j);
                batteryCapacity(i,j)=maxCapacity(j);

                instantBatteryPower(i,j)=batteryCapacity(i-1,j)-maxCapacity(j);
            elseif(0>batteryCapacity(i,j))
                unmetDemand(i,j)=unmetDemand(i,j)-batteryCapacity(i,j);
                instantBatteryPower(i,j)=batteryCapacity(i-1,j);
                batteryCapacity(i,j)=0;
            end

        end
        %Store how much is stored at a given time
    end
    %---------- Export and battery processing ------------%

    
    %Now we just need to convert back to tables
    Date=Load.Date;

    regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    Exports=array2table(Exports, "VariableNames", regionNames);
    Exports=addvars(Exports,Date,'Before',1);

    instantBatteryPower=array2table(instantBatteryPower, "VariableNames", regionNames);
    instantBatteryPower=addvars(instantBatteryPower,Date,'Before',1);

    batteryCapacity=array2table(batteryCapacity, "VariableNames", regionNames);
    batteryCapacity=addvars(batteryCapacity,Date,'Before',1);

    HydroGeneration=array2table(HydroGeneration, "VariableNames", regionNames);
    HydroGeneration=addvars(HydroGeneration,Date,'Before',1);

    unusedPower=array2table(unusedPower, "VariableNames", regionNames);
    unusedPower=addvars(unusedPower,Date,'Before',1);

    unmetDemand=array2table(unmetDemand, "VariableNames", regionNames);
    unmetDemand=addvars(unmetDemand,Date,'Before',1);




    %Now we have the total demand at each time 

end


