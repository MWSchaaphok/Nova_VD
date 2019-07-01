%% Main file for Data analysis
%  This file creates an information sheet (.text file) that contains
%  information about a certain data set.
%  If the data set already contains a information sheet it loads a dataset
%  Does some basic computations on the data 
%  Makes GUI for figure plots 
%  By: Marianne Schaaphok
%  Year: 2019

clear all
close all 
addpath('Spherical2AzimuthalEquidistant');
addpath(genpath('Functions'))
addpath('Data')
global Velocity Angle gps BMS_V BMS_C BMS_T MC_m MC_PS MC Xs Ys GyroAccel distance 
global MC_Current MC_Speed MC_Voltage MC_Flux MC_Fault MC_Torque 
global handles parsed_osm img_filename

%% Create data information sheet or load data
% Check if a data information sheet already exists.
Datasheet = 'Does this dataset already have a corresponding information sheet (.txt)? [yes,no,y,n]';
datasheet = input(Datasheet);

% If not yet created, create data information sheet
if strcmp(datasheet,'no') || strcmp(datasheet,'n')|| strcmp(datasheet,'No')
    fprintf('Please fill out the following form\n')
    [data,canceled] = DataInformationInput();

    % If data input is cancelled
    if canceled ==1
        fprintf('Data input has been cancelled, no information will be saved \n')
        return
    end

    % Create information text file
    SaveTextFile(data)

    % Load the selected data file
    %dataset = load(data.DAQfile);
    if strcmp(data.DAQfile(end-3:end),'.csv')
        fprintf('Reading CSV file...\n');
        try
            [gps,Angle,GyroAccel,BMS_V,BMS_C,BMS_T,MC_m,MC_PS,MC_Current,MC_Speed,MC_Voltage, MC_Flux, MC_Fault, MC_Torque] =readDAQcsv_new(data.DAQfile);
        catch
            [gps,LV,BMS_V,BMS_C,BMS_T,Acc,MC_m,MC_PS,MC_air,MC,Gyro] = readDAQcsv_old(data.DAQfile);
            MC_Speed.t = [];
            MC_Speed.speed = [];
            MC_Current.t = [];
            MC_Current.c = [];
            MC_Voltage.volt = [];
            MC_Flux.t = [];
            MC_Flux.flux = [];
            MC_Fault.t = [];
            MC_Fault.F = [];
            MC_Torque.t = [];
            MC_Torque.T = [];
        end
            fprintf('Finished reading\n');
    else
        fprintf('Loading matlab file...\n')
        load(data.DAQfile)
        fprintf('Finished reading\n');
    end

    % Else choose data file
else
    fprintf('Load a file (*.csv,*.mat,*.m)\n')
    [file,path] = uigetfile({'*.csv'});
    if isequal(file,0)
        fprintf('User selected Cancel\n');
        return
    else
        fprintf('User selected a file \n');
        %dataset = load(fullfile(path,file));
    end
    if strcmp(file(end-3:end),'.csv')
        fprintf('Reading CSV file...\n');        
        try
            [gps,Angle,GyroAccel,BMS_V,BMS_C,BMS_T,MC_m,MC_PS,MC_Current,MC_Speed,MC_Voltage, MC_Flux, MC_Fault, MC_Torque] =readDAQcsv_new(fullfile(path,file));
        catch
            [gps,LV,BMS_V,BMS_C,BMS_T,Acc,MC_m,MC_PS,MC_air,MC,Gyro] = readDAQcsv_old(fullfile(path,file));
            MC_Speed.t = [];
            MC_Speed.speed = [];
            MC_Current.t = [];
            MC_Current.c = [];
            MC_Voltage.t = [];
            MC_Voltage.volt = [];
            MC_Flux.t = [];
            MC_Flux.flux = [];
            MC_Fault.t = [];
            MC_Fault.F = [];
            MC_Torque.t = [];
            MC_Torque.T = [];
        end
        %[gps,Acc,Gyro,BMS_V,BMS_C,BMS_T,MC_m,MC_PS,MC_Current,MC_Speed,MC_Voltage, MC_Flux, MC_Fault, MC_Torque] = readDAQcsv(fullfile(path,file));
        fprintf('Finished reading\n');
    else
        fprintf('Loading matlab file...\n')
        load(fullfile(path,file))
        fprintf('Finished reading\n');
    end

end
% List of available variables for the dropdown menus in the GUI
var_list = {'gps','Angle','GyroAccel','Velocity','BMS_V','BMS_C','BMS_T','MC_m','MC_PS'...
        ,'MC_Current','MC_Speed','MC_Voltage','MC_Flux', 'MC_Fault', 'MC_Torque'};
%% Computations on GPS 

% Transform lon-lat gps coordinates to x,y coordinates and to curv,distance
if isempty(gps.longitude)
    fprintf('No GPS data available\n')
else

    [Xs, Ys] = Spherical2AzimuthalEquidistant(gps.latitude,gps.longitude, 52.57299, 6.31205, ...
                    0, 0, 6364552);
    Xs = Xs - Xs(1);
    Ys = Ys - Ys(1); 
    
    %Compute distance
    % Convert to radians
    lat = gps.latitude/180*pi;
    lon = gps.longitude/180*pi; 
    
    % Formula for distance from long-lat coordinates 
    distance(1) = 0;
    for i = 1 : length(gps.longitude)-1
        distance(i+1) =  2*asin(sqrt((sin((lat(i)-lat(i+1))/2))^2 + ... 
                 cos(lat(i))*cos(lat(i+1))*(sin((lon(i)-lon(i+1))/2))^2));
    end 
    
    distance = distance*60*180/pi*1.852*1000;         % Convert to meters 
    distance = cumsum(abs(distance)); 
end  
%% Computations velocity/angles
% Compute velocity from GPS data and from Accelerations 
Velocity.t = gps.t;
Velocity.x_gps = [0;diff(distance)'./diff(gps.t)]*3.6;
Velocity.x_acc = cumtrapz(GyroAccel.IAx*9.81);

% Use complementary filter to combine information for the angles:
% filtered_angle = HPF*( filtered_angle + w* dt) + LPF*(angle_accel); where HPF + LPF = 1
% We use HPF = 0.98, LPF = 0.02
% https://www.instructables.com/id/Angle-measurement-using-gyro-accelerometer-and-Ar/
HPF = 0.98; 
LPF = 0.02; 

lean = zeros(size(GyroAccel.t));
pitch = zeros(size(GyroAccel.t));
yaw = zeros(size(GyroAccel.t));
for i = 2:length(GyroAccel.t)
    lean(i) = HPF*(lean(i-1) + (GyroAccel.t(i)-GyroAccel.t(i-1))*GyroAccel.Gy(i)) + LPF*Angle.AccelIY(i);
    yaw(i) = HPF*(yaw(i-1) + (GyroAccel.t(i)-GyroAccel.t(i-1))*GyroAccel.Gx(i)) + LPF*Angle.AccelIX(i);
    pitch(i) = HPF*(pitch(i-1) + (GyroAccel.t(i)-GyroAccel.t(i-1))*GyroAccel.Gz(i)) + LPF*Angle.AccelIZ(i);   
end
Angle.lean = lean;
Angle.pitch = pitch; 
Angle.yaw = yaw;
%% Interpolate everything with respect to the distance computed from gps 
Angle.dist      = interp1(gps.t,distance,Angle.t,'spline','extrap');
Velocity.dist   = interp1(gps.t, distance, Velocity.t,'spline','extrap');
BMS_V.dist      = interp1(gps.t,distance,BMS_V.t,'spline','extrap');
BMS_C.dist      = interp1(gps.t,distance,BMS_C.t,'spline','extrap');
BMS_T.dist      = interp1(gps.t,distance,BMS_T.t,'spline','extrap');
MC_m.dist       = interp1(gps.t,distance,MC_m.t,'spline','extrap');
MC_PS.dist      = interp1(gps.t,distance,MC_PS.t,'spline','extrap');
MC_Speed.dist   = interp1(gps.t,distance,MC_Speed.t,'spline','extrap');
MC_Current.dist = interp1(gps.t,distance,MC_Current.t,'spline','extrap');
MC_Voltage.dist = interp1(gps.t,distance,MC_Voltage.t,'spline','extrap');
MC_Fault.dist   = interp1(gps.t,distance,MC_Fault.t,'spline','extrap');
MC_Flux.dist    = interp1(gps.t,distance,MC_Flux.t,'spline','extrap');
MC_Torque.dist  = interp1(gps.t,distance,MC_Torque.t,'spline','extrap');
GyroAccel.dist  = interp1(gps.t,distance,GyroAccel.t,'spline','extrap');

%% Make sectors + Plot on Map
% Plot the GPS data 
%Map = 'Do you want to plot the gps data on the map? [yes,no,y,n]';
%map = input(Map);

% For sector definitions
%Trackname = 'Select one of the following tracks in order to plot sectors [Assen, ]';
%track_name = input(Trackname);

%if strcmp(map,'yes') || strcmp(map,'y')|| strcmp(map,'Yes')
%    [~,Sector,S_nr]= PlotMap(track_name,gps,distance);
%else
try 
    [Sector,S_nr] = Sectors(gps,track_name,distance);
catch
    fprintf('No sectors available\n')
    Sector = [];
    S_nr = 0;
end
%end 

%% Separate laps
if S_nr == 0 
    fprintf('No sectors available to seperate laps')
else 
    fprintf('Assuming first sector starts at the start/finish line')
    
    fprintf('Laps seperated')
end

%% Make GUIs
% Plot 3 subplot GUI for time/distance/track plotting
[f,sp1,sp2,sp3,handles] = plotUIfigure(S_nr,Sector,var_list);

% Plot 4 subplot distance channel GUI
[f_ch,ch_sp1,ch_sp2,ch_sp3,ch_sp4,ch_hndls] = plotChannelfigure(Sector, S_nr,var_list);

% Default plots - velocity along track + max speed reached
%               - acceleration over distance
%               - BMS-voltage over distance

% plotTrack('GPS',sp1,1);
% handles.typef1x.Value = 1;
% handles.typef1y.Value = 1;
% 
% plotDistance('BMS_T',sp2,2)
% handles.typef2x.Value = 2; 
% handles.typef2y.Value = 7; 
% 
% plotTime('GyroAccel',sp3,3)
% handles.typef3x.Value = 3; 
% handles.typef3y.Value = 2;

