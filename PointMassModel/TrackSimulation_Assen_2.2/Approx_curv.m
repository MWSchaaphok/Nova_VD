%% Approximate curvature 
% This code converts the unsmooth curvature data to stepwise curvature
% profiles, by taking the mean of s number of points. 

function [curvDE] = Approx_curv(curv,s)
curvDE = zeros(size(curv));                     % Creates correct size for curv

for i = 0:ceil((size(curv,2)/s)-2)              % Compute and store mean for s number of points    
   curvDE(i*s+1:(i+1)*s) = mean(curv(i*s+1:(i+1)*s)); 
end
curvDE(ceil((size(curv,2)/s)-1)*s:end) = mean(curv(ceil((size(curv,2)/s)-1)*s:end)); 

% Plot the approximation of the curvature
figure; plot(curv); hold on; plot(curvDE)

% Transform back to x,y coordinates and plot (for testing) 
%     psi = cumtrapz(dist,curvDE);                    
%     N = cumtrapz(dist, cos(psi));
%     E = cumtrapz(dist, -sin(psi));
% 
%     figure; plot(E,N)
%     axis equal

end