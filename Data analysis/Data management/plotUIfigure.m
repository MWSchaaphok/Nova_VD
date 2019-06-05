function [f,sp1,sp2,sp3,handles] = plotUIfigure()

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
handles.typef1y.String = {'Velocity','Acc','GPS','LV','BMS_V','BMS_C','BMS_T','MC_m','MC_PS','MC_air','MC','Gyro'};

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
handles.typef2y.String = {'Velocity','Acc','GPS','LV','BMS_V','BMS_C','BMS_T','MC_m','MC_PS','MC_air','MC','Gyro'};

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
handles.typef3y.String = {'Velocity','Acc','GPS','LV','BMS_V','BMS_C','BMS_T','MC_m','MC_PS','MC_air','MC','Gyro'};

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
handles.graphf1.Callback = @GraphChoice1;

% Subplot 2
handles.grapht2 = uicontrol(panel,'style','text');
handles.grapht2.String = 'Graphs';
handles.grapht2.Position = [205 240 100 20];  

handles.graphf2 = uicontrol(panel,'style','popupmenu');
handles.graphf2.Position = [305 240 100 20];
handles.graphf2.String = {'No options'};
handles.graphf2.Callback = @GraphChoice2;

% Subplot 3
handles.grapht3 = uicontrol(panel,'style','text');
handles.grapht3.String = 'Graphs';
handles.grapht3.Position = [205 180 100 20];  

handles.graphf3 = uicontrol(panel,'style','popupmenu');
handles.graphf3.Position = [305 180 100 20];
handles.graphf3.String = {'No options'};
handles.graphf3.Callback = @GraphChoice3;

%% Extract figures button
% Subplot 1
handles.extract1 = uicontrol(panel,'style','pushbutton');
handles.extract1.String = 'Extract fig 1';
handles.extract1.Position = [100 5 80 20];
handles.extract1.Callback = @extract1;

% Subplot 2
handles.extract2 = uicontrol(panel,'style','pushbutton');
handles.extract2.String = 'Extract fig 2';
handles.extract2.Position = [200 5 80 20];
handles.extract2.Callback = @extract2;

% Subplot 3
handles.extract3 = uicontrol(panel,'style','pushbutton');
handles.extract3.String = 'Extract fig 3';
handles.extract3.Position = [300 5 80 20];
handles.extract3.Callback = @extract3;

%% Default Subplots 
sp1 = subplot(2,2,2);
sp1.FontSize = 18; 
sp2 = subplot(2,2,3);
sp2.FontSize = 18; 
sp3 = subplot(2,2,4);
sp3.FontSize = 18; 

%% Callback functions
    function refresh(src,event)
       % Read and display the input to the plots
       plot1x = handles.typef1x.String{handles.typef1x.Value};
       plot1y = handles.typef1y.String{handles.typef1y.Value};
       plot2x = handles.typef2x.String{handles.typef2x.Value};
       plot2y = handles.typef2y.String{handles.typef2y.Value};
       plot3x = handles.typef3x.String{handles.typef3x.Value};
       plot3y = handles.typef3y.String{handles.typef3y.Value};
       
       disp(['Plot 1: ',plot1x, ' - ',plot1y, '.']);
       disp(['Plot 2: ',plot2x,' - ',plot2y, '.']);
       disp(['Plot 3: ',plot3x,' - ',plot3y, '.']);
       
       if strcmp(plot1x,'Track')
           plotTrack(plot1y,sp1,1)
       elseif strcmp(plot1x,'Distance')
           plotDistance(plot1y,sp1,1)
       elseif strcmp(plot1x, 'Time')
           plotTime(plot1y,sp1,1)
       else
           disp(' This choice is not possible, please select another option.');
       end 
       
       if strcmp(plot2x,'Track')
           plotTrack(plot2y,sp2,2)
       elseif strcmp(plot2x,'Distance')
           plotDistance(plot2y,sp2,2)
       elseif strcmp(plot2x, 'Time')
           plotTime(plot2y,sp2,2)
       else
           disp(' This choice is not possible, please select another option.');
       end 
       
       if strcmp(plot3x,'Track')
           plotTrack(plot3y,sp3,3)
       elseif strcmp(plot3x,'Distance')
           plotDistance(plot3y,sp3,3)
       elseif strcmp(plot3x, 'Time')
           plotTime(plot3y,sp3,3)
       else
           disp(' This choice is not possible, please select another option.');
       end 
    end

    function extract1(src,event)
        graph = handles.graphf1.String{handles.graphf1.Value};
        plot1x = handles.typef1x.String{handles.typef1x.Value};
        plot1y = handles.typef1y.String{handles.typef1y.Value};   
        fig = figure(2);
        SP = subplot(1,1,1);
        SP.FontSize = 18; 
        if strcmp(graph,'All')
            if strcmp(plot1x,'Track')
                plotTrack(plot1y,SP,4)
            elseif strcmp(plot1x,'Distance')
                plotDistance(plot1y,SP,4)
            elseif strcmp(plot1x, 'Time')
                plotTime(plot1y,SP,4)
            else
                disp(' This choice is not possible, please select another option.');
            end 
        else 
            if strcmp(plot1x,'Track')
               updateTrack(plot1y,graph,SP)
           elseif strcmp(plot1x,'Distance')
               updateDistance(plot1y,graph,SP)
           elseif strcmp(plot1x, 'Time')
               updateTime(plot1y,graph,SP)
           end
        end
    end

    function extract2(src,event)
        graph = handles.graphf2.String{handles.graphf2.Value};
        plot2x = handles.typef2x.String{handles.typef2x.Value};
        plot2y = handles.typef2y.String{handles.typef2y.Value};   
        fig = figure(3);
        SP = subplot(1,1,1);
        SP.FontSize = 18; 
        if strcmp(graph,'All')
            if strcmp(plot2x,'Track')
                plotTrack(plot2y,SP,4)
            elseif strcmp(plot2x,'Distance')
                plotDistance(plot2y,SP,4)
            elseif strcmp(plot2x, 'Time')
                plotTime(plot2y,SP,4)
            else
                disp(' This choice is not possible, please select another option.');
            end 
        else 
           if strcmp(plot2x,'Track')
               updateTrack(plot2y,graph,SP)
           elseif strcmp(plot2x,'Distance')
               updateDistance(plot2y,graph,SP)
           elseif strcmp(plot2x, 'Time')
               updateTime(plot2y,graph,SP)
           end           
        end
    end

    function extract3(src,event)
        graph = handles.graphf3.String{handles.graphf3.Value};
        plot3x = handles.typef3x.String{handles.typef3x.Value};
        plot3y = handles.typef3y.String{handles.typef3y.Value};   
        fig = figure(4);
        SP = subplot(1,1,1);
        SP.FontSize = 18; 
        if strcmp(graph,'All')
            if strcmp(plot3x,'Track')
                plotTrack(plot3y,SP,4)
            elseif strcmp(plot3x,'Distance')
                plotDistance(plot3y,SP,4)
            elseif strcmp(plot3x, 'Time')
                plotTime(plot3y,SP,4)
            else
                disp(' This choice is not possible, please select another option.');
            end 
        else
           if strcmp(plot3x,'Track')
               updateTrack(plot3y,graph,SP)
           elseif strcmp(plot3x,'Distance')
               updateDistance(plot3y,graph,SP)
           elseif strcmp(plot3x, 'Time')
               updateTime(plot3y,graph,SP)
           end
        end
   end

    function GraphChoice1(src, event)
        % Read input
         graph1 = handles.graphf1.String{handles.graphf1.Value};
         plot1x = handles.typef1x.String{handles.typef1x.Value};
         plot1y = handles.typef1y.String{handles.typef1y.Value};        
         % Update the figures with correct graph
         if strcmp(graph1,'All')
            
           if strcmp(plot1x,'Track')
               plotTrack(plot1y,sp1,1)
           elseif strcmp(plot1x,'Distance')
               plotDistance(plot1y,sp1,1)
           elseif strcmp(plot1x, 'Time')
               plotTime(plot1y,sp1,1)
           else
               disp(' This choice is not possible, please select another option.');
           end 
            
         else
           if strcmp(plot1x,'Track')
               updateTrack(plot1y,graph1,sp1)
           elseif strcmp(plot1x,'Distance')
               updateDistance(plot1y,graph1,sp1)
           elseif strcmp(plot1x, 'Time')
               updateTime(plot1y,graph1,sp1)
           end
         end
         
    end

    function GraphChoice2(src, event)
        % Read input
         graph2 = handles.graphf2.String{handles.graphf2.Value};
         plot2x = handles.typef2x.String{handles.typef2x.Value};
         plot2y = handles.typef2y.String{handles.typef2y.Value};        
         
         % Update the figures with correct graph
         if strcmp(graph2,'All')
            
           if strcmp(plot2x,'Track')
               plotTrack(plot2y,sp2,2)
           elseif strcmp(plot2x,'Distance')
               plotDistance(plot2y,sp2,2)
           elseif strcmp(plot2x, 'Time')
               plotTime(plot2y,sp2,2)
           else
               disp(' This choice is not possible, please select another option.');
           end 
            
         else
           if strcmp(plot2x,'Track')
               updateTrack(plot2y,graph2,sp2)
           elseif strcmp(plot2x,'Distance')
               updateDistance(plot2y,graph2,sp2)
           elseif strcmp(plot2x, 'Time')
               updateTime(plot2y,graph2,sp2)
           end
         end        
    end

    function GraphChoice3(src, event)
        % Read input
         graph3 = handles.graphf3.String{handles.graphf3.Value};
         plot3x = handles.typef3x.String{handles.typef3x.Value};
         plot3y = handles.typef3y.String{handles.typef3y.Value};        
         % Update the figures with correct graph
         if strcmp(graph3,'All')
            
           if strcmp(plot3x,'Track')
               plotTrack(plot3y,sp3,3)
           elseif strcmp(plot3x,'Distance')
               plotDistance(plot3y,sp3,3)
           elseif strcmp(plot3x, 'Time')
               plotTime(plot3y,sp3,3)
           else
               disp(' This choice is not possible, please select another option.');
           end 
            
         else
           if strcmp(plot3x,'Track')
               updateTrack(plot3y,graph3,sp3)
           elseif strcmp(plot3x,'Distance')
               updateDistance(plot3y,graph3,sp3)
           elseif strcmp(plot3x, 'Time')
               updateTime(plot3y,graph3,sp3)
           end
         end
        
    end
end 

