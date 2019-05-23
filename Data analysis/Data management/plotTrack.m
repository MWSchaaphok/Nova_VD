function [] = plotTrack(ploty,sp)
    global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys        
        cla(sp)
        if strcmp(ploty,'GPS')
            var = gps;
            FN = fieldnames(var);
            plot(sp,Xs,Ys); 
            title(sp,'GPS trajectory of the bike')
            xlabel(sp,'x [m]');
            ylabel(sp,'y [m]')
            legend(sp,'GPS');
            hold off
        else
            var = eval(ploty);
            FN = fieldnames(var);
            z = zeros(size(Xs));
            col = var.(FN{2});  % This is the color, vary with x in this case.
            surface(sp,[Xs Xs],[Ys Ys],[z z],[col col],'facecol','no','edgecol','interp','linew',2);
            xlabel('x [m]')
            ylabel('y [m]')
            colormap jet
            colorbar
            axis equal
            ttl = strrep(ploty,'_',' ');
            title(sp,[ttl,' over the track'])
            leg = strrep(FN{2},'_',' ');
            legend(sp, leg);
            hold off
        end 
end 