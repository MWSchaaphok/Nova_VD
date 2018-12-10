function [t, path, v] = GenerateTrajectory()

%% Load bike variables 

par = parameters();
tol = 0.1 ;                 % tolerance for optimizing laptime 

%% Ask for input: track, number of laps, discretization step. Load track
track = 'At which track do you want to simulate the race? [Assen,Assen_optimal, Assen_middle,Straight]';
track_n = input(track);
track_n = cellstr(track_n);

ds = par.ds;

if strcmp(track_n{1}, 'Straight') 
    %load([track_n{1},'_track_ds_',num2str(par.ds),'.mat']);
    %load('Assen_straight_1.mat');
    load('Assen_straight_corner');
elseif strcmp(track_n{1}, 'Assen')
    load([track_n{1},'track_ds_',num2str(ds),'.mat']);
	curv3 = curv;
	curv4 = curv;
elseif strcmp(track_n{1},'Assen_optimal')
    load([track_n{1},'track_ds_',num2str(ds),'.mat']);
	curv3 = curv;
	curv4 = curv;
elseif strcmp(track_n{1}, 'Assen_middle')
    load([track_n{1},'track_ds_',num2str(ds),'.mat']);
	curv3 = curv;
	curv4 = curv;
end

 
%% Adapt track array 
% Make a distance array for not equidistant distance profiles 
dis_temp = [dist];

if strcmp(track_n{1}, 'Straight') 
    dist = dis_temp;
else 
    dist = cumsum(dis_temp);
end

%% Define inner and outer boundaries
% For simplicity distance boundaries and middle line is equal 5m. 

w_in = ones(size(curv4))*5;
w_out = ones(size(curv4))*5;

% Define path structure
path.dist = dist; 
path.curv = curv4; 
path.win = w_in;
path.wout = w_out; 


%% Find starting laptime
v = CalculateSpeedProfile(path,par);
[t,tc] = ComputeLapTime(v,path);
dt = 10;                            % Starting dt

%% Optimization loop 
% i=0; 
% while abs(dt) > tol 
%    temp_t = tc(end); 
%    v = CalculateSpeedProfile(path,par);
%    path = MinimizeCurvature(v,path,par,tc);
%    [t,tc] = ComputeLapTime(v,path);
%    dt = temp_t-tc(end); 
%    i = i+1; 
% end
% fprintf("Number of iterations is " + num2str(i));


end 