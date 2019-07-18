function [] = updateDistance_sector(ploty,graph,sp,lap,lap_nr,Sector,Sect_plot)
    global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS GyroAccel
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
    % Clear current axis
    cla(sp)

    % Plot all graphs from category
    if nargin == 5
        var = eval(ploty);
        lap_start = lap.ind(lap_nr);
        try 
            lap_end = lap.ind(lap_nr+1)-1;
        catch 
            lap_end = length(var.dist);
        end
        plot(sp, var.dist(lap_start:lap_end), var.(graph)(lap_start:lap_end))
        ttl = strrep(ploty,'_',' ');
        title(sp,[ttl,' over the track'])
        xlabel(sp,'Distance [m]');
        ylabel(sp,ttl)
        leg = strrep(graph,'_',' ');
        legend(sp,leg)
        hold(sp, 'off')
    elseif nargin == 7
        % Plot all graphs from category
        lap_start = lap.ind(lap_nr);
        var = eval(ploty);
        try 
            lap_end = lap.ind(lap_nr+1)-1;
        catch 
            lap_end = length(var.dist);
        end
        var.dist = var.dist(lap_start:lap_end);
        var.(graph) = var.(graph)(lap_start:lap_end);
        for j= Sect_plot
            name = strcat('S',num2str(j));
            plot(sp, var.dist(Sector.(name).ind(lap_start:lap_end)), var.(graph)(Sector.(name).ind(lap_start:lap_end)),'b')
            hold(sp, 'on'); 
        end 
        ttl = strrep(ploty,'_',' ');
        title(sp,[ttl,' over the track'])
        xlabel(sp,'Distance [m]');
        ylabel(sp,ttl)
        leg = strrep(graph,'_',' ');
        legend(sp,leg)
        hold(sp, 'off')   
    end        
end 