function [f,sp1,sp2,sp3,handles] = plotUIfigure()

%% Initialization
%global Velocity Acc GPS LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys
f = figure('units','normalized','outerposition',[0 0 1 1]);
panel = uipanel(f,'Position',[0.12 0.52 0.35 0.45]);

%% Handles subfigure 1 
handles.textf1 = uicontrol(panel,'style','text');
handles.textf1.String = 'Options figure 1';
%handles.textf1.Position = [190 720 100 20];    
handles.textf1.Position = [5 320 100 20];

% Xlabel
handles.xlabelf1 = uicontrol(panel,'style','text');
handles.xlabelf1.String = 'Xlabel';
handles.xlabelf1.Position = [5 300 100 20];  

handles.typef1x = uicontrol(panel,'style','popupmenu');

handles.typef1x.Position = [105 300 100 20];
handles.typef1x.String = {'Track','Distance','Time'};
%handles.typef1x.Callback = @selection;

% Y-label 
handles.ylabelf1 = uicontrol(panel,'style','text');
handles.ylabelf1.String = 'Ylabel';
handles.ylabelf1.Position = [5 280 100 20]; 

handles.typef1y = uicontrol(panel,'style','popupmenu');

handles.typef1y.Position = [105 280 100 20];
handles.typef1y.String = {'Velocity','Acc','GPS','LV','BMS_V','BMS_C','BMS_T','MC_m','MC_PS','MC_air','MC'};
%handles.typef1y.Callback = @selection;

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
%handles.typef2x.Callback = @selection;

% Y-label 
handles.ylabelf2 = uicontrol(panel,'style','text');
handles.ylabelf2.String = 'Ylabel';
handles.ylabelf2.Position = [5 220 100 20]; 

handles.typef2y = uicontrol(panel,'style','popupmenu');

handles.typef2y.Position = [105 220 100 20];
handles.typef2y.String = {'Velocity','Acc','GPS','LV','BMS_V','BMS_C','BMS_T','MC_m','MC_PS','MC_air','MC'};
%handles.typef2y.Callback = @selection;


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
%handles.typef3x.Callback = @selection;

% Y-label 
handles.ylabelf3 = uicontrol(panel,'style','text');
handles.ylabelf3.String = 'Ylabel';
handles.ylabelf3.Position = [5 160 100 20]; 

handles.typef3y = uicontrol(panel,'style','popupmenu');

handles.typef3y.Position = [105 160 100 20];
handles.typef3y.String = {'Velocity','Acc','GPS','LV','BMS_V','BMS_C','BMS_T','MC_m','MC_PS','MC_air','MC'};
%handles.typef3y.Callback = @selection;


%% Refresh button
handles.refresh = uicontrol(panel,'style','pushbutton');
handles.refresh.String = 'Refresh';
handles.refresh.Position = [440 5 80 20];
handles.refresh.Callback = @refresh;


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
           plotTrack(plot1y,sp1)
       elseif strcmp(plot1x,'Distance')
           plotDistance(plot1y,sp1)
       elseif strcmp(plot1x, 'Time')
           plotTime(plot1y,sp1)
       else
           disp(' This choice is not possible, please select another option.');
       end 
       
       if strcmp(plot2x,'Track')
           plotTrack(plot2y,sp2)
       elseif strcmp(plot2x,'Distance')
           plotDistance(plot2y,sp2)
       elseif strcmp(plot2x, 'Time')
           plotTime(plot2y,sp2)
       else
           disp(' This choice is not possible, please select another option.');
       end 
       
       if strcmp(plot3x,'Track')
           plotTrack(plot3y,sp3)
       elseif strcmp(plot3x,'Distance')
           plotDistance(plot3y,sp3)
       elseif strcmp(plot3x, 'Time')
           plotTime(plot3y,sp3)
       else
           disp(' This choice is not possible, please select another option.');
       end 
   end

end 

