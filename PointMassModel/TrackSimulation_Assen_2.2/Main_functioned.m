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

clc
clear all 
par = parameters(); 

%% Ask for input: track, number of laps, discretization step. Load track
track = 'At which track do you want to simulate the race? [Assen,Straight]';
track_n = input(track);
%track_n = 'Straight'; %'Assen';
track_n = cellstr(track_n);
laps = 'How many laps do you want the simulations to run for? [1-20]';
n_lap = input(laps);
ds = par.ds;

if strcmp(track_n{1}, 'Straight') 
    load([track_n{1},'_track_ds_',num2str(ds),'.mat']);
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

% Load bike constants
run bike_constants.m
  
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
dist = cumsum(dis_temp);

curv4 = temp_curv4;

%% Compute acceleration and velocity profile based on Forward Backward Pass method.
tic;
[v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPass(curv4,par);
toc

%% Computing total required energy and RPM
E_d = W./(3600*1000);               % Energy per distance step
E_cum = cumsum(E_d);                % Cumulative sum of energy
E_tot = E_cum(end);                 % Total energy

v_m   = 60*v_dec;                   % Velocity of the wheel in meter/minute
Rpm_rs = v_m/par.d;                     % Rpm of the rear sprochet
Rpm_m  = Rpm_rs/par.gear_ratio;         % Rpm of motor

%% Visualization %%%
figure; 
subplot(3,2,1)
plot(dist,E_cum);
title('Used energy over distance');
xlabel('Distance [m]');
ylabel('Energy [kWh]');

%%  Visualizing the velocities
subplot(3,2,2)
plot(dist,v_dec,'-','Color','black')
hold on;
%plot(dist,v_acc,'--','Color','blue');
% hold on;
%plot(dist,v_max,'-', 'Color','red')
title("Velocity profiles")
legend('Backward Pass','Forward Pass')%,'Sample curvature')
grid on
ylabel('Velocity [m/s]')
xlabel('Distance [m]')
set(gca,'FontSize',12)
% Lap Classification
for idx = 1:n_lap
y1 = 0:ds:60;
x1 = dist(size(curv3,2))*idx*ones(size(y1));
plot(x1,y1,'--k')
legend('Lap'); 
hold all
end
%% Visualizing RPM and acceleration
subplot(3,2,3)
plot(dist,Rpm_m);
title('RPM motor');
xlabel('Distance');
ylabel('RPM');

subplot(3,2,4)
plot(dist, a');
title('Acceleration profile');
xlabel('Distance [m]');
ylabel('Acceleration [ms^-2]');
hold on;

% Lap Classification
for idx = 1:n_lap
y1 = -10:ds:10;
x1 = dist(size(curv3,2))*idx*ones(size(y1));
plot(x1,y1,'--k')
legend('Lap'); 
hold all
end

%% Computation and plot Lap times
[lapt,lapstr] = Laptime(v_dec,curv3,curv4,n_lap);
ax = subplot(3, 2, 5);
text(0.5,0.5,lapstr);
set ( ax, 'visible', 'off')

%% Plot speed distribution on the track 
 psi = cumtrapz(dist,curv4);
 N   = cumtrapz(dist, cos(psi));
 E   = cumtrapz(dist, -sin(psi));
 v_km = v_dec*3.6;
 % Plot track with new x,y-coordinates
 figure
 scatter(E,N,1,v_km)
 xlabel('x [m]')
 ylabel('y [m]')
 colormap jet
 colorbar
 axis equal