%% Laptime simulation model 
% Author: Anoosh Hegde (September 2017 - August 2018)
% Edited and expanded by: Marianne Schaaphok (October 2018 - )
% Last modified: 25-10-2018
% Based on approach from: ...... 
%
% This model computes the laptime of a motorcycle for a number of laps
% around a specificied track. 
%
% ASSUMPTIONS
function [laptime] = Laptime_FB(track, laps, l1,h) 

par = parameters(); 
par.l1 = l1;
disp('par_l1 = ')
par.l1
par.l2 = 1 - par.l1; 
par.c_h = h; 
par.h = par.c_h*par.b;
disp('par.h = ')
par.h
%% Ask for input: track, number of laps, discretization step. Load track
%track = 'At which track do you want to simulate the race? [Assen,Assen_optimal, Assen_middle,Straight]';
track_n = track;
%track_n = 'Straight'; %'Assen';
%track_n = cellstr(track_n);
%laps = 'How many laps do you want the simulations to run for? [1-20]';
n_lap = laps;
ds = par.ds;

if strcmp(track_n, 'Straight') 
    %load([track_n{1},'_track_ds_',num2str(par.ds),'.mat']);
    %load('Assen_straight_1.mat');
    load('Assen_straight_corner');
elseif strcmp(track_n, 'Assen')
    load([track_n,'track_ds_',num2str(ds),'.mat']);
	curv3 = curv;
	curv4 = curv;
elseif strcmp(track_n,'Assen_optimal')
    load([track_n,'track_ds_',num2str(ds),'.mat']);
	curv3 = curv;
	curv4 = curv;
elseif strcmp(track_n, 'Assen_middle')
    load([track_n,'track_ds_',num2str(ds),'.mat']);
	curv3 = curv;
	curv4 = curv;
end

% Load bike constants
%run bike_constants.m
  
%% Adapt track array to desired no of laps. 

temp_curv4 = [curv4];
for i = 2:n_lap
    temp_curv4 = [temp_curv4 curv4(2:end)];
end

% Make a distance array for not equidistant distance profiles for n number of laps.  

dis_temp = [dist];
for i=2:n_lap
    dis_temp = [dis_temp dist(2:end)];
end
if strcmp(track_n, 'Straight') 
    dist = dis_temp;
else 
    dist = cumsum(dis_temp);
end

curv4 = temp_curv4;

%% Compute acceleration and velocity profile based on Forward Backward Pass method.
tic;
[v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPassCh(curv4,par);
toc

%% Computation and plot Lap times
[lapt,lapstr] = Laptime(v_dec,curv3,curv4,n_lap,par);
laptime = lapt(1); 
% ax = subplot(3, 2, 5);
% text(0.5,0.5,lapstr);
% set ( ax, 'visible', 'off')

