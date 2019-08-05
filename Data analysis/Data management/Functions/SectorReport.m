function [T,T2,T3] = SectorReport(gps,Velocity,lap,Sector,file,path)
    %% Makes a report of the data set with sector times, min/max speeds over the different laps
    FN = fieldnames(lap);
    SN = fieldnames(Sector);
    total_lap_nr = numel(FN)-1;

    % Compute and add laptimes
    LapTime = zeros(total_lap_nr,1); 
    Lap = [1:total_lap_nr]';
    for j=1:total_lap_nr
        lap_start = lap.ind(j);
        try 
            lap_end = lap.ind(j+1)-1;
        catch 
            lap_end = length(gps.dist);
        end    
        LapTime(j) = gps.t(lap_end) - gps.t(lap_start);
    end 
    T = table(Lap, LapTime);
    T2 = table(Lap,LapTime);
    T3 = table(Lap,LapTime);
    % Compute and add sector times
    Sect_nr = numel(SN);
    for i =1:Sect_nr
        name = strcat('S',num2str(i));
        Sector.(name).times = [];
        entry_speed = [];
        exit_speed = [];
        max_speed = [];
        min_speed = [];
        for j = 1:total_lap_nr
            lap_start = lap.ind(j);
            try 
                lap_end = lap.ind(j+1)-1;
            catch 
                lap_end = length(gps.dist);
            end     
            sector_times = gps.t(Sector.(name).ind(lap_start:lap_end-1));
            sector_speed = Velocity.x_gps(Sector.(name).ind(lap_start:lap_end-1)==1);
            
            try 
                time = sector_times(end) - sector_times(1);
            catch 
                time = 0; 
            end
            Sector.(name).times = [Sector.(name).times; time];
            if isempty(sector_speed)
                entry_speed = [entry_speed;0];
                exit_speed  = [exit_speed;0];
                max_speed   = [max_speed;0];
                min_speed   = [min_speed;0];
            else
                entry_speed = [entry_speed;sector_speed(1)];
                exit_speed = [exit_speed;sector_speed(end)];
                max_speed = [max_speed;max(sector_speed)];
                min_speed = [min_speed;min(sector_speed)];
            end
        end
        T = addvars(T,Sector.(name).times,'NewVariableNames',name);
        T2 = addvars(T2,[entry_speed,exit_speed],'NewVariableNames',name);
        T3 = addvars(T3,[min_speed,max_speed],'NewVariableNames',name);
    end
    
%% Write table to excel file with corresponding information
    filename = strcat(path,'Sector_report_',file,'.xlsx');
    %setHeading(T,'Sector times');
    xlswrite(filename,{'Lap times and Sector times'})
    writetable(T,filename,'Sheet','Lap','Range','A2');
    start_point = strcat('A',num2str(size(T,1)+4));
    xlswrite(filename,{'Entry and Exit speeds sectors'},1,start_point)
    start_point = strcat('A',num2str(size(T,1)+5));
    writetable(T2,filename,'Sheet','Lap','Range',start_point);
    start_point2 = strcat('A',num2str(size(T,1) + size(T2,1) + 7));
    xlswrite(filename,{'Min and Max speeds sectors'},1,start_point2);
    start_point2 = strcat('A',num2str(size(T,1) + size(T2,1) + 8));
    writetable(T3,filename,'Sheet','Lap','Range',start_point2);
    
%% Write images to 
end

