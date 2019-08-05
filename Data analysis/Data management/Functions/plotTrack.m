function [] = plotTrack(ploty,sp,sp_nr,hndles,lap,lap_nr)
    global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS Xs Ys GyroAccel
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
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
        if isempty(lap.ind)
                lap_start = 1;
                lap_end = length(var.dist);
        else
                lap_start = lap.ind(lap_nr);
                try 
                    lap_end = lap.ind(lap_nr+1)-1;
                catch 
                    lap_end = length(var.dist);
                end
        end
        z = zeros(size(Xs));
        var.(FN{2}) = var.(FN{2})(lap_start:lap_end);
        var.t = var.t(lap_start:lap_end);
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
            hndles.graphf1.String = NewStr;
        elseif sp_nr == 2
            NewStr{1} = 'All';
            for i = 2:num
                NewStr{i} = FN{i};
            end
            hndles.graphf2.String = NewStr;            
        elseif sp_nr == 3
            NewStr{1} = 'All';
            for i = 2:num
                NewStr{i} = FN{i};
            end
            hndles.graphf3.String = NewStr;            
        elseif sp_nr == 4
            NewStr{1} = 'All';
            for i = 2:num
                NewStr{i} = FN{i};
            end
            hndles.graphf4.String = NewStr;
        end
    end
        
        
end 