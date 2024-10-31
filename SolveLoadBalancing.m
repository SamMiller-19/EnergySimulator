function [Exports,instantBatteryPower,batteryCapacity,minimumCapacity] = SolveLoadBalancing(solGeneration,winGeneration,Load,StartCapacity,maxCapacity)
    %Get the size of the Load since thi sis generally useful
    [rows,cols]=size(Load);

    %Define some empty arrays for preprossesing
    Exports=zeros([rows cols-1]);

    solGenerationData=table2array(solGeneration(:,2:cols));
    winGenerationData=table2array(winGeneration(:,2:cols));
    LoadGenerationData=table2array(Load(:,2:cols));

    %We can now find the total sums of generation and Load at a given


    %Now we have the instanteneous Values of both and can find the
    %instanteneous load



    %Find the instanteneous demand at a given time
    netPowerBefore=solGenerationData+winGenerationData-LoadGenerationData;
    %Demand of the whole system at each time step
    systemNetPower=sum(netPowerBefore,2);

    
    for i=1:cols-1
        %Split the amount of excess between everyone dependant on their net
        %load
        Exports(:,i)=(netPowerBefore(:,i)-systemNetPower)*sum(LoadGenerationData(:,i))/sum(LoadGenerationData,"all");
    end
    
    %Now we actually can find out how much battery power we use (positive
    %means battery is producing)
    instantBatteryPower=-(netPowerBefore-Exports);

    minimumCapacity(1,1:cols-1)=StartCapacity;
    batteryCapacity=zeros(rows,cols-1);
    tempCapacity=StartCapacity;

    %Go through and calculate the storage at each row
    for i=1:rows
        tempCapacity=tempCapacity-instantBatteryPower(i,:);
        %Can't exceed max capacity
        for j=1:cols-1
            if tempCapacity(j)>maxCapacity
                tempCapacity(j)=maxCapacity;
            elseif(minimumCapacity(j)>tempCapacity(j))
                minimumCapacity(j)=tempCapacity(j);
            end

        end
        %Store how much is stored at a given time
        batteryCapacity(i,:)=tempCapacity;
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


