function [path,v2] = MinimizeCurvature(v,path,par,tc)
%n = size(path.dist,2);                              %number of timesteps

%% Convert curv(s)-> curv(t), v(s)->v(t)
if size(tc) ~= size(path.dist)
    fprintf('Arrrays time and dist are not equal')
end 


%% Shift to time-dependent 
endtime = floor(tc(end));         % round to one decimal
dt = 0.1; 
t  = 1:dt:endtime;                 % create uniform time distribution for the discretization

v_t = interp1(tc,v,t,'spline','extrap');
curv = interp1(tc,path.curv,t);
w_in = interp1(tc,path.win,t);
w_out = interp1(tc,path.wout,t); 
dist2 = interp1(tc,path.dist,t);


%% Build matrices
n = length(t);
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
% The discretization of the matrices is still wrong! 

lambda = 1;                        % Regularization parameter to ensure smooth steering 
cvx_begin
    % Define variables 
    variable x(5,n) 
    variable delta(1,n)

    % Objective function
    %minimize( sum((diff(x(5,:))./diff(path.dist)).^2 + lambda*(diff(delta).^2)))
    minimize sum(((x(5,2:end)-[0,x(5,2:end-1)])./(dist2(2:end) - [0,dist2(2:end-1)])).^2 + lambda*(delta(2:end)-[0,delta(2:end-1)]).^2)
    subject to 
%         [x(6:(n-1)*5); x(1:10)] == A*x + B.*delta +d;
%         x(1:5) == x(end-5:end);
%         for k = 1:n
%         path.wout(k) <= x(k) <= path.win(k);
%         end
%    Constraints for each x_k seperate 
        x(:,1) == [0;0;0;0;0]; 
        for k = 1:n-1
          
             A = eye(5) + dt*[0 v_t(k) 0 0 0 ; 0 0 1 0 0 ; 0 0 (a^2*Cf(k) + b^2*Cr(k))/(v_t(k)*Iz) (a*Cf(k) - b*Cr(k))/(Iz) 0 ; ...
                 0 0 (a*Cf(k) - b*Cr(k))/(par.m*v_t(k))-1 (Cf(k) + Cr(k))/(par.m*v_t(k)) 0 ; 0 0 1 0 0 ];
             B = dt*[ 0;0;-a*Cf(k)/Iz; -Cf(k)/(par.m*v_t(k)); 0 ];
             d = dt*[0 ; -curv(k)*v_t(k) ; 0 ; 0 ; 0]; 
             x(:,k+1) == A*x(:,k) + B*delta(k) + d;
             w_out(k) <= x(1,k) ;
             x(1,k) <= w_in(k); 
         end
          %A = eye(5) + dt*[0 v_t(n-1) 0 0 0 ; 0 0 1 0 0 ; 0 0 (a^2*Cf(n-1) + b^2*Cr(n-1))/(v_t(n-1)*Iz) (a*Cf(n-1) - b*Cr(n-1))/(Iz) 0 ; ...
          %     0 0 (a*Cf(n-1) - b*Cr(n-1))/(par.m*v_t(n-1))-1 (Cf(n-1) + Cr(n-1))/(par.m*v_t(n-1)) 0 ; 0 0 1 0 0 ];
          %B = dt*[ 0;0;-a*Cf(n-1)/Iz; -Cf(n-1)/(par.m*v_t(n-1)); 0 ];
          %d = dt*[0 ; -path.curv(n-1)*v_t(n-1) ; 0 ; 0 ; 0];
          x(1,:) >= w_out;
          x(1,:) <= w_in; 
          %x(:,1) == A*x(:,n-1) + B*delta(n-1) + d;
          %x(:,1) == x(:,end);
cvx_end

%% Update path 

% Collect e and psi data from X and store in seperate vectors 
e = []; 
psi_n = [];
e = x(1,:); 
psi_n = x(5,:);
% for i = 0:n-1
%    e = [e; x(i*5+1)];
%    psi_n = [psi_n;x((i+1)*5)];
% end

% Compute North-East coordinates previous curvature
psi = cumtrapz(path.dist,path.curv);
N = cumtrapz(path.dist, cos(psi));
E = cumtrapz(path.dist, -sin(psi));
figure
plot(E,N,'b--')
hold on
[x_left,y_left] = para_curves(E,N,-5);
[x_right,y_right] = para_curves(E,N,5);
plot(x_left,y_left,'k-')
plot(x_right,y_right,'k-')
axis equal 
hold on; 

% Update North-East coordinates
psi2 = interp1(tc,psi,t);
E2   = interp1(tc,E,t);
N2   = interp1(tc,N,t);

E_new = E2 - e.*cos(psi2);
N_new = N2 - e.*sin(psi2);

plot(E_new,N_new,'g-')


% Update distance
dist = zeros(size(E2)); 
for k = 2:size(E2,2)
   dist(k) = dist(k-1) + sqrt((E_new(k)-E_new(k-1))^2 + (N_new(k)-N_new(k-1))^2);
end

% Update curvature 
curv = (psi_n - [0,psi_n(1:end-1)])./(dist - [0,dist(1:end-1)]);
%curv = [0,curv];


% Update the path 
path.dist = dist; 
path.curv = curv; 
path.win = w_in + e ; 
path.wout = w_out - e; 
v2   = interp1(tc,v,path.dist, 'spline','extrap');
psi = cumtrapz(path.dist,path.curv);
N = cumtrapz(path.dist, cos(psi));
E = cumtrapz(path.dist, -sin(psi))-e;
plot(E,N,'r:')

end