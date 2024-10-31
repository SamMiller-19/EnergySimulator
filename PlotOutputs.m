function PlotOutputs(Exports,instantBatteryPower,batteryCapacity,solGeneratoin,winGeneration,Load);
    %Get the sums of everything so we have to turn them all into matrices
    
    [rows cols]=size(Load);

    mExports=Exports{:,2:cols};
    minstantBatteryPower=instantBatteryPower{:,2:cols};
    mbatteryCapacity=batteryCapacity{:,2:cols};
    msolGeneratoin=solGeneratoin{:,2:cols};
    mwinGeneration=winGeneration{:,2:cols};
    mLoad=Load{:,2:cols};
    Dates=Load{:,1};

    sumExports=sum(mExports,2);
    suminstantBatteryPower=sum(minstantBatteryPower,2);
    sumbatteryCapacity=sum(mbatteryCapacity,2);
    sumsolGeneratoin=sum(msolGeneratoin,2);
    sumwinGeneration=sum(mwinGeneration,2);
    sumLoad=sum(mLoad,2);   

    figure(1)

    area(Dates,[sumsolGeneratoin sumwinGeneration])
    hold on
    area(Dates,-sumLoad)
    plot(Dates,sumLoad)
    title('generation')
    legend("Solar","Wind")
    figure(2)
    area(Dates,sumbatteryCapacity)
    title('BatteryCapacity')
    figure(3)
    area(Dates,[suminstantBatteryPower])
    title('Battery Power')
    legend("Battery Generation")
end

