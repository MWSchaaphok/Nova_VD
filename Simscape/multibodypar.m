%% Parameters for the simscape multibody model
function [mpar] = multibodypar()

% Chassis parameters 
mpar.body.l = 1.4;              % length body [m]
mpar.body.w = 0.4;              % width body [m]
mpar.body.h = 0.5;              % height body [m]

mpar.totbody = [-0.5*mpar.body.l 0.5*mpar.body.h; -0.5*mpar.body.l 0;-0.25*mpar.body.l 0;...
             -0.25*mpar.body.l -.5*mpar.body.h; 0.25*mpar.body.l -0.5*mpar.body.h; .25*mpar.body.l 0;...
             0.5*mpar.body.l 0;0.5*mpar.body.l 0.5*mpar.body.h];
%% Wheel parameters 
% Front Wheel
wheelf_inner_rad = 18*2.54/2;           % Front wheel cm, 18"
wheelf_outer_rad = 21*2.54/2;           %cm, 21"
wheelf_inner_tread = 6*2.54;     %cm, 6"
mpar.wheelf_outer_tread = 7*2.54;     %cm, 7"
mpar.wheelf_rev = [wheelf_outer_rad -mpar.wheelf_outer_tread/2;...
             wheelf_outer_rad mpar.wheelf_outer_tread/2;...
             wheelf_inner_rad mpar.wheelf_outer_tread/2;...
             wheelf_inner_rad -mpar.wheelf_outer_tread/2;];

 % Front Rim
rim_inner_dia = 15*2.54; %cm, 15"
rim_outer_dia = 18*2.54; %cm, 18"
rim_inner_tread = 4*2.54; %cm, 4"
rim_outer_tread = 5*2.54; %cm, 5"
rim_inner_hub = 5; %cm
rim_outer_hub = rim_inner_hub + (rim_outer_dia/2 - rim_inner_dia/2); %cm, 5"
mpar.rimf_rev = [rim_outer_dia/2 -rim_outer_tread/2;...
           rim_outer_dia/2 rim_outer_tread/2;...
           rim_inner_dia/2 rim_outer_tread/2;...
           rim_inner_dia/2 -rim_inner_tread/2;...
           rim_outer_hub -rim_inner_tread/2;...
           rim_outer_hub rim_outer_tread/2;...
           rim_inner_hub rim_outer_tread/2;...
           rim_inner_hub -rim_outer_tread/2;];        
         
 
% Rear wheel
wheelr_inner_rad = 18*2.54/2;             % Front wheel cm, 18"
wheelr_outer_rad = 21*2.54/2;             %cm, 21"
wheelr_inner_tread = 6*2.54;       %cm, 6"
wheelr_outer_tread = 7*2.54;       %cm, 7"
mpar.wheelr_rev = [wheelr_outer_rad -wheelr_outer_tread/2;...
             wheelr_outer_rad wheelr_outer_tread/2;...
             wheelr_inner_rad wheelr_outer_tread/2;...
             wheelr_inner_rad -wheelr_outer_tread/2;];
         
% Rear rim
rim_inner_dia = 15*2.54; %cm, 15"
rim_outer_dia = 18*2.54; %cm, 18"
rim_inner_tread = 4*2.54; %cm, 4"
rim_outer_tread = 5*2.54; %cm, 5"
rim_inner_hub = 5; %cm
rim_outer_hub = rim_inner_hub + (rim_outer_dia/2 - rim_inner_dia/2); %cm, 5"
mpar.rimr_rev = [rim_outer_dia/2 -rim_outer_tread/2;...
           rim_outer_dia/2 rim_outer_tread/2;...
           rim_inner_dia/2 rim_outer_tread/2;...
           rim_inner_dia/2 -rim_inner_tread/2;...
           rim_outer_hub -rim_inner_tread/2;...
           rim_outer_hub rim_outer_tread/2;...
           rim_inner_hub rim_outer_tread/2;...
           rim_inner_hub -rim_outer_tread/2;];
       
%% Front suspension
Rco = 3;              % Outer radius suspension [cm]
Rci = 2;             % Inner radius suspesnion [cm]
dr = Rco-Rci;           % Cross section suspesnion [cm]
mpar.Lc = 40;                % Length front suspension [cm] 
mpar.cyl_xsec = [0 -mpar.Lc/2; Rco -mpar.Lc/2; 
            Rco mpar.Lc/2; Rci mpar.Lc/2; 
            Rci -mpar.Lc/2+dr; 0 -mpar.Lc/2+dr]; %cm
mpar.Lp = 20; %cm 
mpar.piston_xsec = [0 -mpar.Lp/2; Rci -mpar.Lp/2; Rci mpar.Lp/2; 0 mpar.Lp/2]; %cm
mpar.Ks = 2000000;%N/m 
mpar.Ds = 100000;%N/(m/s)
mpar.eq_pos = 30;
end