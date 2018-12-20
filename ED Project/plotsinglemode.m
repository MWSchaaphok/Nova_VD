%This code lets you either plot an eigenshape of the undamped case or the
%response of a single mode given the initial conditions



%plot single mode
mode=6;
time=10;
steptime=0.001;



%amp=transpose(Evecs(:,mode))*Ml*qdisp; To check the real response to a specific displacement, use this one


%To see the eigenshape, enable this one
amp=0.8;


%normal eqs
normal=amp*exp(Eigenfreq(mode)*1i*t);

%solutions
solution=normal*Evecs(:,mode);




%This loop plots the solution for each timestep so that you can see the
%real time motion
for k=0:steptime:time
    solplot= qtest + double(subs(solution,t,k));
   

qpl=solplot;


ytB=qpl(1);
ytF=qpl(2);
xf=qpl(3);
yf=qpl(4);
B=qpl(5);
thetaf=qpl(6);
thetaF=qpl(7);
thetaB=qpl(8);
thetatb=qpl(9);
s=qpl(10);
thetatf=qpl(11);
Rthetaf=[cos(thetaf) -sin(thetaf); sin(thetaf) cos(thetaf)];

RB=[cos(B) -sin(B); sin(B) cos(B)];

P1= [xf;yf] + Rthetaf*[x1i;y1i];
P2= [xf;yf] + Rthetaf*[x2i;y2i];
P3= [xf;yf] + Rthetaf*[x3i;y3i];
P4= [xf;yf] + Rthetaf*[x4i;y4i];
frame=[xf;yf];
backrim= P4;
body= P3 + RB*[0;lb];
frontrim=Rthetaf*( [x1i;y1i] + s*[-sin(asus) ; -cos(asus)]) + frame;
fronttire=[-rtire*thetatf; ytF];
backtire=[-rtire*thetatb; ytB];
hand=P3 + RB*[0;Lb];
head=P3 + RB*[0;Lb+Lb*0.3]; 


xB=backrim(1);
yB=backrim(2);
xb=body(1);
yb=body(2);
xF=frontrim(1);
yF=frontrim(2);
xtF=fronttire(1);
xtB=backtire(1);



qx=transpose([xtF xF xtB xB xb xf]);
qy=transpose([ytF yF ytB yB yb yf]);

scatter(qx,qy)
axis([-0.5 1.3 -0.4 1.4])
hold on
Px=[xF;P1(1);P2(1);P3(1);P4(1);P1(1)];
Py=[yF;P1(2);P2(2);P3(2);P4(2);P1(2)];
scatter(hand(1),hand(2))
humanx=[P3(1);hand(1);head(1);hand(1);P2(1)];
humany=[P3(2);hand(2);head(2);hand(2);P2(2)];
title(num2str(k))
plot(Px,Py)
plot(humanx,humany)
circle(head(1),head(2),rwheel*0.8)
circle(xtF,ytF,rtire)
circle(xtB,ytB,rtire)
circle(xF,yF,rwheel)
circle(xB,yB,rwheel)
pause(steptime)
hold off
end