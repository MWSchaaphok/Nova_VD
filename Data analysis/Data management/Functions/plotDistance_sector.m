function [] = plotDistance(ploty,sp,sp_nr,Sector,Sect_plot)
    global Velocity Acc gps BMS_V BMS_C BMS_T MC_m MC_PS distance Gyro
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
    global handles 
    % Clear current axis
    
    switch nargin
        case 3 
            cla(sp)
            % Plot all graphs from category
            var = eval(ploty);
            FN = fieldnames(var);
            num = numel(FN);
            for i = 2:num-1
                plot(sp, var.dist, var.(FN{i}))
                hold(sp, 'on'); 
                leg{i-1} = strrep(FN{i},'_',' ');
            end 
            ttl = strrep(ploty,'_',' ');
            title(sp,[ttl,' over the distance'])
            xlabel(sp,'Distance [m]');
            ylabel(sp,ttl)
            legend(sp,leg{:})
            hold(sp, 'off')
        case 5 
            cla(sp)
            % Plot all graphs from category
            var = eval(ploty);
            FN = fieldnames(var);
            num = numel(FN);
            col = [' ','b','r','g','k','y'];
            for i = 2:num-1
                for j= Sect_plot
                    name = strcat('S',num2str(j));
                    plot(sp, var.dist(Sector.(name).ind), var.(FN{i})(Sector.(name).ind), col(i)
                    hold(sp, 'on'); 
                end
                leg{i-1} = strrep(FN{i},'_',' ');
            end 
            ttl = strrep(ploty,'_',' ');
            title(sp,[ttl,' over the distance'])
            xlabel(sp,'Distance [m]');
            ylabel(sp,ttl)
            legend(sp,leg{:})
            hold(sp, 'off')
    end 

    % Find the names of the different possible graphs
    % Update the dropdown menu
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