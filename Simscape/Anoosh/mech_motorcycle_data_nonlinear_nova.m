% Motorcycle model definition file.
% Author(s): G.D Wood
% Edited for motorcycle Nova 10: Marianne
% Last edited: 18-12-2018
% Copyright 1990-2002 The MathWorks, Inc.

% Inertia parameters.
Mff_str = 13.1;  % kg.  Mass of the front steering body (steering axle + suspension)
Mff_sus = 17.5;  % kg.  Mass of the suspension
Mmain  = 209.6;  % kg.  Mass of the main frame
Mfw = 7.2;       % kg.  Mass of the front wheel (updated)
Mrw = 12;        % kg.  Mass of the rear wheel (updated)
Mubr = 44.5;     % kg.  Mass of the rider
Mswg_arm = 0;    % kg.  Mass of the swingarm

% Inertia parameters for the front suspension
Iff_strx = 0.8;  % kg*m^2. 
Iff_stry = 1.2;  % kg*m^2. 
Iff_strz = 0.5;  % kg*m^2. 
Iff_strxz = 0;   % kg*m^2. 

% Inertia matrix for the front suspension
Iff_sus = [Iff_stry 0 Iff_strxz;
           0 Iff_stry 0;
           Iff_strxz 0 Iff_strz*0.1]*0.2 ;
       
% Inertia matrix for the rear suspension
Iff_rear_sus = [Iff_stry 0 Iff_strxz;0 Iff_stry 0;Iff_strxz 0 Iff_strz*0.1]*0.2 ;

% Inertia parameters for the main frame
Imnx = 6.9;      % kg*m^2. 
Imny = 34.1;     % kg*m^2.
Imnz = 21.1;     % kg*m^2.
Imnxz  = 1.7;    % kg*m^2.

% Inertia matrix for the main frame
Imn = [Imnx+5 0 Imnxz;0 Imny 0;Imnxz 0 Imnz+5]*0.68 ;

% Inertia matrix for the front steer body
Iff_str = [Iff_stry 0 Iff_strxz;
           0 Iff_stry 0;
           Iff_strxz 0 Iff_strz*0.1]*0.25 ;
       
% Inertia parameters for the rider
Iubrx = 1.3;     % kg*m^2.
Iubry = 2.1;     % kg*m^2.
Iubrz = 1.4;     % kg*m^2.
Iubrxz = 0.3;    % kg*m^2.

% Inertia matrix for the rider
Iubr = [Iubrx 0 Iubrxz;0 Iubry 0;Iubrxz 0 Iubrz] ;

% Inertia parameters for the front wheel and rear wheel
Ifwx = 0.3 ;     % kg*m^2.
Ifwy  = 0.58;    % kg*m^2.
Ifwz = 0.3 ;     % kg*m^2.
Irwx = 0.38 ;    % kg*m^2.
Irwy = 0.74;     % kg*m^2.
Irwz = 0.38 ;    % kg*m^2.

% Inertia matrix for the front wheel and rear wheel
Ifw = [Ifwx 0 0;0 Ifwy 0;0 0 Ifwz] ;
Irw = [Irwx 0 0;0 Irwy 0;0 0 Irwz] ;

% Geometric parameters.
x1  =  0.770;   % [m] p1,  aerodynamic center of pressure
z1  = -0.582;   % [m] p1,  aerodynamic center of pressure
x2  =  1.168;   % [m] p2,  joint twist axis - rear frame
z2  = -0.834;   % [m] p2,  joint twist axis - rear frame
x3  =  1.165;   % [m] p3,  COM front frame steer body
z3  = -0.869;   % [m] p3,  COM front frame steer body
x4  =  1.225;   % [m] p4,  joint front frame and steer body
z4  = -0.867;   % [m] p4,  joint front frame and steer body
x5  =  1.539;   % [m] p5,  COM front suspension body
z5  = -0.318;   % [m] p5,  COM front suspension body
x6  =  1.539;   % [m] p6,  Front wheel attachment point
z6  = -0.318;   % [m] p6,  Front wheel attachment point
x7  =  0.000;   % [m] p7,  Rear wheel center point
z7  = -0.321;   % [m] p7,  Rear wheel center point
x8  =  0.680;   % [m] p8,  COM main frame
z8  = -0.532;   % [m] p8,  COM main frame
x9  =  0.600;   % [m] p9,  attachment point for rider on rear frame
z9  = -1.000;   % [m] p9,  attachment point for rider on rear frame
x10 =  0.600;   % [m] p10, COM upper body rider
z10 = -1.190;   % [m] p10, COM upper body rider
x11 =  0.400;   % [m] p11, joint swingarm - main frame
z11 = -0.321;   % [m] p11, joint swingarm - mian frame
x12 =  0.000;   % [m] p12, attachment point rear spring on bottom link
z12 = -0.330;   % [m] p12, attachmetn point rear spring on bottom link
x13 =  0.000;   % [m] p13, attachment point swingarm - main frame
z13 = -0.700;   % [m] p13, attachment point swingarm - main frame
x14 =  0.100;   % [m] p14, COM swingarm
z14 = -0.330;   % [m] p14, COM swingarm
r_tcf = 0.049;  % [m]      Front camber const.
r_tcr = 0.07;   % [m]      Rear camber const.
fwrad = 0.30;   % [m]      Front wheel radius (updated)
rwrad = 0.33;   % [m]      Rear wheel radius (updated)
epsilon = 0.8378; % rad    Steer axle inclination with the vertical (Rake angle) - 24 degrees (updated)

% Suspension parameters.
r_sprld0 = 1540.0;       % Nominal rear spring load 
f_sprld0 = 940.0;        % Nominal front spring load 
Ksf = 9000.0;            % Stiffness suspension front
Csf = 550.0;             % Damping suspension front
Ksr = 25700.0;           % Stiffness suspension rear
Csr = 1100.0;            % Damping suspension rear
Ktf = 115000.0;          % Stiffness tire front 
Ktr = 170000.0;          % Stiffness tire rear  
fw_ld0 = 1250.0;         % Static load front wheel (without driver?) 
rw_ld0 = 1792.0;         % Static load rear wheel (without driver?)

% Stiffness and damping parameters.
Kp_ubr = 10000.0;        % Stiffness rider upper body
Cp_ubr = 85.2;           % Damping rider upper body = 2*factor*sqrt(Kp,m)
Kp_twst = 34100.0;       % Stiffness frame twist 
Cp_twst = 99.7;          % Damping frame twist
Kp_str = 0.0;            % Stiffness steering system
%Kp_sts = 1000000.0;     % No idea, but doesn't seem to be used
Cp_str = 7.4;            % Damping steering system


% Tyre parameters.
% From tire model used in "The dynamic behaviour of a motorcycle when
% running straight ahead and when cornerning" by C. Koenen

C_Mgf = 4.8;             % Coefficient camber aligning moment front
C_Mgr = 7.9;             % Coefficient camber aligning moment rear
C_Faf = 1.85e4;          % Coefficient side slip stiffness (dFy/dalpha)front 
C_Far = 2.58e4;          % Coefficient side slip stiffness (dFy/dalpha)rear
C_Fgf = 1.71e3;          % Coefficient lateral camber force with relaxation
C_Fgr = 2.80e3;          % Coefficient lateral camber force with relaxation
p_agf = 0.46;            % Coefficient side force and slip angle (common expression)
p_agr = 0.4;             % Coefficient side force and slip angle (common expression)
p_ggf = 0.36;            % Coefficient side force and camber angle (lat. camber force)
p_ggr = 0.5;             % Coefficient side force and camber angle (lat. camber force)
q_aaf = 10.1;            % Coefficient aligning moment with relaxation
q_aar = 10.1;            % Coefficient aligning moment with relaxation
q_ggf = 5.1;             % Coefficient camber aligning moment 
q_ggr = 5.1;             % Coefficient camber aligning moment
t_pf = 0.03;             % Pneumatic trail front
t_pr = 0.03;             % Pneumatic trail rear
n_af = 14;               % Load dependency coefficient due to side slip front
n_ar = 1.9;              % Load dependency coefficient due to side slip rear
n_gf = 1.3;              % Load dependency coefficient due to camber front
n_gr = 1.69;             % Load dependency coefficient due to camber rear
sigma_fyr = 0.25;        % Tire relaxation length rear
sigma_fyf = 0.25;        % Tire relaxation length front 
%r_sl_stf = 20000;       % Doesn't seem to be used in the model 
%f_sl_stf = 15000;       % Doesn't seem to be used in the model 

% Set-defaults
theta = 0.0;             % [deg] Grade angle (gravity)
brake = 0.0;             % Brake ratio 
satf = 4800;             % [N]   Saturation force of the tire
v_ini = 30.0;            % [m/s] Initial velocity


% Suspension pickup points.
Pickup.p1.name  = 'Aerodynamics centre of pressure';
Pickup.p1.coordinates = eval(['[x1 0 z1]']);
Pickup.p2.name = 'Twist axis joint with rear frame';
Pickup.p2.coordinates = eval(['[x2 0 z2]']);
Pickup.p3.name = 'Centre of mass of front frame steer body'; 
Pickup.p3.coordinates = eval(['[x3 0 z3]']);
Pickup.p4.name = 'Joint co-ordinate for front frame suspension and steer bodies'; 
Pickup.p4.coordinates = eval(['[x4 0 z4]']);
Pickup.p5.name = 'Centre of mass of front suspension body';
Pickup.p5.coordinates = eval(['[x5 0 z5]']);
Pickup.p6.name = 'Front wheel attachment point'; 
Pickup.p6.coordinates = eval(['[x6 0 z6]']);
Pickup.p7.name = 'Rear wheel centre point'; 
Pickup.p7.coordinates = eval(['[x7 0 z7]']);
Pickup.p8.name = 'Centre of mass of the main frame'; 
Pickup.p8.coordinates = eval(['[x8 0 z8]']);
Pickup.p9.name =  'Attachment point for rider on rear frame'; 
Pickup.p9.coordinates = eval(['[x9 0 z9]']);
Pickup.p10.name = 'Rider centre of mass'; 
Pickup.p10.coordinates = eval(['[x10 0 z10]']);
Pickup.p11.name = 'Swinging arm joint point to main frame'; 
Pickup.p11.coordinates = eval(['[x11 0 z11]']);
Pickup.p12.name = 'Attachment point for the rear spring onto bottom link'; 
Pickup.p12.coordinates = eval(['[x12 0 z12]']);
Pickup.p13.name = 'Attachment point for the rear spring onto main frame'; 
Pickup.p13.coordinates = eval(['[x13 0 z13]']);
Pickup.p14.name = 'Centre of mass of swing arm'; 
Pickup.p14.coordinates = eval(['[x14 0 z14]']);

% Torque-->Inputs block
inputs.del_min  = 0.05 ;    % Minimum delta-steering angle

% tranfer function relating [input] steering angle (\delta_{ref}) and
% [output] steering torque
inputs.del_tf_num = -10*[5] ; 
inputs.del_tf_den = [1 5] ;

% Engine parameters
% Engine = min(-inputs.engine_a1*acc, inputs.engine_a2) +
%                max(-inputs.engine_b1*acc, inputs.engine_b2) ;
inputs.engine_a1 = 150 ;
inputs.engine_a2 = 0 ;
inputs.engine_b1 = 750 ;
inputs.engine_b2 = 0 ;

% Aerodynamics block
A   = 0.36;                     % Frontal area of the bike incl rider
Cd  = 0.88;                     % Aerdynamic drag coefficient 
CDA = A*Cd;                     % Aerodynamic drag constant 
CLA = 0.114;                    % Aerodynamic lift constant = (Cl*A) 
Aero.Drag = -0.5*1.227*CDA ;    % Is multiplied with v^2 in simulink model 
Aero.Lift = -0.5*1.227*CLA ;    % Is multiplied with v^2 in simulink model 

% Rear brake block
speedcontrol.const = -80 ; % Default at -80

% The Body decelerates on changing this to zero.
tstop = 80 ; % Simulation time
%% Relationship between throttle and obtained acceleration
x = -1:0.25:1 ;                                         % applied throttle
y = [-18.42;-13.63;-8.5;-3.895;0.59;1.47;2.35;3.22;4] ; % obtained acc.
plot(x,y,'-*')
xlabel('Applied throttle [-]')
ylabel('Obtained acc. [m/s^2]')
grid on

%% Relationship between applied and obtained steering


%% Test-1: Throttle and Acceleration
%load('Data\Simple Acc,Steering inputStraightwith brake.mat')
%tstop = t(end) ;
%a2 = interp1(y,x,a) ;
%v_ini = 0 ;
%%
%plot(a2,a,'-o')
%hold on
%plot(x,y,'-*')