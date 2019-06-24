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
addpath(genpath('InputFunctions'));
addpath('Data')
global Velocity Acc gps LV BMS_V BMS_C BMS_T MC_m MC_PS MC_air MC Xs Ys Gyro distance  
global handles parsed_osm img_filename

%% Temporary (needs to be incorporated)
% For plotting map in the background of the GPS coordinates
track_name = 'Assen';

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
        [gps,LV,BMS_V,BMS_C,BMS_T,Acc,MC_m,MC_PS,MC_air,MC] = readDAQcsv(data.DAQfile);
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
        [gps,LV,BMS_V,BMS_C,BMS_T,Acc,MC_m,MC_PS,MC_air,MC,Gyro] = readDAQcsv(fullfile(path,file));
        fprintf('Finished reading\n');
    else
        fprintf('Loading matlab file...\n')
        load(fullfile(path,file))
        fprintf('Finished reading\n');
    end
    save([file(1:end-3),'.mat'],'gps','LV','BMS_V','BMS_C','BMS_T','Acc',...
        'MC_m','MC_PS','MC_air','MC');
end

% Plot the GPS data 
Map = 'Do you want to plot the gps data on the map? [yes,no,y,n]';
map = input(Map);

if strcmp(map,'yes') || strcmp(map,'y')|| strcmp(map,'Yes')
    [~,Sector,S_nr]= PlotMap(track_name,gps);
else
    try 
        [Sector,S_nr] = Sectors(gps,track_name);
    catch
        fprintf('No sectors available')
        Sector = [];
        S_nr = 0;
    end
end 

%% Computations on GPS 

% Transform lon-lat gps coordinates to x,y coordinates and to curv,distance
if isempty(gps.longitude)
    fprintf('No GPS data available\n')
else
    % This conversion is not yet correct
    %lon_ref = gps.longitude(1);                                       % Set 0 on x-axis
    %lat_ref = gps.latitude(1);                                        % Set 0 on y-axis
    %x = (gps.longitude - lon_ref).*(40075000.0/(2*pi)).*cos(lat_ref); % Convert to x coordinates
    %y = (gps.latitude - lat_ref).*(40007000.0/(2*pi));                % Convert to y coordinates
    %[x,y] = grn2eqa(gps.latitude,gps.longitude);
    %plot(x,y);
    [Xs, Ys] = Spherical2AzimuthalEquidistant(gps.latitude,gps.longitude, 52.57299, 6.31205, ...
                    0, 0, 6364552);
    Xs = Xs - Xs(1);
    Ys = Ys - Ys(1); 
    
    % Compute and plot the track 
    load('Assen_middle_1m.mat');
    % Adapt track array 
    curv_track    = [curv(1),curv];
    dist_track    = cumsum([0,dist]);
   
    % Define and save track
    psi_track  = cumtrapz(dist_track,curv_track);
    N_track    = cumtrapz(dist_track, cos(psi_track));
    E_track    = cumtrapz(dist_track, -sin(psi_track));
    
    %plot(Xs,Ys);
    %hold on
    %plot(E_track,N_track,'k--');
    %hold on
    %[x_left,y_left]     = para_curves(E_track,N_track,-5);
    %[x_right,y_right]   = para_curves(E_track,N_track,5);
    %plot(x_left,y_left,'k-','HandleVisibility','off')
    %plot(x_right,y_right,'k-','HandleVisibility','off')
    %axis equal 
    %xlabel('E')
    %ylabel('N')
    %hold off

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
    distance = cumsum(distance); 
    
    %Compute curvature from (E,N) coordinates 
    %%%%% STILL NEED TO DEFINE LEFT RIGHT CURVES%%%%
    
    curvature = [0]; % Assume first meter are straight
    for i = 2:length(Xs)-1
        % First check if points are collinear
        xy = [Xs(i-1:i+1,1) Ys(i-1:i+1,1)];
        collinear = pointsAreCollinear(xy);
        if collinear 
        curvature = [curvature,0];        
        else 
            a = sqrt((xy(1,1)-xy(2,1))^2 + (xy(1,2)-xy(2,2))^2);
            b = sqrt((xy(2,1)-xy(3,1))^2 + (xy(2,2)-xy(3,2))^2);
            c = sqrt((xy(3,1)-xy(1,1))^2 + (xy(3,2)-xy(1,2))^2);
            k = sqrt((a+(b+c))*(c-(a-b))*(c+(a-b))*(a+(b-c))) / 4 ;    % Heron's formula for triangle's surface
            den = a*b*c;  % Denumerator; make sure there is no division by zero.
            if den == 0.0  % Very unlikely, but just to be sure
                curvature = [curvature, 0];
            else
                curvature = [curvature 4*k / den];
            end
        end 
    end 
    curvature = [real(curvature),real(curvature(end))];
end 
%figure
%plot(distance,curvature)


 % Define and save track
% psi2  = cumtrapz(distance,curvature);
% N2    = cumtrapz(distance, cos(psi2));
% E2    = cumtrapz(distance, -sin(psi2));
% plot(E2,N2)

%% Computations velocity/roll
Velocity.t = gps.t;
%Velocity.x = cumtrapz(Acc.t,Acc.x);
%Velocity.y = cumtrapz(Acc.t,Acc.y);
%Velocity.z = cumtrapz(Acc.t,Acc.z);

Velocity.x = [0;diff(distance)'./diff(gps.t)]*3.6;

%% Interpolate everything with respect to the distance computed from gps 
Acc.dist        = interp1(gps.t,distance,Acc.t,'spline','extrap');
Velocity.dist   = interp1(gps.t, distance, Velocity.t,'spline','extrap');
LV.dist         = interp1(gps.t,distance,LV.t,'spline','extrap');
BMS_V.dist      = interp1(gps.t,distance,BMS_V.t,'spline','extrap');
BMS_C.dist      = interp1(gps.t,distance,BMS_C.t,'spline','extrap');
BMS_T.dist      = interp1(gps.t,distance,BMS_T.t,'spline','extrap');
MC_m.dist       = interp1(gps.t,distance,MC_m.t,'spline','extrap');
MC_PS.dist      = interp1(gps.t,distance,MC_PS.t,'spline','extrap');
MC_air.dist     = interp1(gps.t,distance,MC_air.t,'spline','extrap');
MC.dist         = interp1(gps.t,distance,MC.t,'spline','extrap');
Gyro.dist       = interp1(gps.t,distance,Gyro.t,'spline','extrap');

%% Plot data

[f,sp1,sp2,sp3,handles] = plotUIfigure(S_nr);

% Default plots - velocity along track + max speed reached
%               - acceleration over distance
%               - BMS-voltage over distance

plotTrack('GPS',sp1,1);
handles.typef1x.Value = 1;
handles.typef1y.Value = 3;

plotDistance('BMS_T',sp2,2)
handles.typef2x.Value = 2; 
handles.typef2y.Value = 7; 

plotTime('Acc',sp3,3)
handles.typef3x.Value = 3; 
handles.typef3y.Value = 2;

%% Functions 
function [collinear] = pointsAreCollinear(xy)
    collinear = 0; 
    if rank(xy(2:end,:) - xy(1,:)) == 1
       collinear = 1; 
    end 
end 
