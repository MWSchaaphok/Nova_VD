%% Transform K and dist to carthesian coordinates
% Dist should be defined cumulatively
% Curv contains the curvature at each point. 
%dist = cumtrapz(dist)
curv2    =[curv(1),curv];
dist2    = cumsum([0,dist]);

psi = cumtrapz(dist2,curv2);
N = cumtrapz(dist2, cos(psi));
E = cumtrapz(dist2, -sin(psi));

figure; 
plot(E,N,'b-')
axis equal
hold on; 

%% Update distance
dist_2 = zeros(size(E)); 
for k = 2:size(E,2)
   dist_2(k) = dist_2(k-1) + sqrt((E(k)-E(k-1))^2 + (N(k)-N(k-1))^2);
end

% Update curvature and transform back to distance defined
curv_t  = (psi(2:end) - psi(1:end-1))./(dist_2(2:end) - dist_2(1:end-1));
curv_t  = [curv_t(1),curv_t];

psi_2 = cumtrapz(dist_2,curv_t);
N_2 = cumtrapz(dist_2, cos(psi_2));
E_2 = cumtrapz(dist_2, -sin(psi_2));

plot(E_2,N_2,'r-')