function [t, path, v] = GenerateTrajectory()
%% This function optimizes the raceline within a given path +- 5m of boundaries. 
%  Inputs:  Track, defined by distance ([ds_1,ds_2,...,ds_n]) and curvature at each of the distance points.
%           Number of laps, for optimization only 1 lap is necessary 
%           Starting speed v_0 -> still needs to be added
%           Motorcycle parameters 
%           Tolerance for the optimization
%  Outputs: Path, optimized raceline along the track
%           Laptime for optimized path
%           Velocity profile for optimized path

%% Load bike variables 
% Maybe add input possibilities?
par = parameters();             % Motorcycle parameters 
tol = 0.05 ;                    % Tolerance for optimizing laptime 

%% Ask for input: track, number of laps, discretization step. Load track
% Note! Track should be defined as [ds_1,ds_2,...,ds_n]
track = 'At which track do you want to simulate the race? [Assen,Assen_optimal, Assen_middle,Straight]';
track_n = input(track);
track_n = cellstr(track_n);

if strcmp(track_n{1}, 'Straight') 
    load('Assen_straight_1.mat');
elseif strcmp(track_n{1},'Corner')
    load('StraightCorner2.mat');
    curv3 = curv; 
    curv4 = curv; 
end

 
%% Adapt track array 
% Make a distance array for not equidistant distance profiles 
dis_temp = [dist];

if strcmp(track_n{1}, 'Corner') || strcmp(track_n{1},'Straight')
    dist = dis_temp;
else 
    dist = cumsum(dis_temp);
end
 
%% Define inner and outer boundaries
% For simplicity distance boundaries and middle line is equal 5m. 
%dist = dist(1:end-2);
%curv4 = curv4(1:end-2); 

w_in = ones(size(curv4))*5;
w_out = ones(size(curv4))*-5;

% Define path structure

path.dist = dist; 
path.curv = curv4; 
path.win = w_in;
path.wout = w_out; 


%% Find starting laptime
v = CalculateSpeedProfile(path,par);
[t,tc] = ComputeLapTime(v,path);
dt = 10;                            % Starting dt
figure; plot(dist,v);

%% Optimization loop 
i=0; 
while abs(dt) > tol 
   temp_t = tc(end); 
   v = CalculateSpeedProfile(path,par);
   [path,v2] = MinimizeCurvature(v,path,par,tc);
   [t,tc] = ComputeLapTime(v2,path);
   dt = temp_t-tc(end); 
   i = i+1; 
end
fprintf("Number of iterations is " + num2str(i));


end