%function [value] = InformationSheetInput()
%%  Function information
%%% This function creates an pop-up window where the user must input all the
%%% information about the data set they want load from the DAQ unit. 

%% Create pop-up window
    d = dialog('Position',[50 50 800 750],'Name','Data Information Sheet');
    d.Resize = 'off';
    guidata(d,data); 
%% Create static text and save button 
    txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[80 650 600 60],...
               'String','Please fill out all the information corresponding to this data set.       If you are finished press "Save"');
    txt.FontSize = 15;
    
    
    btn = uicontrol('Parent',d,...
               'Position',[300 20 80 35],...
               'String','Save',...
               'Callback',@(usr_name)SaveInput);
    btn.FontSize = 15;
    
%% Input name user 
    name = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[80 600 300 30],...
               'String','Your name');
    name.FontSize = 13;
   
    usr_name = uieditfield('Parent',d,...
                    'Position',[80 580 300 25],...
                    'Tag','usr_name',...
                    'ValueChangedFcn',@(data,usr_name)NameChange(data,usr_name));

%end

function NameChange(data,usr_name)
    
    fprintf('I am in Saveinput')
    %data = str2double(get(handles.usr_name, 'String'));
    data.name.Value = usr_name.Value;
    fprintf('I did get handle')
    delete(gcf);
    fprintf('I deleted stuff, i think')
end 