%% Plot GG-diagrams 
clear all
% Dimensionalized parameters
p = 1.4;                     % Wheelbase [m]
b = 0.5*p;                  % Distance COG to rear wheel [m]
a = p - b;                   % Distance COG to front wheel [m]
h = 0.6;                     % Height COG [m]
alpha = 1;                   % Distribution acceleration/braking
mu_x  = 1.1;                 % Longitudinal friction coefficient
mu_y = 1.1;                    % Lateral friction coefficient
g = 9.81;

% Non-dimensionalized parameters
h_nd = h/p;
b_nd = b/p;
a_nd = 1-b_nd;




syms ax ay 
f1(ay,ax) = (1/(a_nd + h_nd*(ax/(sqrt(1+ay^2))))*ax/(mu_x)*alpha)^2+(ay/(mu_y))^2-1;
f2(ay,ax) = b_nd - h_nd*(ax/(sqrt(1+ay^2)));
f3(ay,ax) = (1/(b_nd - h_nd*(ax/(sqrt(1+ay^2))))*ax/(mu_x)*alpha)^2 + (ay/(mu_y))^2 -1;
f4(ay,ax) = a_nd + h_nd*(ax/(sqrt(1+ay^2)));
figure; 
fimplicit(f1(ay,ax), [0,1.5,-1.5,1.5])
hold on
fimplicit(f2(ay,ax) ,[0,1.5,-1.5,1.5])
alpha = 0.5; 
fimplicit(f3(ay,ax) ,[-1.5,0,-1.5,1.5])
fimplicit(f4(ay,ax) ,[-1.5,0,-1.5,1.5])
title('GG diagram')
xlabel('a_x (non-dimensional)')
ylabel('a_y (non-dimensional)')

 xline(-1.5,'LineStyle','-.')
 xline(-1,'LineStyle','-.')
 xline(-0.5,'LineStyle','-.')
 xline(0,'LineStyle','-.')
 xline(0.5,'LineStyle','-.')
 xline(1,'LineStyle','-.')
 xline(1.5,'LineStyle','-.')
hold off; 