function [data,canceled] = DataInformationInput()
%% Function information
%%% This function creates an pop-up window where the user must input all the
%%% information about the data set they want load from the DAQ unit.
%%% Using code from Kesh Ikuma [Matlab]
%%% Returns a structure data that contains all the input and a logical
%%% value whether the data input was canceled. 
    
addpath('InputFunctions');

%% General properties
    Title = 'DAQ data information';

    % Define options for the pop-up menu
    %Options.WindowStyle = 'modal';
    Options.Resize = 'on';
    Options.Interpreter = 'tex';
    Options.CancelButton = 'off';
    Options.ApplyButton = 'off';
    Options.ButtonNames = {'Continue'}; 
    %Option.Dim = 4; % Horizontal dimension in fields

    Prompt = {};
    Formats = {};
    DefAns = struct([]);

%% Information for user 
    i = 1;
    Prompt(i,:) = {['-------------------------------------------------------- GENERAL INFORMATION -----------------------------------------------'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];
    i = i+1;
    
    Prompt(i,:) = {['Fill out the following fields for the data set you want to import.'... 
                    ' Press "Apply" and "Continue" after you have finished'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2]; 
    i = i+1;
%% General input
    % User name
    Prompt(i,:) = {'Name', 'Name',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'text';
    Formats(i,1).size = 200; % automatically assign the height
    DefAns(1).Name = '';
    i = i+1;
    
    % Current date
    Prompt(i,:) = {'Test date (dd-mmm-yyyy)', 'Date',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'date';
    Formats(i,1).limits = 'dd-mmm-yyyy'; % with time: 'dd-mmm-yyyy HH:MM:SS'
    Formats(i,1).size = 100;
    DefAns.Date = date;
    i = i+1;
    
    Prompt(i,:) = {['Load file (*.csv *.mat *.m), click to choose another file'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2]; 
    i = i+1;
    
    % Load file
    Prompt(i,:) = {'DAQ file','DAQfile',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'file';
    %Formats(i,1).items = {'*.daq','DAQ File (*.daq)';'*.csv*','CSV file (*.csv)';'*.*','All Files'};
    Formats(i,1).items = {'*.csv'};
    Formats(i,1).limits = [0 1]; % single file get
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];  % item is 1 field x 3 fields
    d = dir;
    files = strcat([pwd filesep],{d(~[d.isdir]).name});
    DefAns.DAQfile = files{1};
    i = i+1;
    
%% Test input
    Prompt(i,:) = {['------------------------------------------------------- TEST INFORMATION -----------------------------------------------------'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];
    i = i+1;
    
    % Test Location
    Prompt(i,:) = {'Type of test','TestType',[]};
    Formats(i,1).type = 'list';
    Formats(i,1).format = 'text';
    Formats(i,1).style = 'radiobutton';
    Formats(i,1).items = {'Dynometer'; 'Track';'Other'};
    %Formats(5,1).span = [2 1];  % item is 2 field x 1 fields
    i = i+1;
    
    % Track information
    Prompt(i,:) = {['If the test was performed on the track, please specify'...
                    ' the following, otherwise ignore these fields.'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];  
    i = i+1;
    
    % Track name
    Prompt(i,:) = {'Track Name', 'Track',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'text';
    Formats(i,1).size = 200; % automatically assign the height
    i = i+1;
    
    % Number of Laps
    Prompt(i,:) = {'Number of Laps', 'Laps',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'integer';
    Formats(i,1).size = 200; % automatically assign the height
    i = i+1;
    
    % Weather information
    Prompt(i,:) = {'Please specify the weather conditions', [],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    i = i+1;
    
    % Weather type
    Prompt(i,:) = {'Type','WeatherType',[]};
    Formats(i,1).type = 'list';
    Formats(i,1).format = 'text';
    Formats(i,1).style = 'radiobutton';
    Formats(i,1).items = {'Sunny','Dry','Drizzle','Rain'};
    i = i+1;
    
    % Temperature
    Prompt(i,:) = {'Temperature (C)', 'Temperature',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'float';
    Formats(i,1).size = 200; % automatically assign the height
    i = i+1;
    
    % Wind speed
    Prompt(i,:) = {'Wind Force (0-8)', 'WindForce',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'float';
    Formats(i,1).size = 200; % automatically assign the height
    i = i+1;   
    
    % Track conditions
    Prompt(i,:) = {'Track Conditions','TrackConditions',[]};
    Formats(i,1).type = 'list';
    Formats(i,1).format = 'text';
    Formats(i,1).style = 'radiobutton';
    Formats(i,1).items = {'Dry','Wet'};
    i = i+1;
    
%% Motorcycle parameters
    Prompt(i,:) = {['------------------------------------------------------- MOTORCYCLE INFORMATION  ----------------------------------------------------'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];
    i = i+1;
    
    Prompt(i,:) = {['Please specify the following motorcycle parameters'],[],[]};
    Formats(i,1).type = 'text';
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];
    i = i+1;
    
    % Tire Compound
    Prompt(i,:) = {'Tire Compound','TireCompound',[]};
    Formats(i,1).type = 'list';
    Formats(i,1).format = 'text';
    Formats(i,1).style = 'radiobutton';
    Formats(i,1).items = {'Soft','Medium','Hard'};
    i = i+1;
    
    % Tire pressure
    Prompt(i,:) = {'Tire Pressure [?]', 'TirePressure',[]};
    Formats(i-1,2).type = 'edit';
    Formats(i-1,2).format = 'float';
    Formats(i-1,2).size = 200;
    DefAns.TirePressure = {};
    i = i+1;
    
    % Gear ratio
    Prompt(i,:) = {'Gear ratio', 'GearRatio',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'float';
    Formats(i,1).size = 200;
    DefAns.GearRatio = 1/1.9;   
    i = i+1;
    
    % Extra notes on the test
    Prompt(i,:) = {'Notes','Notes',[]};
    Formats(i,1).type = 'edit';
    Formats(i,1).format = 'text';
    Formats(i,1).limits = [0 9]; % default: show 20 lines
    Formats(i,1).size = [-1 0];
    Formats(i,1).span = [1 2];  
    
    %% Run everything  
    [data,canceled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);
end 