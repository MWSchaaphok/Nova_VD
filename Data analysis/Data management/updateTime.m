function [] = updateTime(ploty,graph,sp)
   global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Gyro
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