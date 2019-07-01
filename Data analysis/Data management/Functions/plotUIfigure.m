function [f,sp1,sp2,sp3,handles] = plotUIfigure(S_nr,Sector,var_list)

%% Initialization
%global Velocity Acc GPS LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys
f = figure('units','normalized','outerposition',[0 0 1 1]);
panel = uipanel(f,'Position',[0.12 0.52 0.35 0.45]);

%% Handles subfigure 1 
handles.textf1 = uicontrol(panel,'style','text');
handles.textf1.String = 'Options figure 1';   
handles.textf1.Position = [5 320 100 20];

% Xlabel
handles.xlabelf1 = uicontrol(panel,'style','text');
handles.xlabelf1.String = 'Xlabel';
handles.xlabelf1.Position = [5 300 100 20];  

handles.typef1x = uicontrol(panel,'style','popupmenu');
handles.typef1x.Position = [105 300 100 20];
handles.typef1x.String = {'Track','Distance','Time'};

% Y-label 
handles.ylabelf1 = uicontrol(panel,'style','text');
handles.ylabelf1.String = 'Ylabel';
handles.ylabelf1.Position = [5 280 100 20]; 

handles.typef1y = uicontrol(panel,'style','popupmenu');
handles.typef1y.Position = [105 280 100 20];
%handles.typef1y.String = {'gps','Angle','GyroAccel','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
%        ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};
handles.typef1y.String = var_list;

%% Handles Subfigure 2
handles.textf2 = uicontrol(panel,'style','text');
handles.textf2.String = 'Options figure 2';
handles.textf2.Position = [5 260 100 20];    

% Xlabel
handles.xlabelf2 = uicontrol(panel,'style','text');
handles.xlabelf2.String = 'Xlabel';
handles.xlabelf2.Position = [5 240 100 20];  

handles.typef2x = uicontrol(panel,'style','popupmenu');
handles.typef2x.Position = [105 240 100 20];
handles.typef2x.String = {'Track','Distance','Time'};

% Y-label 
handles.ylabelf2 = uicontrol(panel,'style','text');
handles.ylabelf2.String = 'Ylabel';
handles.ylabelf2.Position = [5 220 100 20]; 

handles.typef2y = uicontrol(panel,'style','popupmenu');
handles.typef2y.Position = [105 220 100 20];
% handles.typef2y.String = {'gps','Angle','GyroAccel','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
%         ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};
handles.typef2y.String = var_list;

%% Handles Subfigure 3
handles.textf3 = uicontrol(panel,'style','text');
handles.textf3.String = 'Options figure 3';
handles.textf3.Position = [5 200 100 20];    

% Xlabel
handles.xlabelf3 = uicontrol(panel,'style','text');
handles.xlabelf3.String = 'Xlabel';
handles.xlabelf3.Position = [5 180 100 20];  

handles.typef3x = uicontrol(panel,'style','popupmenu');
handles.typef3x.Position = [105 180 100 20];
handles.typef3x.String = {'Track','Distance','Time'};

% Y-label 
handles.ylabelf3 = uicontrol(panel,'style','text');
handles.ylabelf3.String = 'Ylabel';
handles.ylabelf3.Position = [5 160 100 20]; 

handles.typef3y = uicontrol(panel,'style','popupmenu');
handles.typef3y.Position = [105 160 100 20];
% handles.typef3y.String = {'gps','Angle','GyroAccel','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
%         ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};
handles.typef3y.String = var_list;

%% Refresh button
handles.refresh = uicontrol(panel,'style','pushbutton');
handles.refresh.String = 'Refresh';
handles.refresh.Position = [440 5 80 20];
handles.refresh.Callback = @refresh;

%% Single or multiple graphs in a figure
% Subplot 1
handles.grapht1 = uicontrol(panel,'style','text');
handles.grapht1.String = 'Graphs';
handles.grapht1.Position = [205 300 100 20];  

handles.graphf1 = uicontrol(panel,'style','popupmenu');
handles.graphf1.Position = [305 300 100 20];
handles.graphf1.String = {'No options'};
handles.graphf1.Callback = @(src,event)GraphChoice(src,event,1);

% Subplot 2
handles.grapht2 = uicontrol(panel,'style','text');
handles.grapht2.String = 'Graphs';
handles.grapht2.Position = [205 240 100 20];  

handles.graphf2 = uicontrol(panel,'style','popupmenu');
handles.graphf2.Position = [305 240 100 20];
handles.graphf2.String = {'No options'};
handles.graphf2.Callback = @(src,event)GraphChoice(src,event,2);

% Subplot 3
handles.grapht3 = uicontrol(panel,'style','text');
handles.grapht3.String = 'Graphs';
handles.grapht3.Position = [205 180 100 20];  

handles.graphf3 = uicontrol(panel,'style','popupmenu');
handles.graphf3.Position = [305 180 100 20];
handles.graphf3.String = {'No options'};
handles.graphf3.Callback = @(src,event)GraphChoice(src,event,3);

%% Extract figures button
% Subplot 1
handles.extract1 = uicontrol(panel,'style','pushbutton');
handles.extract1.String = 'Extract fig 1';
handles.extract1.Position = [100 5 80 20];
handles.extract1.Callback = @(src,event)extract(src,event,1);

% Subplot 2
handles.extract2 = uicontrol(panel,'style','pushbutton');
handles.extract2.String = 'Extract fig 2';
handles.extract2.Position = [200 5 80 20];
handles.extract2.Callback = @(src,event)extract(src,event,2);

% Subplot 3
handles.extract3 = uicontrol(panel,'style','pushbutton');
handles.extract3.String = 'Extract fig 3';
handles.extract3.Position = [300 5 80 20];
handles.extract3.Callback = @(src,event)extract(src,event,3);

%% Sector checkboxes 
for k = 1:S_nr
    name = ['S',num2str(k)];
    handles.sector.(name) = uicontrol(panel,'style','checkbox');
    handles.sector.(name).String = ['Sector',num2str(k)];
    handles.sector.(name).Position = [450 330-15*k 100 15 ];
    handles.sector.(name).Value = 1;
    %handles.sector.Callback = @(src,event)extract(src,event,1);
end
%% Default Subplots 
sp1 = subplot(2,2,2);
sp1.FontSize = 18; 
sp2 = subplot(2,2,3);
sp2.FontSize = 18; 
sp3 = subplot(2,2,4);
sp3.FontSize = 18; 

%% Callback functions
    function refresh(src,event)
       fprintf('Updating figures\n')
       % Read and display the input to the plots
       plot1x = handles.typef1x.String{handles.typef1x.Value};
       plot1y = handles.typef1y.String{handles.typef1y.Value};
       plot2x = handles.typef2x.String{handles.typef2x.Value};
       plot2y = handles.typef2y.String{handles.typef2y.Value};
       plot3x = handles.typef3x.String{handles.typef3x.Value};
       plot3y = handles.typef3y.String{handles.typef3y.Value};
       
       %disp(['Plot 1: ',plot1x, ' - ',plot1y, '.']);
       %disp(['Plot 2: ',plot2x,' - ',plot2y, '.']);
       %disp(['Plot 3: ',plot3x,' - ',plot3y, '.']);
       nr_sect_plot = 0;
       Sect_plot = [];
       for i = 1:S_nr
           sect = ['S',num2str(i)];
           value = handles.sector.(sect).Value;
           nr_sect_plot = nr_sect_plot + value; 
           if value ==1
               Sect_plot = [Sect_plot,i];
           end
       end
       if S_nr == 0 || nr_sect_plot == S_nr
           if strcmp(plot1x,'Track')
               plotTrack(plot1y,sp1,1)
           elseif strcmp(plot1x,'Distance')
               plotDistance_sector(plot1y,sp1,1,handles)
           elseif strcmp(plot1x, 'Time')
               plotTime(plot1y,sp1,1)
           else
               disp(' This choice is not possible, please select another option.\n');
           end 

           if strcmp(plot2x,'Track')
               plotTrack(plot2y,sp2,2)
           elseif strcmp(plot2x,'Distance')
               plotDistance_sector(plot2y,sp2,2,handles)
           elseif strcmp(plot2x, 'Time')
               plotTime(plot2y,sp2,2)
           else
               disp(' This choice is not possible, please select another option.\n');
           end 

           if strcmp(plot3x,'Track')
               plotTrack(plot3y,sp3,3)
           elseif strcmp(plot3x,'Distance')
               plotDistance_sector(plot3y,sp3,3,handles)
           elseif strcmp(plot3x, 'Time')
               plotTime(plot3y,sp3,3)
           else
               disp(' This choice is not possible, please select another option.\n');
           end 
           hold off
       else 
           fprintf('We plot only the selected sectors...\nStill needs to be implemented\n')
            if strcmp(plot1x,'Track')
               plotTrack(plot1y,sp1,1)
           elseif strcmp(plot1x,'Distance')
               plotDistance_sector(plot1y,sp1,1,handles,Sector,Sect_plot)
           elseif strcmp(plot1x, 'Time')
               plotTime(plot1y,sp1,1)
           else
               disp(' This choice is not possible, please select another option.\n');
           end 

           if strcmp(plot2x,'Track')
               plotTrack(plot2y,sp2,2)
           elseif strcmp(plot2x,'Distance')
               plotDistance_sector(plot2y,sp2,2,handles,Sector,Sect_plot)
           elseif strcmp(plot2x, 'Time')
               plotTime(plot2y,sp2,2)
           else
               disp(' This choice is not possible, please select another option.\n');
           end 

           if strcmp(plot3x,'Track')
               plotTrack(plot3y,sp3,3)
           elseif strcmp(plot3x,'Distance')
               plotDistance_sector(plot3y,sp3,3,handles,Sector,Sect_plot)
           elseif strcmp(plot3x, 'Time')
               plotTime(plot3y,sp3,3)
           else
               disp(' This choice is not possible, please select another option.');
           end 
           hold off          
       end
        fprintf('Finished updates\n')
    end

    function extract(src,event,sbpl)
        if sbpl == 1
            graph = handles.graphf1.String{handles.graphf1.Value};
            plotx = handles.typef1x.String{handles.typef1x.Value};
            ploty = handles.typef1y.String{handles.typef1y.Value};   
        elseif sbpl == 2
            graph = handles.graphf2.String{handles.graphf2.Value};
            plotx = handles.typef2x.String{handles.typef2x.Value};
            ploty = handles.typef2y.String{handles.typef2y.Value};             
        elseif sbpl == 3
            graph = handles.graphf3.String{handles.graphf3.Value};
            plotx = handles.typef3x.String{handles.typef3x.Value};
            ploty = handles.typef3y.String{handles.typef3y.Value};             
        end
           
        figure;
        SP = subplot(1,1,1);
        SP.FontSize = 18; 
        if strcmp(graph,'All')
            if strcmp(plotx,'Track')
                plotTrack(ploty,SP,4)
            elseif strcmp(plotx,'Distance')
                plotDistance_sector(ploty,SP,4,handles)
            elseif strcmp(plotx, 'Time')
                plotTime(ploty,SP,4)
            else
                disp(' This choice is not possible, please select another option.');
            end 
        else 
            if strcmp(plotx,'Track')
               updateTrack(ploty,graph,SP)
           elseif strcmp(plotx,'Distance')
               updateDistance_sector(ploty,graph,SP)
           elseif strcmp(plotx, 'Time')
               updateTime(ploty,graph,SP)
           end
        end
    end

    function GraphChoice(src, event,sbpl)
        if sbpl == 1
            graph = handles.graphf1.String{handles.graphf1.Value};
            plotx = handles.typef1x.String{handles.typef1x.Value};
            ploty = handles.typef1y.String{handles.typef1y.Value}; 
            sp = sp1;
        elseif sbpl == 2
            graph = handles.graphf2.String{handles.graphf2.Value};
            plotx = handles.typef2x.String{handles.typef2x.Value};
            ploty = handles.typef2y.String{handles.typef2y.Value}; 
            sp = sp2;
        elseif sbpl == 3
            graph = handles.graphf3.String{handles.graphf3.Value};
            plotx = handles.typef3x.String{handles.typef3x.Value};
            ploty = handles.typef3y.String{handles.typef3y.Value};    
            sp = sp3;
        end     
        
         % Update the figures with correct graph
         if strcmp(graph,'All')
            
           if strcmp(plotx,'Track')
               plotTrack(ploty,sp,sbpl)
           elseif strcmp(plotx,'Distance')
               plotDistance_sector(ploty,sp,sbpl,handles)
           elseif strcmp(plotx, 'Time')
               plotTime(ploty,sp,sbpl)
           else
               disp(' This choice is not possible, please select another option.');
           end 
            
         else
           if strcmp(plotx,'Track')
               updateTrack(ploty,graph,sp)
           elseif strcmp(plotx,'Distance')
               updateDistance(ploty,graph,sp)
           elseif strcmp(plotx, 'Time')
               updateTime(ploty,graph,sp)
           end
         end
         
    end
end 

