dt = 0.1; 
u1 = 0*ones(1,1/dt+1);
u2 = 0*ones(1,1/dt+1);
u3 = zeros(1,1/dt+1);
u4 = zeros(1,1/dt+1);
u = [u1; u2; u3; u4]';
x = zeros(1/dt+1,26);
p = parameters();
x(1,:) = coordinates();

t = 0:dt:1;
for i = 2:(1/dt+1)
    [fx(i,:),vlr(i,:),vlf(i,:),Flr(i,:),r0(i,:),r7(i,:)] = motorcycle_mdl(u(i,:),x(i-1,:),p);
    x(i,:) = x(i-1,:) + dt*(fx(i,:)); 
end 