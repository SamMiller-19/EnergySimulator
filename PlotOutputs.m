function PlotOutputs(solGeneration,winGeneration,HydroGeneration,Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports)
    
    [rows cols]=size(Load);

    %Get the sums of everything so we have to turn them all into matrices

    mExports=Exports{:,2:cols};
    minstantBatteryPower=instantBatteryPower{:,2:cols};
    mbatteryCapacity=batteryCapacity{:,2:cols};
    munusedPower=unusedPower{:,2:cols};
    msolGeneration=solGeneration{:,2:cols};
    mwinGeneration=winGeneration{:,2:cols};
    mHydroGeneration=HydroGeneration{:,2:cols};
    mLoad=Load{:,2:cols};
    munmetDemand=unmetDemand{:,2:cols};
    Dates=Load{:,1};
    

    suminstantBatteryPower=sum(minstantBatteryPower,2);
    sumbatteryCapacity=sum(mbatteryCapacity,2);
    sumunusedPower=sum(munusedPower,2);
    sumsolGeneration=sum(msolGeneration,2);
    sumwinGeneration=sum(mwinGeneration,2);
    sumHydroGeneration=sum(mHydroGeneration,2);
    sumunmetDemand=sum(munmetDemand,2);
    sumLoad=sum(mLoad,2);   

    dailyinstantBatteryPower(rows/24,1)=0;
    dailysolGeneration(rows/24,1)=0;
    dailywinGeneration(rows/24,1)=0;
    dailyHydroGeneration(rows/24,1)=0;
    dailyLoad(rows/24,1)=0;
    Days(365,1)=NaT;

    for i = 1:365
        dailyinstantBatteryPower(i,1)=sum(suminstantBatteryPower((i-1)*24+1:24*i),1);
        dailysolGeneration(i,1)=sum(sumsolGeneration((i-1)*24+1:24*i),1);
        dailywinGeneration(i,1)=sum(sumwinGeneration((i-1)*24+1:24*i),1);
        dailyHydroGeneration(i,1)=sum(sumHydroGeneration((i-1)*24+1:24*i),1);
        dailyLoad(i,1)=sum(sumLoad((i-1)*24+1:24*i),1);
        Days(i,1)=Dates((24-1)*i+1,1);

    end



    %=========================Here's where we actually start plotting=============================
    
    
    clf
    fig =figure('Name','Alberta');
    set(fig, 'WindowStyle', 'Docked');

    layout=tiledlayout(2,2);
    title(layout,'All of Alberta') 
    ax1=nexttile([1 2]);
    
    hold(ax1,"on");

    %subplot(2,2,[1 2])
    sgtitle('Full System') 
    
    %plot the battery power underneath the plot of all of them summed
    %area(Dates,suminstantBatteryPower,...
     %  'FaceColor',[0.4940 0.1840
     %  0.5560],'LineStyle','none');

    generationPlot=area(ax1,Days,[dailysolGeneration dailywinGeneration dailyHydroGeneration dailyinstantBatteryPower],'LineStyle','none');
    
    %set Colours
    generationPlot(1).FaceColor=[0.9290 0.6940 0.1250];
    generationPlot(2).FaceColor=[0.3010 0.7450 0.9330];
    generationPlot(3).FaceColor= [0 0.4470 0.7410];
    generationPlot(4).FaceColor=[0.4940 0.1840 0.5560];

    
    %Plot the load
    loadPlot=plot(ax1,Days,dailyLoad);
    loadPlot.LineWidth=2;
    loadPlot.Color='Black';
    
    title('Generation')
    legend([generationPlot,loadPlot],"Solar","Wind","Hydro","Battery","Load")
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
        PlotLocations(column,solGeneration, winGeneration,HydroGeneration, Load,instantBatteryPower,batteryCapacity,unusedPower,unmetDemand,Exports)
    end
    

end

