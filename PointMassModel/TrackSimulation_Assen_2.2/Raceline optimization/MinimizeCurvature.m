function [path] = MinimizeCurvature(v,path,par,tc)
n = size(path.dist,2);                              %number of timesteps

%% Convert curv(s)-> curv(t), v(s)->v(t)
if size(tc) ~= size(path.dist)
    fprintf('Arrrays time and dist are not equal')
end 

%% Build matrices
A = [];
for i = 2:size(tc,2)
   A = blkdiag(A, matrixA(i,par,v));
end
Cf = 160*ones(size(v));
Cr = 180*ones(size(v));
Fyf = 100*ones(size(v));
Fyr = 100*ones(size(v));
a2f = 2*ones(size(v));
a2r = 2*ones(size(v));
Iz = 2250; 
B = [];
a = par.l1*par.b;
b = par.b-a; 
for i = 2:size(tc,2)
    B = [B;0;0;(a*Cf(i))/Iz; Cf(i)/(par.m*v(i)); 0];
end

d = [];
for i = 2:size(tc,2)
    d = [d; 0; -path.curv(i)*v(i); (a*Cf(i)*a2f(i) - b*Cr(i)*a2r(i) + a*Fyf(i)-b*Fyr(i))/Iz;...
         (Cf(i)*a2f(i) + Cr(i)*a2r(i) + Fyf(i) + Fyr(i))/(par.m*v(i)); 0];
end 

%% CVX Optimization routine 
lambda = 1;                        % Regularization parameter to ensure smooth steering 
cvx_begin
    % Define variables 
    variable x(5*n) 
    variable delta(5*n)

    % Objective function
    minimize( sum((diff(x(5,:))./diff(path.dist)).^2 + lambda*(diff(delta).^2)))
    subject to 
        [x(6:(n-1)*5); x(1:10)] == A*x + B.*delta +d;
        x(1:5) == x(end-5:end);
        for k = 1:n
        path.wout(k) <= x(k) <= path.win(k);
        end
    % Constraints for each x_k sepearte 
    %  for k = 1:n-1
%             x(:,k+1) = A(:,:,k)*x(:,k) + B(:,k)*delta(k) + d(:,k);
%             path.wout(k) <=x(1,k) <= path.win(k);
%       end
%       x(:,1) = A(:,:,n)*x(:,n) + B(:,n)*delta(n) + d(:,n);
%       x(:,1) == x(:,end);
cvx_end

%% Update path 

% Collect e and psi data from X and store in seperate vectors 
e = []; 
psi_n = [];
for i = 0:n-1
   e = [e; x(i*5+1)];
   psi_n = [psi_n;x((i+1)*5)];
end

% Compute North-East coordinates previous curvature
psi = cumtrapz(path.dist,path.curv);
N = cumtrapz(path.dist, cos(psi));
E = cumtrapz(path.dist, -sin(psi));

% Update North-East coordinates
E_new = E - e.*cos(psi_n);
N_new = N - e.*sin(psi_n);

% Update distance
dist = size(E); 
dist(1) = 0; 
for i = 2:size(E,2)
   dist(k) = dist(k-1) + sqrt((E_new(k)-E_new(k-1))^2 + (N_new(k)-N_new(k-1))^2);
end

% Update curvature 
curv = diff(psi_n)./diff(dist);

% Update the path 
path.dist = dist; 
path.curv = curv; 
path.win = path.win + e ; 
path.wout = path.wout - e; 

end 