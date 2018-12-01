function TestStraight()
% This function tests ..... during acceleration on a straight
% Author: Marianne Schaaphok
% Date: 26-11-2018
%% Parameters
l = 1000;                                    % Length track
r = 0;                                       % Radius curve; 
k = 1/r;                                     % Curvature curve

par = parameters();                          % Parameters of the bike; 

%% Build corner track 
dist = 0:par.ds:l; 
curv = k*ones(size(dist)); 

%% Compute acceleration and velocity
[v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPass(curv4,par);

end 