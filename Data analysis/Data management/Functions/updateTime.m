function [] = updateTime(ploty,graph,sp)
   global Velocity Acc gps BMS_V BMS_C BMS_T MC_m MC_PS Gyro
   global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
    % Clear current axis
    cla(sp)

    % Plot the chosen graph 
    var = eval(ploty);
    plot(sp, var.t, var.(graph)) ; 
    ttl= strrep(ploty,'_',' ');
    title(sp,[ttl, ' over time'])
    xlabel(sp,'Time [s]');
    ylabel(sp,ttl)
    leg = strrep(graph,'_',' ');
    legend(sp,leg);
    hold(sp, 'off')

end 