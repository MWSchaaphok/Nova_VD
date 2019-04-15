track = 'At which track do you want to simulate the race? [Assen,Straight,Corner]';
track_n = input(track);
track_n = cellstr(track_n);

if strcmp(track_n{1}, 'Straight') 
    load('Straight_600.mat');
elseif strcmp(track_n{1},'Corner')
    load('StraightCorner2.mat');
elseif strcmp(track_n{1},'Assen')
    load('Assen_middle_1m.mat');
end

 
%% Adapt track array 
d_dist  = dist;
curv    = [curv(1),curv];
dist2 = cumsum([0,flip(dist)]);
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

%Define E,N coordinates from the other side
curv2       = flip(path.curv);
psi_track2  = cumtrapz(dist2,curv2);
N_track2    = -1*cumtrapz(dist2, cos(psi_track2));
E_track2    = cumtrapz(dist2, -sin(psi_track2));

E_av = (path.E_track + flip(E_track2))./2;
N_av = (path.N_track + flip(N_track2))./2;

E_eq= find((path.E_track- flip(E_track2)<=10^-16)) ;
N_eq = find((path.N_track - flip(N_track2)<=10^-16));
%idx = find((path.E_track == flip(E_track2)) && (path.N_track == flip(N_track2))==1)
Equal = intersect(E_eq,N_eq)
figure; 
plot(path.E_track,path.N_track);
hold on;
plot(E_track2,N_track2);
plot(E_av, N_av);
hold off; 
legend('Original','Reverse','Average')
axis equal