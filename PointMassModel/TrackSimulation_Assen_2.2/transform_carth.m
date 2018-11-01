%% Transform K and dist to carthesian coordinates
% Dist should be defined cumulatively
% Curv contains the curvature at each point. 

psi = cumtrapz(dist,curv3);
N = cumtrapz(dist, cos(psi));
E = cumtrapz(dist, -sin(psi));