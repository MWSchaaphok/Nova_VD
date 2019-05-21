function [] = plotDistance(ploty,sp)
    global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC distance
        cla(sp)
        var = eval(ploty);
        FN = fieldnames(var);
        num = numel(FN);
        for i = 2:num
            plot(sp, distance, var.(FN{i}))
            hold(sp, 'on'); 
        end 
        title(sp,[ploty,' over the track'])
        xlabel(sp,'Distance [m]');
        ylabel(sp,ploty)
        legend(sp, FN{2:end});
        hold(sp, 'off')
end 