function [] = plotDistance(ploty,sp)
    global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC distance
    global handles
        cla(sp)
        var = eval(ploty);
        FN = fieldnames(var);
        num = numel(FN);
        for i = 2:num
            plot(sp, distance, var.(FN{i}))
            hold(sp, 'on'); 
            leg{i-1} = strrep(FN{i},'_',' ');
        end 
        ttl = strrep(ploty,'_',' ');
        title(sp,[ttl,' over the track'])
        xlabel(sp,'Distance [m]');
        ylabel(sp,ttl)
        legend(sp,leg{:})
        %legend(sp, FN{2:end});
        hold(sp, 'off')
end 