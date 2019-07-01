function [] = plotTrack(ploty,sp,sp_nr)
    global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS Xs Ys GyroAccel
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
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
        hold(sp, 'off')
        handles.graphf1.String = {'No options'};
    else
        var = eval(ploty);
        FN = fieldnames(var);
        z = zeros(size(Xs));
        col = interp1(var.t,var.(FN{2}),gps.t,'spline','extrap');  % This is the color, vary with x in this case.
        %col = var.dist;
        surface(sp,[Xs Xs],[Ys Ys],[z z],[col col],'facecol','no','edgecol','interp','linew',2);
        xlabel('x [m]')
        ylabel('y [m]')
        colormap jet
        %cb = colorbar;
        %set(cb, 'Position', [.914 .51 .0181 .4150])
        %axis equal
        axis(sp,'equal')
        ttl = strrep(ploty,'_',' ');
        title(sp,[ttl,' over the track'])
        leg = strrep(FN{2},'_',' ');
        legend(sp, leg);
        hold (sp,'off')

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