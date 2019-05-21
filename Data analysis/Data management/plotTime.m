function [] = plotTime(ploty,sp)
   global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC
        cla(sp)
        var = eval(ploty);
        FN = fieldnames(var);
        num = numel(FN);
        for i = 2:num
            plot(sp, var.t, var.(FN{i}))
            hold(sp, 'on'); 
        end 
        title(sp,[ploty, ' over time'])
        xlabel(sp,'Time [s]');
        ylabel(sp,ploty)
        legend(sp, FN{2:end});
        hold(sp, 'off')
end 