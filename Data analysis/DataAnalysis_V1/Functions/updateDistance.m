function [] = updateDistance(ploty,graph,sp)
    global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS GyroAccel
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
    % Clear current axis
    cla(sp)

    % Plot all graphs from category
    var = eval(ploty);
    plot(sp, var.dist, var.(graph))
    ttl = strrep(ploty,'_',' ');
    title(sp,[ttl,' over the track'])
    xlabel(sp,'Distance [m]');
    ylabel(sp,ttl)
    leg = strrep(graph,'_',' ');
    legend(sp,leg)
    hold(sp, 'off')

end 