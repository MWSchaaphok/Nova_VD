function [] = plotTrack(ploty,sp,sp_nr)
    global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys Gyro
    global handles
    % clear current axist
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
        hold off
        handles.graphf1.String = {'No options'};
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

        % Find the names of the different possible graphs
        % Update the dropdown menu
        num = numel(FN);
        if sp_nr == 1 
            NewStr{1} = 'All';
            for i = 2:num
                NewStr{i} = FN{i};
            end
            handles.graphf1.String = NewStr;
        elseif sp_nr == 2
            NewStr{1} = 'All';
            for i = 2:num
                NewStr{i} = FN{i};
            end
            handles.graphf2.String = NewStr;            
        elseif sp_nr == 3
            NewStr{1} = 'All';
            for i = 2:num
                NewStr{i} = FN{i};
            end
            handles.graphf3.String = NewStr;            
        end 
    end
        
        
end 