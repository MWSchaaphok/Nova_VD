function [v_max, v_acc,v_dec,a,rpm_m,W] = ForwardBackwardPass2(curv4,par,d_dis)

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
v_acc(1) = 1;
for idx = 2:size(v_max,2)
    Wf    = a_acc(idx-1)*par.h/par.b*par.m;                         % Weight shift to front tire [N]
    
    v_mph = 2.23693629 * v_acc(idx-1);                              % Translate from m/s to mph 
    
    Fff = (par.a1+par.b1/par.Pf+par.c*v_mph^2/par.Pf)*(par.m*par.g*par.l1 - Wf);     % Rolling friction force on the front wheel [N]
    Ffr =(par.a1+par.b1/par.Pr+par.c*v_mph^2/par.Pr)*(par.m*par.g*par.l2 + Wf);      % Rolling friction force on the rear wheel [N]
    Fd = 0.5*par.Cd*v_acc(idx-1)^2*par.A*par.rho;                   % Drag force [N]
    Fl = 0.5*par.Cl*par.rho*v_acc(idx-1)^2;                         % Lift force [N]

    Nf = (par.m*par.g-Fl)*par.l1-Wf;                                % Normal force on the front tire [N]
    Nr = (par.m*par.g-Fl)*par.l2+Wf;                                % Normal force on the rear tire [N]

    D = par.mu_dynamic*Nr;                                          % Compute maximuma allowed drive force to prevent slipping
    
    % Check powercurve for max T available in Torque/rpm curve 
    v_mm   = 60*v_acc(idx-1);                                       % Velocity of the wheel in meter/minute
    rpm_rs = v_mm/par.d;                                            % Rpm of the rear sprochet
    rpm_m(idx)  = rpm_rs/par.gear_ratio;                            % Rpm of motor
    
    %Tm = (210-0.0388*(rpm_m(idx)-3200))*((rpm_m(idx)-3200)>0 && (rpm_m(idx)-3200)<2300) + ...
    %     (400-0.12*(rpm_m(idx)-1732))*((rpm_m(idx)-1732)>0 && (rpm_m(idx)-1732)<1468) +...
    %      400*(rpm_m(idx)<1732);
    %Tm = (200-0.026*(rpm_m(idx)-7000))*((rpm_m(idx)-7000)>0 && (rpm_m(idx)-7000)<3000) + ...
    %     (260-0.024*(rpm_m(idx)-4500))*((rpm_m(idx)-4500)>0 && (rpm_m(idx)-4500)<2500) +...
    %      260*(rpm_m(idx)<4500);
     
    % Compute drive force, acceleration and velocity 
    drive_force = par.Tm/(par.gear_ratio*par.Rw);                       % Compute available drive force
    forces_x = drive_force -Fd -Ffr -Fff;                           % Sum all forces to find available force
    sf = min(forces_x, D);                                          % Limit drive_force to prevent slipping
    
    a_acc(idx) = sf/par.m;                                          % Define acceleration
    %a_acc(idx) = 1.2*par.g;
    v_acc_temp(idx) = sqrt((v_acc(idx-1))^2 + 2*a_acc(idx)*d_dis(idx)); % Define achievable velocity

    v_acc(idx) = min(v_acc_temp(idx),v_max(idx));                   % Restrict velocity at corners   
    
    % Energy calculations
    F_e = sf + Fd + Ffr + Fff;                                      % Force for energy calculations
    F_c = Fd+Ffr+Fff; 
    W1(idx) = F_e* d_dis(idx);                                          % Compute Work. 
    W2(idx) = F_c*d_dis(idx);
end
W = ((v_acc_temp == v_acc).*W1 + (v_acc == v_max).*W2);
size(W)

%% iii. Backward Pass
v_dec = ones(size(v_acc))*v_acc(end);
%a_dec = -0.8*g;
a_dec = zeros(size(a_acc)); 

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
    %a_dec(id) = - Fb/par.m;
    a_dec(id) = -1.0*par.g;
    v_dec(id-1) = sqrt((v_dec(id))^2 - 2*a_dec(id)*d_dis(id));
    v_dec(id-1) = min(v_dec(id-1),v_acc(id-1));
    
    %v_dec(id-1) = sqrt((v_dec(id))^2 - 2*a_dec*ds);
    %v_dec(id-1) = min(v_dec(id-1),v_acc(id-1));
end
%fprintf(num2str(min(a_dec(:))))
%% Combine the phases 
a = (v_dec ==v_acc_temp).*a_acc' + (v_dec ~=v_acc).*a_dec';
size((v_dec == v_acc));
W = (v_dec == v_acc).* W;                                      % Neglect forces during braking phase

end