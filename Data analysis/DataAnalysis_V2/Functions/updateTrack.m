function [] = updateTrack(ploty,graph,sp,lap,lap_nr)
    global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS Xs Ys GyroAccel
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
    % clear current axis
    cla(sp)
    
    % Plot all graphs from the currect category 
    if strcmp(ploty,'GPS')
        var = gps;
        FN = fieldnames(var);
        plot(sp,Xs,Ys); 
        title(sp,'GPS trajectory of the bike')
        xlabel(sp,'x [m]');
        ylabel(sp,'y [m]')
        legend(sp,'GPS');
        hold(sp, 'off')
    else
        var = eval(ploty);
        FN = fieldnames(var);
        lap_start = lap.ind(lap_nr);
        try 
            lap_end = lap.ind(lap_nr+1)-1;
        catch 
            lap_end = length(var.dist);
        end
        z = zeros(size(Xs));
        var.(graph) = var.(graph)(lap_start:lap_end);
        var.t = var.t(lap_start:lap_end);
        %col = var.(graph);  % This is the color, vary with x in this case.
        col = interp1(var.t, var.(graph),gps.t);
        surface(sp,[Xs Xs],[Ys Ys],[z z],[col col],'facecol','no','edgecol','interp','linew',2);
        xlabel(sp,'x [m]')
        ylabel(sp,'y [m]')
        %colormap(sp,jet)
        %colorbar
        %cb = colorbar;
        %set(cb, 'Position', [.914 .51 .0181 .4150])
        axis(sp,'equal')
        ttl = strrep(ploty,'_',' ');
        title(sp,[ttl,' over the track'])
        leg = strrep(graph,'_',' ');
        legend(sp, leg);
        hold(sp, 'off')
    end
        
        
end 