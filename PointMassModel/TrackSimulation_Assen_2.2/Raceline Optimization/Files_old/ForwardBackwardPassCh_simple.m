function [v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPassCh_simple(curv4,par)

%% Velocity profile phase 1 

% The velocity profile is calculated thrice:
% i.   Neglecting the Longitudinal force (Finding the max vel. along the path)
% ii.  Forward Pass (accel phase)
% iii. Backward Pass (decel phase)

% i. Finding maximum allowed velocity along the path
v_max = sqrt(par.mu_dynamic*par.g./abs(curv4));

%% ii. Acceleration phase
v_acc = zeros(size(v_max));                          % Velocity acceleration phase
a_acc = zeros(size(v_max'));                         % acceleration 
rpm_m = zeros(size(v_max'));                         % Rpm motor
P_out = zeros(size(v_max'));
W     = zeros(size(v_max'));

for idx = 2:size(v_max,2)
     
    
     drive_force = par.Tm/(par.gear_ratio*par.Rw);                   % Compute available drive force
     forces_x = drive_force ;                                        % Sum all forces to find available force
     %sf = min(forces_x, D);                                          % Limit drive_force to prevent slipping
     a_1 = forces_x/par.m;
     a_2 = par.g*(par.l2/par.c_h);
     a_acc(idx) = min(a_1,a_2);       % Define acceleration
     %a_acc(idx) = 1.2*par.g;
     v_acc_temp(idx) = sqrt((v_acc(idx-1))^2 + 2*a_acc(idx)*par.ds); % Define achievable velocity% 
     v_acc(idx) = min(v_acc_temp(idx),v_max(idx));
end
%% iii. Backward Pass
v_dec = ones(size(v_acc))*v_acc(end);
a_dec = zeros(size(a_acc)); 

for id = size(v_dec,2):-1:2
    a_dec(id)= -par.g*(par.l1/par.c_h);
    v_dec(id-1) = sqrt((v_dec(id))^2 - 2*a_dec(id)*par.ds);
    v_dec(id-1) = min(v_dec(id-1),v_acc(id-1));
end
%fprintf(num2str(min(a_dec(:))))
%% Combine the phases 
a = (v_dec ==v_acc_temp).*a_acc' + (v_dec ~=v_acc).*a_dec';
%W = (v_dec == v_acc).* W';                                      % Neglect forces during braking phase
end