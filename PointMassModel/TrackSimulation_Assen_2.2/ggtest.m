%% Plot GG-diagrams 
clear all
% Dimensionalized parameters
b = 1.4;                     % Wheelbase [m]
c_b = 0.4;                  % Coefficient for location COG to rear wheel
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
[sol1] = fsolve(fun1 == ellipse, [1.5,0]);
%[sol2] = fsolve(f3 == (ax/mu_x)^2 + (ay/mu_y)^2 - 1,[ax,ay]);
%sol1 = [eval(sol1.ax), eval(sol1.ay)]
%sol2 = [eval(sol2.ax), eval(sol2.ay)]
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
 text(1,5,-0.5,'-26,5')
 yline(0,'LineStyle','-.')
 yline(0.5,'LineStyle','-.')
 text(1,5,0.5,'26,5')
 yline(1,'LineStyle','-.')
 yline(1.5,'LineStyle','-.')
hold off; 

function [val1] = fun1(ax,ay)
val1 = (1/(a_nd + h_nd*(ax/(sqrt(1+ay^2))))*ax/(mu_x)*alpha)^2+(ay/(mu_y))^2-1;
end 

function [val2] = fun2(ax,ay)
val2 = b_nd - h_nd*(ax/(sqrt(1+ay^2)));
end 

function [ell] = ellipse(ax,ay)
ell = (ax/mu_x)^2 + (ay/mu_y)^2 - 1;
end