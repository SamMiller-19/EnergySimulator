function PlotLocations(column,solGeneration,winGeneration,HydroGeneration,Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports)
    
    [rows cols]=size(batteryCapacity);

    name=solGeneration.Properties.VariableNames{column};
    mExports=Exports{:,column};
    minstantBatteryPower=instantBatteryPower{:,column};
    mbatteryCapacity=batteryCapacity{:,column};
    munusedPower=unusedPower{:,column};
    munmetDemand=unmetDemand{:,column};
    msolGeneration=solGeneration{:,column};
    mwinGeneration=winGeneration{:,column};
    mHydroGeneration=HydroGeneration{:,column};
    mLoad=Load{:,column};
    Dates=Load{:,1};

    dailyinstantBatteryPower(rows/24,1)=0;
    dailysolGeneration(rows/24,1)=0;
    dailywinGeneration(rows/24,1)=0;
    dailyHydroGeneration(rows/24,1)=0;
    dailyExports(rows/24,1)=0;
    dailyLoad(rows/24,1)=0;
    Days(365,1)=NaT;

     for i = 1:365
        dailyinstantBatteryPower(i,1)=sum(minstantBatteryPower((i-1)*24+1:24*i),1);
        dailysolGeneration(i,1)=sum(msolGeneration((i-1)*24+1:24*i),1);
        dailywinGeneration(i,1)=sum(mwinGeneration((i-1)*24+1:24*i),1);
        dailyHydroGeneration(i,1)=sum(mHydroGeneration((i-1)*24+1:24*i),1);
        dailyExports(i,1)=sum(mExports((i-1)*24+1:24*i),1);
        dailyLoad(i,1)=sum(mLoad((i-1)*24+1:24*i),1);
        Days(i,1)=Dates(24*(i-1)+1,1);

    end

    fig =figure('Name',name);
    set(fig, 'WindowStyle', 'Docked');

    layout=tiledlayout(2,2);
    title(layout,'All of Alberta') 
    ax1=nexttile([1 2]);
    
    hold(ax1,"on");

    %subplot(2,2,[1 2])
    sgtitle(name) 
    
    %plot the battery power underneath the plot of all of them summed
    %area(Dates,suminstantBatteryPower,...
     %  'FaceColor',[0.4940 0.1840 0.5560],'LineStyle','none');

    generationPlot=area(ax1,Days,[dailysolGeneration dailywinGeneration dailyHydroGeneration dailyExports dailyinstantBatteryPower ],'LineStyle','none');
    
    %set Colours
    generationPlot(1).FaceColor=[0.9290 0.6940 0.1250];
    generationPlot(2).FaceColor=[0.3010 0.7450 0.9330];
    generationPlot(3).FaceColor= [0 0.4470 0.7410];
    generationPlot(4).FaceColor=[.8 .8 .8];
    generationPlot(5).FaceColor=[0.4940 0.1840 0.5560];
    
    %Plot the load
    loadPlot=plot(ax1,Days,dailyLoad);
    loadPlot.LineWidth=2;
    loadPlot.Color='Black';
    
    title('Generation')
    legend([generationPlot,loadPlot],"Solar","Wind","Hydro","Exports","Battery","Load")
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

