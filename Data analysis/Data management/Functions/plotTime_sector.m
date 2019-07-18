function [] = plotTime_sector(ploty,sp,sp_nr,hndles,lap,lap_nr,Sector,Sect_plot)
    global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS distance GyroAccel
    global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
    global handles 
    % Clear current axis
    
    
    if nargin == 6 
            cla(sp)
            % Plot all graphs from category
            var = eval(ploty);
            lap_start = lap.ind(lap_nr);
            try 
                lap_end = lap.ind(lap_nr+1)-1;
            catch 
                lap_end = length(var.dist);
            end
            FN = fieldnames(var);
            num = numel(FN);
            for i = 2:num-1
                plot(sp, var.t(lap_start:lap_end), var.(FN{i})(lap_start:lap_end))
                hold(sp, 'on'); 
                leg{i-1} = strrep(FN{i},'_',' ');
            end 
            ttl = strrep(ploty,'_',' ');
            title(sp,[ttl,' over time'])
            xlabel(sp,'Time [s]');
            ylabel(sp,ttl)
            legend(sp,leg{:})
            hold(sp, 'off')
    elseif nargin == 8 
            cla(sp)
            % Plot all graphs from category
            lap_start = lap.ind(lap_nr);
            var = eval(ploty);
            try 
                lap_end = lap.ind(lap_nr+1)-1;
            catch 
                lap_end = length(var.dist);
            end
            FN = fieldnames(var);
            num = numel(FN);
            col = [' ','b','r','g','k','y'];
            var.t = var.t(lap_start:lap_end);
            for i = 2:num-1
                var.(FN{i}) = var.(FN{i})(lap_start:lap_end);
                for j= Sect_plot
                    name = strcat('S',num2str(j));
                    plot(sp, var.t(Sector.(name).ind(lap_start:lap_end)), var.(FN{i})(Sector.(name).ind(lap_start:lap_end)), col(i))
                    hold(sp, 'on'); 
                end
                leg{i-1} = strrep(FN{i},'_',' ');
            end 
            ttl = strrep(ploty,'_',' ');
            title(sp,[ttl,' over time'])
            xlabel(sp,'Time [s]');
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