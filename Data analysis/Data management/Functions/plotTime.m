function [] = plotTime(ploty,sp,sp_nr)
   global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
   global Velocity Acc gps BMS_V BMS_C BMS_T MC_m MC_PS MC Gyro
   global handles
    % Clear current axis
    cla(sp)

    % Plot all graphs from category
    var = eval(ploty);
    FN = fieldnames(var);
    num = numel(FN);
    for i = 2:num-1
        plot(sp, var.t, var.(FN{i}))
        hold(sp, 'on'); 
        leg{i} = strrep(FN{i},'_',' ');
    end 
    ttl = strrep(ploty,'_',' ');
    title(sp,[ttl, ' over time'])
    xlabel(sp,'Time [s]');
    ylabel(sp,ttl)
    legend(sp,leg{:});
    hold(sp, 'off')

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
    elseif sp_nr == 4
        NewStr{1} = 'All';
        for i = 2:num
            NewStr{i} = FN{i};
        end
        handles.graphf4.String = NewStr;
    end 
end 