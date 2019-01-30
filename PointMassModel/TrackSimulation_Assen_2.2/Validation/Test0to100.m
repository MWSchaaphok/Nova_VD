function [] = Test0to100()
global ds
%% Function description 
%  This function tests the amount of seconds needed to accelerate from 0 to
%  100 km/h. 
%  Author: Marianne 
%  Date: 19-10-2018
%par = parameters_test();
par = parameters_test();
track_n = 'Straight';
n_lap = 1;
load('Assen_straight_1.mat');

temp_curv4 = [curv4];
for i = 2:n_lap
    temp_curv4 = [temp_curv4 curv4(2:end)];
end

% Make a distance array for not equidistant distance profiles for n number of laps.  

dis_temp = [dist];
d_dis = [0,diff(dis_temp)]; 
dist = dis_temp;

curv3 = temp_curv4;
curv4 = temp_curv4;


% Load bike constants
%run bike_constants.m

tic;
[v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPass_val(d_dis,curv4,par);
toc

% Find first index where velocity larger than 100 km/h
ix = find(v_dec>100/3.6); 

% Compute necessary times
t = par.ds./v_dec(2:end); 

v_m   = 60*v_dec;                   % Velocity of the wheel in meter/minute
Rpm_rs = v_m/par.d;                 % Rpm of the rear sprochet
Rpm_m  = Rpm_rs/par.gear_ratio;     % Rpm of motor

% Total time for 0 to 100
t1 = cumsum(t(1:ix));
tend = t1(end);
fprintf(['0 to 100 km/h in ' num2str(tend) ' s' newline]);
figure; 
plot(dist,a);
title('Acceleration');
figure; 
plot(dist,v_dec*3.6);
title('Velocity')
figure; 
plot(dist,Rpm_m);
title('Rpm')
end