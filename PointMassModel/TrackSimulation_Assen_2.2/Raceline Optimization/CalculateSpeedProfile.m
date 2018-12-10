function [v] = CalculateSpeedProfile(path,par)

%% Use the ForwardBackwardPass method to find the velocity profile 
% Check if we need to update the distance between discretization points for
% the new curvatures!!

[~ ,v_dec,~] = ForwardBackwardPass(path.curv,par);
v = v_dec; 
end