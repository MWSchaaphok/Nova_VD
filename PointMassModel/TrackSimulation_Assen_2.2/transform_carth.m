%% Transform K and dist to carthesian coordinates
% Dist should be defined cumulatively
% Curv contains the curvature at each point. 

psi = cumtrapz(dist,curv);
N = cumtrapz(dist, cos(psi));
E = cumtrapz(dist, -sin(psi));

figure; 
plot(E,N)
axis equal