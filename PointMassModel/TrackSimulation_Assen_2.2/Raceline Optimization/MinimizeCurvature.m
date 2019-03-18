function [path] = MinimizeCurvature(v,path,par,tc)
%% Minimize the curvature of the raceline 

%% Convert curv(s)-> curv(t), v(s)->v(t)
if size(tc) ~= size(path.dist)
    fprintf('Arrrays time and dist are not equal')
end 

%% Shift to time-dependent variables
dt = 0.05;                                   % Size of timesteps that are taken, the smaller the more accurate 
endtime = floor(tc(end)/dt)*dt;             % round to one decimal, if the optimization is fast it can be rounded to 0.01
t  = 0:dt:endtime;                          % create uniform time distribution for the discretization

% Interpolate all necessary values to time domain  - default linear
v_t     = interp1(tc,v,t,'spline','extrap');                      
curv_t  = interp1(tc,path.curv,t,'spline','extrap');
w_in    = interp1(tc,path.win,t,'spline','extrap');
w_out   = interp1(tc,path.wout,t,'spline','extrap'); 
dist_t  = interp1(tc,path.dist,t,'spline','extrap');

%% Build matrices
n = length(t);

% Tire constants - now guessed values, this should be improved  
Cf = 160*ones(size(t));
Cr = 180*ones(size(t));
Fyf = 100*ones(size(t));
Fyr = 100*ones(size(t));
a2f = 2*ones(size(t));
a2r = 2*ones(size(t));
Iz = 2250; 

a = par.l1*par.b;
b = par.b-a; 


%% CVX Optimization routine 
% Now skips the first element in the sum minimization to prevent division
% by zero. 

lambda = 1;                        % Regularization parameter to ensure smooth steering

% Define CVX optimization problem 
cvx_begin
    % Define variables 
    variable x(5,n) 
    variable delta(1,n)

    % Objective function
    minimize sum(((x(5,2:end)-x(5,1:end-1))./(dist_t(2:end) - [dist_t(1:end-1)])).^2 + lambda*(delta(2:end)-[delta(1:end-1)]).^2)
    subject to 
        % Starting condition -> now set everything to zero, check if this
        % is correct 
        x(:,1) == [0;0;0;0;0]; 
        x(1,:) >= w_out;
        x(1,:) <= w_in; 
        % System constraints x_k+1 = A_kx_k + B_k delta + d_k
        % Boundary constraints w_out < e < w_in
        % For robustness in case v(1) = 0; 
        if  v_t(1) == 0 
            v_t(1) = v_t(1) + 0.01; 
        end
        for k = 1:n-1
             A = eye(5) + dt*[0 v_t(k) 0 0 0 ; 0 0 1 0 0 ; 0 0 (a^2*Cf(k) + b^2*Cr(k))/(v_t(k)*Iz) (a*Cf(k) - b*Cr(k))/(Iz) 0 ; ...
                 0 0 (a*Cf(k) - b*Cr(k))/(par.m*(v_t(k))^2)-1 (Cf(k) + Cr(k))/(par.m*v_t(k)) 0 ; 0 0 1 0 0 ];
             B = dt*[ 0;0;-a*Cf(k)/Iz; -Cf(k)/(par.m*v_t(k)); 0 ];
             d = dt*[0 ; -curv_t(k)*v_t(k) ; 0 ; 0 ; 0]; 
             x(:,k+1) == A*x(:,k) + B*delta(k) + d;
             x(1,k) >= w_out(k) ;
             x(1,k) <= w_in(k); 
         end
cvx_end

%% Update path 

% Collect e and psi data from X and store in seperate vectors 
e = x(1,:); 
dpsi = x(2,:);
psi_n = x(5,:);

% Plot track with boundaries and middle line
figure; 
plot(path.E_track, path.N_track,'k--')
hold on; 
[x_left,y_left]     = para_curves(path.E_track,path.N_track,-5);
[x_right,y_right]   = para_curves(path.E_track,path.N_track,5);
plot(x_left,y_left,'k-','HandleVisibility','off')
plot(x_right,y_right,'k-','HandleVisibility','off')
axis equal 
xlabel('E')
ylabel('N')
hold on; 

% Compute and plot North-East coordinates previous curvature
psi = cumtrapz(path.dist,path.curv);
N   = cumtrapz(path.dist, cos(psi));
E   = cumtrapz(path.dist, -sin(psi));

plot(E,N,'r-')
hold on

% Transform old North-East coordinates
psi2 = interp1(tc,psi,t,'spline','extrap');
E2   = interp1(tc,E,t,'spline','extrap');
N2   = interp1(tc,N,t,'spline','extrap');

E_new = E2 - e.*cos(psi2);
N_new = N2 - e.*sin(psi2);

plot(E_new,N_new,'b-')
legend('track','previous curvature','new curvature')

% Update distance
dist = zeros(size(E_new)); 
for k = 2:size(E_new,2)
   dist(k) = dist(k-1) + sqrt((E_new(k)-E_new(k-1))^2 + (N_new(k)-N_new(k-1))^2);
end

% Update curvature and transform back to distance defined
%curv_t  = (psi_n(2:end) - psi_n(1:end-1))./(dist(2:end) - dist(1:end-1));
curv_t  = gradient(psi_n)./gradient(dist);
%curv_t  = [curv_t(1),curv_t];

% Update inner and outer boundaries
alpha = pi/2*ones(size(dpsi)) - dpsi;
win_n = (w_in - e)./sin(alpha);
wout_n = (w_out - e)./sin(alpha);

% Update the path 
path.dist = dist; 
path.ds   = diff(dist); 
path.curv = curv_t; 
path.win  = win_n ; 
path.wout = wout_n; 

% Test wether dist, curv are correctly computed 
dist_test = 0:1:path.dist(end);
curv_test = interp1(path.dist,path.curv,dist_test,'spline','extrap');
psi_t = cumtrapz(dist_test,curv_test);
N_t = cumtrapz(dist_test, cos(psi_t));
E_t = cumtrapz(dist_test, -sin(psi_t));
% psi_t = cumtrapz(path.dist,path.curv);
% N_t = cumtrapz(path.dist, cos(psi_t));
% E_t = cumtrapz(path.dist, -sin(psi_t));
plot(E_t,N_t,'r:')

end