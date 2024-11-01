function PlotOutputs(solGeneration,winGeneration,Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports)
    %Get the sums of everything so we have to turn them all into matrices
    
    

    [rows cols]=size(Load);
    



    mExports=Exports{:,2:cols};
    minstantBatteryPower=instantBatteryPower{:,2:cols};
    mbatteryCapacity=batteryCapacity{:,2:cols};
    munusedPower=unusedPower{:,2:cols};
    msolGeneration=solGeneration{:,2:cols};
    mwinGeneration=winGeneration{:,2:cols};
    mLoad=Load{:,2:cols};
    munmetDemand=unmetDemand{:,2:cols};
    Dates=Load{:,1};
    

    suminstantBatteryPower=sum(minstantBatteryPower,2);
    sumbatteryCapacity=sum(mbatteryCapacity,2);
    sumunusedPower=sum(munusedPower,2);
    sumsolGeneration=sum(msolGeneration,2);
    sumwinGeneration=sum(mwinGeneration,2);
    sumunmetDemand=sum(munmetDemand,2);
    sumLoad=sum(mLoad,2);   



    %=========================Here's where we actually start plotting=============================
    clf
    fig =figure('Name','Alberta');

    layout=tiledlayout(2,2);
    title(layout,'All of Alberta') 
    ax1=nexttile([1 2]);
    
    hold(ax1,"on");

    %subplot(2,2,[1 2])
    sgtitle('Full System') 
    
    %plot the battery power underneath the plot of all of them summed
    %area(Dates,suminstantBatteryPower,...
     %  'FaceColor',[0.4940 0.1840 0.5560],'LineStyle','none');

    generationPlot=area(ax1,Dates,[sumsolGeneration sumwinGeneration suminstantBatteryPower],'LineStyle','none');
    
    %set Colours
    generationPlot(1).FaceColor=[0.9290 0.6940 0.1250];
    generationPlot(2).FaceColor=[0.3010 0.7450 0.9330];
    generationPlot(3).FaceColor=[0.4940 0.1840 0.5560];
    
    %Plot the load
    loadPlot=plot(ax1,Dates,sumLoad);
    loadPlot.LineWidth=2;
    loadPlot.Color='Black';
    
    title('Generation')
    legend([generationPlot,loadPlot],"Solar","Wind","Battery","Load")
    zoom(fig,'xon')
    
    xlabel('Date') 
    ylabel('Generation in MW') 
    hold(ax1,"off");
    

    nexttile([1 1])
    area(Dates,sumbatteryCapacity)
    title('Battery Capacity')
    xlabel('Date') 
    ylabel('Stored Energy in MWh') 

    ax3 = nexttile([1 1]);
    hold (ax3,"on")
    plot(Dates,sumunusedPower,'LineWidth',2);
    plot(Dates,sumunmetDemand,'LineWidth',2);
    title('Unmet Demand and Unused Power')
    xlabel('Date') 
    ylabel('Energy in MWh') 
    legend("Unused Power", "Demand Not Met")
    hold (ax3,"off")

    for column=2:cols
        PlotLocations(column,solGeneration, winGeneration, Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports)
    end
    

end

