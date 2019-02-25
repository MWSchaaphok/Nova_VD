function [t, path, v] = GenerateTrajectory()
%% This function optimizes the raceline within a given path +- 5m of boundaries. 
%  Inputs:  Track, defined by distance ([ds_1,ds_2,...,ds_n]) and curvature at each of the distance points. 
%           Starting speed v_0 -> still needs to be added
%           Motorcycle parameters 
%           Tolerance for the optimization
%  Outputs: Path, optimized raceline along the track
%           Laptime for optimized path
%           Velocity profile for optimized path

% The inner and outer boundary of the track are defined by starting
% curavture +- 5 m, for good results give the first curvature as the middle
% of the track.

%% Load bike variables 
% Maybe add input possibilities?
par = parameters();             % Motorcycle parameters 
tol = 0.05 ;                    % Tolerance for optimizing laptime 
v_0 = 0;                        % Start velocity - default = 0

%% Ask for input: track, number of laps, discretization step. Load track
% Note! Track should be defined as [ds_1,ds_2,...,ds_n]
track = 'At which track do you want to simulate the race? [Assen,Straight,Corner]';
track_n = input(track);
track_n = cellstr(track_n);

if strcmp(track_n{1}, 'Straight') 
    load('Assen_straight_1.mat');
elseif strcmp(track_n{1},'Corner')
    load('StraightCorner2.mat');
elseif strcmp(track_n{1},'Assen')
    load('Assen_middle.mat');
end

 
%% Adapt track array 
d_dist  = dist;
curv    = [curv(1),curv];
dist    = cumsum([0,dist]);
 
%% Define inner and outer boundaries
% For simplicity distance boundaries and middle line is equal 5m.
% Can later be asked as an input as well
w_in    = ones(size(curv))*5;
w_out   = ones(size(curv))*-5;

% Define path structure
path.dist   = dist; 
path.ds     = d_dist; 
path.curv   = curv; 
path.win    = w_in;
path.wout   = w_out; 

% Define and save track
psi_track       = cumtrapz(path.dist,path.curv);
path.N_track    = cumtrapz(path.dist, cos(psi_track));
path.E_track    = cumtrapz(path.dist, -sin(psi_track));

%% Find starting laptime
v       = CalculateSpeedProfile(path,par,v_0);
[t,tc]  = ComputeLapTime(v,path);
dt      = 10;                            

% Velocity profile first raceline
figure; 
plot(dist,v);

%% Optimization loop 
i=0; 
while abs(dt) > tol 
   temp_t       = tc(end); 
   %v           = CalculateSpeedProfile(path,par,v_0);
   [path]       = MinimizeCurvature(v,path,par,tc);
   v            = CalculateSpeedProfile(path,par,v_0);
   [t,tc]       = ComputeLapTime(v,path);
   dt           = temp_t-tc(end); 
   i            = i+1; 
end

fprintf("Number of iterations is " + num2str(i));

end