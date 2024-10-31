
%Takes 2 tables, one with a list of time series and one with a list of
%multipliers and multiplies them by corresponding values. Must match
function TotalGeneration = factorToPower(GenerationTseries, PeakProduction)
    %Find the number of columns
    [rows, cols]=size(GenerationTseries);

    %Prealocate the array
    TotalGeneration=GenerationTseries;
    TotalGeneration{1:rows, 2:cols}=zeros(rows,cols-1);
    
    %Initialize the PeakProduction table


    %Starting at 2 cause date inf is already filled
    for i=2:cols
        name=PeakProduction.Properties.VariableNames{i-1};
        %Check if it exists
        if (ismember(name,GenerationTseries.Properties.VariableNames))
            %Make a new column with the corresponding nam and fill it with 
            % the PeakProduction* the Tseries
            TotalGeneration.(name)=PeakProduction.(name)*GenerationTseries.(name);
            
        end 
    end
end