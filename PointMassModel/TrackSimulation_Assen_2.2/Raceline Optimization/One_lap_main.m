%% Compute laptime over a certain track. 
% The inner and outer boundary of the track are defined by starting
% curavture +- 5 m, for good results give the first curvature as the middle
% of the track.

%% Load bike variables 
% Maybe add input possibilities?
par = parameters();             % Motorcycle parameters 
tol = 0.05 ;                    % Tolerance for optimizing laptime 
v_0 = 00;                        % Start velocity - default = 0

%% Ask for input: track, number of laps, discretization step. Load track
% Note! Track should be defined as [ds_1,ds_2,...,ds_n]
track = 'At which track do you want to simulate the race? [Assen,Straight,Corner]';
track_n = input(track);
track_n = cellstr(track_n);

if strcmp(track_n{1}, 'Straight') 
    load('Straight_3000.mat');
elseif strcmp(track_n{1},'Corner')
    load('StraightCorner2.mat');
elseif strcmp(track_n{1},'Assen')
    load('Assen_middle_1m.mat');
end

 
%% Adapt track array 
d_dist  = dist;
curv    = [curv(1),curv];
dist    = cumsum([0,dist]);
 
%% Define inner and outer boundaries
% For simplicity distance boundaries and middle line is equal 5m.
% Can later be asked as an input as well
w_in    = ones(size(curv))*5;
w_out   = ones(size(curv))*-5;

% Define path structure
path.dist   = dist; 
path.ds     = d_dist; 
path.curv   = curv; 
path.win    = w_in;
path.wout   = w_out; 

% Define and save track
psi_track       = cumtrapz(path.dist,path.curv);
path.N_track    = cumtrapz(path.dist, cos(psi_track));
path.E_track    = cumtrapz(path.dist, -sin(psi_track));

%% Find starting laptime
[v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPass2(path.curv,par,path.ds,v_0);
v = v_dec; 

[t,tc]  = ComputeLapTime(v,path);
dt      = 10;           

curv = path.curv.*(abs(path.curv)>1e-15);
a_y = v_dec.^2./(1./path.curv);
roll = atand(a_y./par.g);                               % Roll angle in degrees (simple approx)
steer = atand(par.b.*curv);                             % Steering angle in degrees (simple approx)
%% Computing total required energy and RPM
E_d = W./(3600*1000);               % Energy per distance step
E_cum = cumsum(E_d);                % Cumulative sum of energy
E_tot = E_cum(end);                 % Total energy

v_m   = 60*v_dec;                   % Velocity of the wheel in meter/minute
Rpm_rs = v_m/par.d;                     % Rpm of the rear sprochet
Rpm_m  = Rpm_rs/par.gear_ratio;         % Rpm of motor

%%  Visualizing the velocities
figure; 
plot(dist,v_dec,'-','Color','black')
hold on;
plot(dist,v_acc,'--','Color','blue');
 hold on;
plot(dist,v_max,'-', 'Color','red')
title("Velocity profile")
legend('Backward Pass','Forward Pass','Max velocity')%,'Sample curvature')
grid on
ylabel('Velocity [m/s]')
xlabel('Distance [m]')
set(gca,'FontSize',12)
%% Visualization %%%
figure; 
subplot(2,2,1)
plot(dist,E_cum);
title('Used energy over distance');
xlabel('Distance [m]');
ylabel('Energy [kWh]');


%%
subplot(2,2,2)
%figure;
plot(dist,v_dec,'-','Color','black')
%hold on;
%plot(dist,v_acc,'--','Color','blue');
% hold on;
%plot(dist,v_max,'-', 'Color','red')
title("Velocity profile")
%legend('Backward Pass','Forward Pass','Max velocity')%,'Sample curvature')
grid on
ylabel('Velocity [m/s]')
xlabel('Distance [m]')
set(gca,'FontSize',12)
% Lap Classification

%% Visualizing RPM and acceleration
subplot(2,2,3)
plot(dist,Rpm_m);
title('RPM motor');
xlabel('Distance');
ylabel('RPM');

subplot(2,2,4)
plot(dist, a');
title('Acceleration profile');
xlabel('Distance [m]');
ylabel('Acceleration [ms^-2]');
hold on;

%% Computation and plot Lap times
%[t,lapt,lapstr] = Laptime2(d_dis,v_dec,curv3,curv4,n_lap,par);
%[t,lapt,lapstr] = Laptime(v_dec,curv3,curv4,n_lap,par);
%ax = subplot(3, 2, 5);
%text(0.5,0.5,lapstr);
%set ( ax, 'visible', 'off')

%% Plot speed distribution on the track 
 psi = cumtrapz(path.dist,path.curv);
 N   = cumtrapz(path.dist, cos(psi));
 E   = cumtrapz(path.dist, -sin(psi));
 v_km = v_dec*3.6;
 % Plot track with new x,y-coordinates
 figure
 scatter(E,N,1,v_km)
 xlabel('x [m]')
 ylabel('y [m]')
 colormap jet
 colorbar
 axis equal
 
 %% Max speed
 v_max = max(v_dec); 
 if (v_dec(end)-v_dec(end-1))>10^-2
    fprintf('Not yet truly converged') 
 end
 fprintf(['The max speed is ',num2str(v_max*3.6),' km/u \n']);