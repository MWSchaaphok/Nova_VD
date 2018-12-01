function [] = SteadyCorneringTest()
% This function tests ..... during steady cornering 
% Author: Marianne Schaaphok
% Date: 26-11-2018
%% Parameters
l = 1000;                                    % Length track
r = 600;                                     % Radius curve; 
k = 1/r;                                     % Curvature curve

par = parameters();                          % Parameters of the bike; 

%% Build corner track 
dist = 0:par.ds:l; 
curv = k*ones(size(dist)); 

%% Velocity
% This is not correct, since it does not depend on the curvature 
v_max = sqrt(par.mu_dynamic*par.g./abs(curv));
a_y = v_max.^2./(1./abs(curv));
roll = atan(a_y./par.g);
roll = roll *(180/(2*pi));

%% Visualization
figure; 
plot(dist,roll)
title(['Roll in corner with r = ',num2str(r),' and v = ',num2str(v_max(1))])
xlabel('Dist [m]')
ylabel('Roll (degrees)') 
end 