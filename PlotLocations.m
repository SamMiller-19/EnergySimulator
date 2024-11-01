function PlotLocations(column,solGeneration,winGeneration,Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports)
    
    name=solGeneration.Properties.VariableNames{column};
    mExports=Exports{:,column};
    minstantBatteryPower=instantBatteryPower{:,column};
    mbatteryCapacity=batteryCapacity{:,column};
    munusedPower=unusedPower{:,column};
    munmetDemand=unmetDemand{:,column};
    msolGeneration=solGeneration{:,column};
    mwinGeneration=winGeneration{:,column};
    mLoad=Load{:,column};
    Dates=Load{:,1};

    fig =figure('Name',name);

    layout=tiledlayout(2,2);
    title(layout,'All of Alberta') 
    ax1=nexttile([1 2]);
    
    hold(ax1,"on");

    %subplot(2,2,[1 2])
    sgtitle(name) 
    
    %plot the battery power underneath the plot of all of them summed
    %area(Dates,suminstantBatteryPower,...
     %  'FaceColor',[0.4940 0.1840 0.5560],'LineStyle','none');

    generationPlot=area(ax1,Dates,[msolGeneration mwinGeneration minstantBatteryPower mExports],'LineStyle','none');
    
    %set Colours
    generationPlot(1).FaceColor=[0.9290 0.6940 0.1250];
    generationPlot(2).FaceColor=[0.3010 0.7450 0.9330];
    generationPlot(3).FaceColor=[0.4940 0.1840 0.5560];
    generationPlot(4).FaceColor=[.8 .8 .8];
    
    %Plot the load
    loadPlot=plot(ax1,Dates,mLoad);
    loadPlot.LineWidth=2;
    loadPlot.Color='Black';
    
    title('Generation')
    legend([generationPlot,loadPlot],"Solar","Wind","Battery","Exports","Load")
    zoom(fig,'xon')
    
    xlabel('Date') 
    ylabel('Generation in MW') 
    hold(ax1,"off");
    

    nexttile([1 1])
    area(Dates,mbatteryCapacity)
    title('Battery Capacity')
    xlabel('Date') 
    ylabel('Stored Power in MWh') 

    ax3 = nexttile([1 1]);
    hold (ax3,"on")
    plot(Dates,munusedPower,'LineWidth',2);
    plot(Dates,munmetDemand,'LineWidth',2);
    title('Unmet Demand and Unused Power')
    xlabel('Date') 
    ylabel('Energy in MWh') 
    legend("Unused Power", "Demand Not Met")
    hold (ax3,"off")
    
end

