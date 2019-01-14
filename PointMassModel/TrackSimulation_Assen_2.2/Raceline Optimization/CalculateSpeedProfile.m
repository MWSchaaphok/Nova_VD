function [v] = CalculateSpeedProfile(path,par)

%% Use the ForwardBackwardPass method to find the velocity profile 
% Check if we need to update the distance between discretization points for
% the new curvatures!!
d_dis = [path.dist]-[0,path.dist(1:end-1)];
[~,~,v_dec,~] = ForwardBackwardPass2(path.curv,par,d_dis);
v = v_dec; 
end