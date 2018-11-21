%% 
% Author: Marianne Schaaphok
% Date:   8-11-2018
% Last edited: 
function [v_max, v_acc,v_dec,a,rpm_m,W, phi_1] = ForwardBackwardPassGGd(curv4,par)

%% Velocity profile phase 1 

% The velocity profile is calculated thrice:
% i.   Neglecting the Longitudinal force (Finding the max vel. along the path)
% ii.  Forward Pass (accel phase)
% iii. Backward Pass (decel phase)

% Including Longitudinal and Lateral forces and roll angle

% i. Finding maximum allowed velocity along the path
v_max = sqrt(par.mu_dynamic*par.g./abs(curv4));

%% ii. Acceleration phase
v_acc = zeros(size(v_max));                          % Velocity acceleration phase
a1_x = zeros(size(v_max'));                         % Longitudinal acceleration
a1_y = zeros(size(v_max'));                         % Lateral acceleration 
phi_1 = zeros(size(v_max'));                         % roll angle 
rpm_m = zeros(size(v_max'));                         % Rpm motor
P_out = zeros(size(v_max'));
W     = zeros(size(v_max'));
alpha = 1;                                           % coefficient force at rear wheel (1 is only rear wheel) 

for idx = 2:size(v_max,2)

    
       

    %a_acc(idx) = 1.2*par.g;
    v_acc_temp(idx) = sqrt((v_acc(idx-1))^2 + 2*a1_x(idx)*par.ds); % Define achievable velocity

    v_acc(idx) = min(v_acc_temp(idx),v_max(idx));                   % Restrict velocity at corners   
    
    % Energy calculations
    %F_e = sf + Fd + Ffr + Fff;                                      % Force for energy calculations
    %W(idx) = F_e * par.ds;                                          % Compute Work. 
end
%% iii. Backward Pass
v_dec = ones(size(v_acc))*v_acc(end);
%a_dec = -0.8*g;
a_dec = zeros(size(a1_x)); 

for id = size(v_dec,2):-1:2
    % Compute max allowed brake force
    Wf    = a_dec(id)*par.h/par.b*par.m;                        % Weight shift to front tire [N]
    
    v_mph = 2.23693629 * v_dec(id);                             % Translate from m/s to mph 
    
    Fff = (par.a1+par.b1/par.Pf+par.c*v_mph^2/par.Pf)*(par.m*par.g*par.l1 - Wf);    % Rolling friction force on the front wheel [N]
    Ffr =(par.a1+par.b1/par.Pr+par.c*v_mph^2/par.Pr)*(par.m*par.g*par.l2 + Wf);     % Rolling friction force on the rear wheel [N]
 
    Fd = 0.5*par.Cd*v_dec(id)^2*par.A*par.rho;                  % Drag force [N]
    Fl = 0.5*par.Cl*par.rho*v_dec(id)^2;                        % Lift force [N]

    Nf = (par.m*par.g-Fl)*par.l1-Wf;                            % Normal force on the front tire [N]
    Nr = (par.m*par.g-Fl)*par.l2+Wf;                            % Normal force on the rear tire [N]

    Fb = par.mu_dynamic*Nf;                                     % Compute maximuma allowed brake force to prevent slipping
    a_dec(id) = - Fb/par.m;
    a_dec(id) = -par.g;
    v_dec(id-1) = sqrt((v_dec(id))^2 - 2*a_dec(id)*par.ds);
    v_dec(id-1) = min(v_dec(id-1),v_acc(id-1));
    
    %v_dec(id-1) = sqrt((v_dec(id))^2 - 2*a_dec*ds);
    %v_dec(id-1) = min(v_dec(id-1),v_acc(id-1));
end
%fprintf(num2str(min(a_dec(:))))
%% Combine the phases 
a = (v_dec ==v_acc_temp).*a1_x' + (v_dec ~=v_acc).*a_dec';
W = (v_dec == v_acc).* W';                                      % Neglect forces during braking phase
end