%% Constant
%%% Bike measurements %%%
m=310;                 % Mass of the motorcycle with the rider 310, without 250 [kg]
g=9.81;                % Gravitational constant [ms-2]
b = 1.4;               % Wheelbase [m] 
h = 0.375*b;           % Height COG [m] -> temporary approx based on Foalte/Cossalter
d = 2.02;              % Circumference wheel
l1 = 0.464;            % Length for weigh distribution front [N]
l2 = 0.536;            % Length for weight distribution back  [N]

%%% Constants for friction force based on Hoerner %%%
a1 = 0.005;
b1 = 0.15;
c = 0.000035;

%%% Recommended pressure in tires %%%
Pf=27.5571702;          % lbf/inch^2 
Pr=31.9083023;          % lbf/inch^2

%%% Drag Force %%%
Cd=0.88;                % Drag force coefficient
A=0.36;                 % Frontal area of the bike with rider flat (m^2)
rho=1.225;              % Sea level density in Pascals

%%% lift force %%%
Cl=0.12;                % Lift force coefficient mulitlied by frontal area = C*A

%%% Driving force %%%
mu_static=1;            % Static friction coefficient for rear tire
mu_dynamic=0.85;         % Dynamic friction coefficient for rear tire

%%% Power %%%
%P=110;                  % Max power of the motor [kW]
gear_ratio = 17/41;     % gear ratio (between motor and sprochet) - 17/41

%%% Radia %%%
Rw = 0.3;               % Wheel radius
Rm = 0.0435;            % Motor shaft radius
Rs = 0.11;              % Sprochet radius


