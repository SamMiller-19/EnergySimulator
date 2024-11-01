function [Exports,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand] = SolveLoadBalancing(solGeneration,winGeneration,Load,StartCapacity,maxCapacity)
    %Get the size of the Load since thi sis generally useful
    [rows,cols]=size(Load);

    %Define some empty arrays for preprossesing
    Exports=zeros([rows cols-1]);
    unusedPower=zeros([rows cols-1]);
    unmetDemand=zeros([rows cols-1]);

    solGenerationData=table2array(solGeneration(:,2:cols));
    winGenerationData=table2array(winGeneration(:,2:cols));
    LoadData=table2array(Load(:,2:cols));

    %We can now find the total sums of generation and Load at a given


    %Now we have the instanteneous Values of both and can find the
    %instanteneous load



    %Find the instanteneous demand at a time
    netPowerBefore=solGenerationData+winGenerationData-LoadData;

    %Demand of the whole system at each time step
    systemNetPower=sum(netPowerBefore,2);

    %Initialize the power after
    netPowerAfter=netPowerBefore;
    
    for i=1:cols-1
        %Weighted power afterwards transmission
        netPowerAfter(:,i)=systemNetPower*sum(LoadData(:,i))/sum(LoadData,"all");

        %Split the amount of excess between everyone dependant on their net
        %load
        Exports(:,i)=netPowerAfter(:,i)-netPowerBefore(:,i);
    end
    
    %Now we actually can find out how much battery power we use (positive
    %means battery is producing)
    instantBatteryPower=-netPowerAfter;
    
    batteryCapacity(1,:)=StartCapacity;
    
    
    %Go through and calculate the storage at each row
    for i=2:rows
        batteryCapacity(i,:)=batteryCapacity(i-1,:)+netPowerAfter(i,:);
        %unused power is actually being sumed over time
        unusedPower(i,:)=unusedPower(i-1,:);
        unmetDemand(i,:)=unmetDemand(i-1,:);

        %Can't exceed max capacity

        for j=1:cols-1
            %Check if the demand is met just by what's
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
    %Now we just need to convert back to tables
    Date=Load.Date;

    regionNames= ["Calgary", "Central", "Edmonton", "NorthEast", "NorthWest","South"];
    Exports=array2table(Exports, "VariableNames", regionNames);
    Exports=addvars(Exports,Date,'Before',1);

    instantBatteryPower=array2table(instantBatteryPower, "VariableNames", regionNames);
    instantBatteryPower=addvars(instantBatteryPower,Date,'Before',1);

    batteryCapacity=array2table(batteryCapacity, "VariableNames", regionNames);
    batteryCapacity=addvars(batteryCapacity,Date,'Before',1);

    unusedPower=array2table(unusedPower, "VariableNames", regionNames);
    unusedPower=addvars(unusedPower,Date,'Before',1);

    unmetDemand=array2table(unmetDemand, "VariableNames", regionNames);
    unmetDemand=addvars(unmetDemand,Date,'Before',1);




    %Now we need to find how the power flows
%     for i=1:rows
%         for j=1:cols
%             %Look for the ones taking power
%             if totalDemand(i,j)>instantDemandBefore(i)
%                 toTake=totalDemand(i,j)-instantDemandBefore;
%                 %Look in the line matrix for the lowest values
%                 temp=sort(LineMatrix(j,:),'descend')
%                 for k=1:cols
%                     if(totalDemand(i,k)<instantDemandBefore(i))
%                         toGive=totalDemand(i,k)-instantDemandBefore
%                         if(toGive*LineMatrix(j,k)>toTake)
%                              
%                         end
% 
%                     end
%                 end
% 
%             end
%         end
% 
%     end



    %Now we have the total demand at each time 

end


