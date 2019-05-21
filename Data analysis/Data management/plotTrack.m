function [] = plotTrack(ploty,sp)
    global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys        
        cla(sp)
        var = eval(ploty);
        FN = fieldnames(var);
        if strcmp(ploty,'gps')
            plot(sp1,Xs,Ys); 
            title(sp1,'GPS trajectory of the bike')
            xlabel(sp1,'x');
            ylabel(sp1,'y')
            legend(sp1,'GPS');
            hold off
        else
            z = zeros(size(Xs));
            col = var.(FN{2});  % This is the color, vary with x in this case.
            surface(sp,[Xs Xs],[Ys Ys],[z z],[col col],'facecol','no','edgecol','interp','linew',2);
            xlabel('x [m]')
            ylabel('y [m]')
            colormap jet
            colorbar
            axis equal
            title(sp,[ploty,' over the track'])
            legend(sp, FN{2});
            hold off
        end 
end 