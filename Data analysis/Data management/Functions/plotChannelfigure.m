function [f,ch_sp1,ch_sp2,ch_sp3,ch_sp4,ch_handles] = plotChannelfigure(Sector,S_nr)
    global distance
    %% Initialization
    %global Velocity Acc GPS LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys
    f = figure('units','normalized','outerposition',[0 0 1 1]);
    panel = uipanel(f,'Position',[0.03 0.93 0.94 0.35]);

    %% Handles subfigure 1 
    ch_handles.textf1 = uicontrol(panel,'style','text');
    ch_handles.textf1.String = 'Figure 1';   
    ch_handles.textf1.Position = [5 25 80 17];

    ch_handles.typef1y = uicontrol(panel,'style','popupmenu');
    ch_handles.typef1y.Position = [90 25 80 20];
    ch_handles.typef1y.String = {'Acc','Gyro','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
            ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};

    %% Handles Subfigure 2
    ch_handles.textf2 = uicontrol(panel,'style','text');
    ch_handles.textf2.String = 'Figure 2';
    ch_handles.textf2.Position = [260 25 80 17];    

    ch_handles.typef2y = uicontrol(panel,'style','popupmenu');
    ch_handles.typef2y.Position = [345 25 80 20];
    ch_handles.typef2y.String = {'Acc','Gyro','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
            ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};

    %% Handles Subfigure 3
    ch_handles.textf3 = uicontrol(panel,'style','text');
    ch_handles.textf3.String = 'Figure 3';
    ch_handles.textf3.Position = [515 25 80 17];    

    ch_handles.typef3y = uicontrol(panel,'style','popupmenu');
    ch_handles.typef3y.Position = [600 25 80 20];
    ch_handles.typef3y.String = {'Acc','Gyro','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
            ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};

    %% Handles Subfigure 4
    ch_handles.textf4 = uicontrol(panel,'style','text');
    ch_handles.textf4.String = 'Figure 4';
    ch_handles.textf4.Position = [770 25 80 17];    

    ch_handles.typef4y = uicontrol(panel,'style','popupmenu');
    ch_handles.typef4y.Position = [855 25 80 20];
    ch_handles.typef4y.String = {'Acc','Gyro','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
            ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};

    %% Refresh button
    ch_handles.refresh = uicontrol(panel,'style','pushbutton');
    ch_handles.refresh.String = 'Refresh';
    ch_handles.refresh.Position = [1025 25 80 20];
    ch_handles.refresh.Callback = @refresh;

    %% Single or multiple graphs in a figure
    % Subplot 1
    ch_handles.graphf1 = uicontrol(panel,'style','popupmenu');
    ch_handles.graphf1.Position = [175 25 80 20];
    ch_handles.graphf1.String = {'No options'};
    ch_handles.graphf1.Callback = @(src,event)GraphChoice(src,event,1);

    % Subplot 2
    ch_handles.graphf2 = uicontrol(panel,'style','popupmenu');
    ch_handles.graphf2.Position = [430 25 80 20];
    ch_handles.graphf2.String = {'No options'};
    ch_handles.graphf2.Callback = @(src,event)GraphChoice(src,event,2);

    % Subplot 3
    ch_handles.graphf3 = uicontrol(panel,'style','popupmenu');
    ch_handles.graphf3.Position = [685 25 80 20];
    ch_handles.graphf3.String = {'No options'};
    ch_handles.graphf3.Callback = @(src,event)GraphChoice(src,event,3);

    % Subplot 4
    ch_handles.graphf4 = uicontrol(panel,'style','popupmenu');
    ch_handles.graphf4.Position = [940 25 80 20];
    ch_handles.graphf4.String = {'No options'};
    ch_handles.graphf4.Callback = @(src,event)GraphChoice(src,event,4);

    %% Sector checkboxes 
    panel_pos = getpixelposition(panel);
    width = panel_pos(3);
    prev = 0;
    for k = 1:S_nr
         name = ['S',num2str(k)];
         ch_handles.sector.(name) = uicontrol(panel,'style','pushbutton','Backgroundcolor','r');
         ch_handles.sector.(name).String = ['Sector',num2str(k)];
         sect_width = Sector.(name).dist/distance(end)*width; 
         ch_handles.sector.(name).Position = [prev 5 sect_width 17 ];
         prev = prev + sect_width;
         ch_handles.sector.(name).Value = 1;
         ch_handles.sector.Callback = @(src,event)plot_sector(src,event);
    end
    
    %% Default Subplots 
    [ha, ~] = tight_subplot(4, 1, 0.0,0.08,0.03);
    ch_sp1 = ha(1);
    ch_sp2 = ha(2);
    ch_sp3 = ha(3);
    ch_sp4 = ha(4); 

    %% Callback functions
    function refresh(src,event)
       % Read and display the input to the plots
       plot1y = ch_handles.typef1y.String{ch_handles.typef1y.Value};
       plot2y = ch_handles.typef2y.String{ch_handles.typef2y.Value};
       plot3y = ch_handles.typef3y.String{ch_handles.typef3y.Value};
       plot4y = ch_handles.typef4y.String{ch_handles.typef4y.Value};
       plotDistance(plot1y,ch_sp1,1,ch_handles)
       title(ch_sp1,' ')
       plotDistance(plot2y,ch_sp2,2,ch_handles)
       title(ch_sp2,' ')
       plotDistance(plot3y,ch_sp3,3,ch_handles)
       title(ch_sp3,' ')
       plotDistance(plot4y,ch_sp4,4,ch_handles)
       title(ch_sp4,' ')
    end

    function GraphChoice(src, event,sbpl)
         if sbpl == 1
             graph = ch_handles.graphf1.String{ch_handles.graphf1.Value};
             ploty = ch_handles.typef1y.String{ch_handles.typef1y.Value}; 
             sp = ch_sp1;
         elseif sbpl == 2
             graph = ch_handles.graphf2.String{ch_handles.graphf2.Value};
             ploty = ch_handles.typef2y.String{ch_handles.typef2y.Value}; 
             sp = ch_sp2;
         elseif sbpl == 3
             graph = ch_handles.graphf3.String{ch_handles.graphf3.Value};
             ploty = ch_handles.typef3y.String{ch_handles.typef3y.Value};    
             sp = ch_sp3;
         elseif sbpl == 4
             graph = ch_handles.graphf4.String{ch_handles.graphf4.Value};
             ploty = ch_handles.typef4y.String{ch_handles.typef4y.Value};    
             sp = ch_sp4;
         end     
         
          % Update the figures with correct graph
          if strcmp(graph,'All')
             
               plotDistance(ploty,sp,sbpl,ch_handles)
               title(sp,' ')
             
          else
               updateDistance(ploty,graph,sp)
               title(sp,' ')
          end
          
end
 
    function  plot_sector(src,event)
        fprintf('Still needs to be implemented')
    end
end 