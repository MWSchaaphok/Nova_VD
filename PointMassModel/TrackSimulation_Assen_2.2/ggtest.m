%% Plot GG-diagrams 
clear all
% Dimensionalized parameters
b = 1.4;                     % Wheelbase [m]
c_b = 0.47;                  % Coefficient for location COG to rear wheel
c_h = 0.375;                 % Coefficient height COG
l2 = c_b*b;                  % Distance COG to rear wheel [m]
l1 = b - l2;                 % Distance COG to front wheel [m]
h = c_h*b;                   % Height COG [m]
alpha = 1;                   % Distribution force rear wheel acceleration
mu_x  = 1.3;                 % Longitudinal friction coefficient
mu_y = 1.2;                  % Lateral friction coefficient
g = 9.81;

% Non-dimensionalized parameters
h_nd = h/b;
b_nd = l2/b;
a_nd = 1-b_nd;




syms ax ay 
f1(ay,ax) = (1/(a_nd + h_nd*(ax/(sqrt(1+ay^2))))*ax/(mu_x)*alpha)^2+(ay/(mu_y))^2-1;
f2(ay,ax) = b_nd - h_nd*(ax/(sqrt(1+ay^2)));
f3(ay,ax) = (1/(b_nd - h_nd*(ax/(sqrt(1+ay^2))))*ax/(mu_x))^2 + (ay/(mu_y))^2 -1;
f4(ay,ax) = a_nd + h_nd*(ax/(sqrt(1+ay^2)));
figure; 
fimplicit(f1(ay,ax), [0,1.5,-1.5,1.5])
hold on
fimplicit(f2(ay,ax) ,[0,1.5,-1.5,1.5])
alpha = 0;                                                  % Distribution force rear wheel during braking
fimplicit(f3(ay,ax) ,[-1.5,0,-1.5,1.5])
fimplicit(f4(ay,ax) ,[-1.5,0,-1.5,1.5])
fimplicit((ax/mu_x)^2 + (ay/mu_y)^2 - 1,[-1.5,1.5,-1.5,1.5],'LineStyle','-.')   % friction ellipse  
title('GG diagram')
xlabel('a_x (non-dimensional)')
ylabel('a_y (non-dimensional)')

 yline(-1.5,'LineStyle','-.')
 yline(-1,'LineStyle','-.')
 yline(-0.5,'LineStyle','-.')
 yline(0,'LineStyle','-.')
 yline(0.5,'LineStyle','-.')
 yline(1,'LineStyle','-.')
 yline(1.5,'LineStyle','-.')
hold off; 