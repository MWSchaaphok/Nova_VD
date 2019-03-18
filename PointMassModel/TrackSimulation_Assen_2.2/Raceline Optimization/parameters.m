function [par] = parameters()
%%% Track parameters
par.ds = 1;

%%% Bike measurements %%%
par.m =  290;              % Mass of the motorcycle with the rider 310, without 230 [kg]
par.g =  9.81;             % Gravitational constant [ms-2]
par.b =  1.45;             % Wheelbase [m] 
par.c_h = 0.38;            % Coefficient COG height
par.h = par.c_h*par.b;     % Height COG [m] -> temporary approx based on Foalte/Cossalter
par.d = 2.02;              % Circumference wheel
par.l1 = 0.48;             % Coefficient for weight distribution front [N]
par.l2 = 1-par.l1;         % Coefficient for weight distribution back  [N]
par.t  = 0.4;              % Thickness of the body

%%% Constants for friction force based on Hoerner %%%
par.a1 = 0.005;
par.b1 = 0.15;
par.c = 0.000035;

%%% Recommended pressure in tires %%%
par.Pf=27.5571702;          % lbf/inch^2 
par.Pr=31.9083023;          % lbf/inch^2

%%% Drag Force %%%
par.Cd=0.88;                % Drag force coefficient
par.A=0.36;                 % Frontal area of the bike with rider flat (m^2)
par.rho=1.225;              % Sea level density in Pascals

%%% lift force %%%
par.Cl=0.12;                % Lift force coefficient mulitlied by frontal area = C*A

%%% Driving force %%%
par.mu_static=1;            % Static friction coefficient for rear tire
par.mu_dynamic=1.1;         % Dynamic friction coefficient for rear tire 0.85
par.Tm = 260;               % Continuous driving torque

%%% Power %%%
%P=110;                     % Max power of the motor [kW]
par.gear_ratio = 1/1.9;     % gear ratio (between motor and sprochet) - 17/41

%%% Radia %%%
par.Rw = 0.3;               % Wheel radius




end 