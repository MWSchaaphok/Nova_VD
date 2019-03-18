%% Transform K and dist to carthesian coordinates
% Dist should be defined cumulatively
% Curv contains the curvature at each point. 
%dist = cumtrapz(dist)
curv2    =[curv(1),curv];
dist2    = cumsum([0,dist]);

psi_2 = psi(dist2,dist2,curv2);
N_2     = N(dist2,dist2,psi_2);
E_2     = E(dist2,dist2,psi_2);

psi_3 = cumtrapz(dist2,curv2);
N_3   = cumtrapz(dist2,cos(psi_3));
E_3   = cumtrapz(dist2,-sin(psi_3));

%psi_2 = integral(@(x)int_fun(x,dist2,curv2),0,y);
%N     = integral(@int_fun,0,dist2(end),[],[],dist2,curv2);
%E     = integral(@int_fun,0,dist2(end),[],[],dist2,curv2);
% psi = cumtrapz(dist2,curv2);
% N = cumtrapz(dist2, cos(psi));
% E = cumtrapz(dist2, -sin(psi));

figure; 
plot(E_2,N_2,'b-')
axis equal
hold on; 

%% Update distance
dist_2 = zeros(size(E_2)); 
%E2 = E(dist2,dist2,psi);
%N2 = N(dist2,dist2,psi);

for k = 2:size(E_2,2)
    %psi_temp = psi(dist2(k),dist2,curv2);
   dist_2(k) = dist_2(k-1) + sqrt((E_2(k)-E_2(k-1))^2 + (N_2(k)-N_2(k-1))^2);
end

%Update curvature and transform back to distance defined
curv_t  = gradient(psi_2)./gradient(dist_2);
%curv_t  = [curv_t(1),curv_t];

dist_3 = zeros(size(E_3)); 
%E2 = E(dist2,dist2,psi);
%N2 = N(dist2,dist2,psi);

for k = 2:size(E_2,2)
    %psi_temp = psi(dist2(k),dist2,curv2);
   dist_3(k) = dist_3(k-1) + sqrt((E_3(k)-E_3(k-1))^2 + (N_3(k)-N_3(k-1))^2);
end

%Update curvature and transform back to distance defined
curv_t3  = gradient(psi_3)./gradient(dist_3);

dist_4 = 0:0.5:dist_2(end); 
psi_new = psi(dist_4,dist_2,curv_t);
N_new     = N(dist_4,dist_4,psi_new);
E_new     = E(dist_4,dist_4,psi_new);

psi_3 = psi(dist_3,dist_3,curv_t3);
N_3     = N(dist_3,dist_3,psi_3);
E_3     = E(dist_3,dist_3,psi_3);

plot(E_new,N_new,'r:')
hold on;
plot(E_3,N_3,'g--')

function f = int_fun(x,xdata,ydata)
f = interp1(xdata,ydata,x,'spline','extrap');
end 

function psi_2 = psi(y,dist,curv)
    for k=1:length(y)
        psi_2(k) = integral(@(x)int_fun(x,dist,curv),0,y(k));
    end
end 

function N2 = N(y,dist,psi)
    for k = 1:length(y)
        N2(k) = integral(@(x)int_fun(x,dist,cos(psi)),0,y(k));
    end
end 

function E2 = E(y,dist,psi)
    for k = 1 :length(y)
        E2(k) = integral(@(x)int_fun(x,dist,-sin(psi)),0,y(k));
    end
end 