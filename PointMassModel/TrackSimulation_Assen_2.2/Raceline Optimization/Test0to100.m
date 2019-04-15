function [tend] = Test0to100()
%% Function description 
%  This function tests the amount of seconds needed to accelerate from 0 to
%  100 km/h. 
%  Author: Marianne 
%  Date: 19-10-2018
par = parameters();
track_n = 'Straight';
n_lap = 1;
%par.ds = 0.1;
load('Straight_600.mat');
ds = ones(size(dist));
curv    = [curv(1),curv];
dist    = cumsum([0,dist]);
% Load bike constants
%run bike_constants.m

tic;
[v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPass2(curv,par,ds,0);
toc

% Find first index where velocity larger than 100 km/h
ix = find(v_dec>100/3.6); 

% Compute necessary times
t = par.ds./v_dec(2:end); 

% Total time for 0 to 100
t1 = cumsum(t(1:ix(1)));
tend = t1(end);
fprintf(['0 to 100 km/h in ' num2str(tend) ' s' newline]);
figure; 
plot(dist,a);
title('Acceleration');
figure; 
plot(dist,v_dec*3.6);
title('Velocity')
end