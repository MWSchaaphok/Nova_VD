% Motorcycle model definition file.
% Author(s): G.D Wood
% Copyright 1990-2002 The MathWorks, Inc.

% Inertia parameters.
Mff_str = 13.1;  % kg.  Mass of the front steering body (steering axle + suspension)
Mff_sus = 17.5;  % kg.  Mass of the suspension
Mmain  = 209.6;  % kg.  Mass of the main frame
Mfw = 25.6;      % kg.  Mass of the front wheel
Mrw = 25.6;      % kg.  Mass of the rear wheel
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
x1  =  0.770;   % m
z1  = -0.582;   % m
x2  =  1.168;   % m
z2  = -0.834;   % m
x3  =  1.165;   % m
z3  = -0.869;   % m
x4  =  1.225;   % m
z4  = -0.867;   % m
x5  =  1.539;   % m
z5  = -0.318;   % m
x6  =  1.539;   % m
z6  = -0.318;   % m
x7  =  0.000;   % m
z7  = -0.321;   % m
x8  =  0.680;   % m
z8  = -0.532;   % m
x9  =  0.600;   % m
z9  = -1.000;   % m
x10 =  0.600;   % m
z10 = -1.190;   % m
x11 =  0.400;   % m
z11 = -0.321;   % m
x12 =  0.000;   % m
z12 = -0.330;   % m
x13 =  0.000;   % m
z13 = -0.700;   % m
x14 =  0.100;   % m
z14 = -0.330;   % m
r_tcf = 0.049;  % m  Front camber const.
r_tcr = 0.07;   % m  Rear camber const.
fwrad = 0.319;  % m  Front wheel radius
rwrad = 0.321;  % m  Rear wheel radius
epsilon = 0.52; %rad Steer axle inclination with the vertical (Rake angle)

% Suspension parameters.
r_sprld0 = 1540.0;  
f_sprld0 = 940.0;  
Ksf = 9000.0;  
Csf = 550.0;  
Ksr = 25700.0;
Csr = 1100.0; 
Ktf = 115000.0;  
Ktr = 170000.0;  
fw_ld0 = 1250.0;  
rw_ld0 = 1792.0;

% Stiffness and damping parameters.
Kp_ubr = 10000.0;
Cp_ubr = 85.2;  
Kp_twst = 34100.0;  
Cp_twst = 99.7;  
Kp_str = 0.0;
Kp_sts = 1000000.0;  
Cp_str = 7.4;  


% Tyre parameters.
C_Mgf = 4.8;
C_Mgr = 7.9;
C_Faf = 1.85e4;
C_Far = 2.58e4;
C_Fgf = 1.71e3;
C_Fgr = 2.80e3;
p_agf = 0.46;  
p_agr = 0.4;
p_ggf = 0.36;  
p_ggr = 0.5;  
q_aaf = 10.1;  
q_aar = 10.1; 
q_ggf = 5.1;  
q_ggr = 5.1;
t_pf = 0.03; 
t_pr = 0.03;  
n_af = 14;  
n_ar = 1.9;  
n_gf = 1.3; 
n_gr = 1.69;
sigma_fyr = 0.25;  
sigma_fyf = 0.25;  
r_sl_stf = 20000;  
f_sl_stf = 15000;

% Set-defaults
theta = 0.0; % Grade angle (gravity)
brake = 0.0; % Brake ratio 
satf = 4800; % Saturation force of the tire
v_ini = 30.0; % m/s Initial velocity


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
inputs.del_min  = 0.05 ; % Minimum delta-steering angle

% tranfer function relating [input] steering angle (\delta_{ref}) and
% [output] steering torque
inputs.del_tf_num = -10*[5] ; 
inputs.del_tf_den = [1 5] ;

% Engine parameters
% Engine = min(-inputs.engine_a1*acc, inputs.engine_a2) +
%                max(-inputs.engine_b1*acc, -inputs.engine_b2) ;
inputs.engine_a1 = 150 ;
inputs.engine_a2 = 0 ;
inputs.engine_b1 = 750 ;
inputs.engine_b2 = 0 ;

% Aerodynamics block
CDA = 0.312;  
CLA = 0.114;
Aero.Drag = -0.5*1.227*CDA ;
Aero.Lift = -0.5*1.227*CLA ;

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
load('Data\Simple Acc,Steering inputStraightwith brake.mat')
tstop = t(end) ;
a2 = interp1(y,x,a) ;
v_ini = 0 ;
%%
plot(a2,a,'-o')
hold on
plot(x,y,'-*')