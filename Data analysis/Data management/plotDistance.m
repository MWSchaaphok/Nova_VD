function [] = plotDistance(ploty,sp,sp_nr)
    global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC distance Gyro
    global handles 
    % Clear current axis
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