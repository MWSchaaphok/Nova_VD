% ENGINEERING DYNAMICS ASSIGNMENT - TUDelft 
% Ata Keþkekler, Erdi Akyüz 2016
% Dynamics of STV



clc
clear all

%Assigning variables and constants
format short e
syms xb yb xB yB xtB ytB xF yF xtF ytF xf yf B thetaf thetaF thetatf thetaB thetatb psi s Vft Vbt xbd ybd xBd yBd xtBd ytBd xFd yFd xtFd ytFd xfd yfd Bd thetafd thetaFd thetatfd thetaBd thetatbd sd xbdd ybdd xBdd yBdd xtBdd ytBdd xFdd yFdd xtFdd ytFdd xfdd yfdd Bdd thetafdd thetaFdd thetatfdd thetaBdd thetatbdd sdd t
g=9.81; mwheel=2.1; mtire=1; mf=8; mb=70; rwheel=0.15; rtire=0.25; Iwheel=mwheel*rwheel^2 ; Itire=mtire*rtire^2;
rf=0.5; rb=0.34; If=mf*rf^2 ; Ib=mb*rb^2 ; afb=35*(pi/180); Lsus=0.5; Larm=0.45; asus=15*(pi/180);
Lb=0.5; lb=0.3;  x1i=-0.32 ; x2i=-0.31 ; x3i=0.1 ; x4i=0.4; y1i=0.28; y2i=0.35; y3i=0.28; y4i=-0.25;
kcont0=1.4*10^4 ; kcont2=1.8*10^9; ksus=10^5; ccont=2*10^2 ; csus=5*10^3 ; ktire=5.1*10^3; karm=0.9*10^5;
kpel=8*10^3; carm=10^3;


%Defining the rotation matrix caused by frame rotation
Rthetaf=[cos(thetaf) -sin(thetaf); sin(thetaf) cos(thetaf)];

%Rotation matrix of body
RB=[cos(B) -sin(B); sin(B) cos(B)];


%Points on the frame as defined at assignment
P1= [xf;yf] + Rthetaf*[x1i;y1i];
P2= [xf;yf] + Rthetaf*[x2i;y2i];
P3= [xf;yf] + Rthetaf*[x3i;y3i];
P4= [xf;yf] + Rthetaf*[x4i;y4i];


%Determination of the relative positions of necessary points
frame=[xf;yf];
backrim=P4;
body= P3 + RB*[0;lb];
frontrim=Rthetaf*( [x1i;y1i] + s*[-sin(asus) ; -cos(asus)]) + frame;
fronttire=[ -rtire*thetatf; ytF];
backtire=[  -rtire*thetatb; ytB];
hand=P3 + RB*[0;Lb]; 

%Generalized Coordinates
q=transpose([ytB ytF xf yf B thetaf thetaF thetaB thetatb s thetatf]);

xB=backrim(1);
yB=backrim(2);
xb=body(1);
yb=body(2);
xf=frame(1);
yf=frame(2);
xF=frontrim(1);
yF=frontrim(2);
xtF=fronttire(1);
ytF=fronttire(2);
xtB=backtire(1);
ytB=backtire(2);


%Spring lengths to use in potential energy
rspringfront=sqrt(transpose((frontrim + rwheel*[cos(psi+thetaF); sin(psi+thetaF)]) - (fronttire + rtire*[cos(psi+thetatf);sin(psi+thetatf)]))*((frontrim + rwheel*[cos(psi+thetaF); sin(psi+thetaF)]) - (fronttire + rtire*[cos(psi+thetatf);sin(psi+thetatf)])));
rspringback= sqrt(transpose((backrim + rwheel*[cos(psi+thetaB); sin(psi+thetaB)]) - (backtire + rtire*[cos(psi+thetatb);sin(psi+thetatb)]))*((backrim + rwheel*[cos(psi+thetaB); sin(psi+thetaB)]) - (backtire + rtire*[cos(psi+thetatb);sin(psi+thetatb)])));
armspring=sqrt(transpose((P2-hand))*(P2-hand));

%Generalized accelerations and velocities
qd=transpose([ytBd ytFd xfd yfd Bd thetafd thetaFd thetaBd thetatbd sd thetatfd]);
qdd=transpose([ytBdd ytFdd xfdd yfdd Bdd thetafdd thetaFdd thetaBdd thetatbdd sdd thetatfdd]);
    
%Velocities of relative points which aren't generalized coordinates
xFd    = jacobian(xF,q) *qd;
yFd    = jacobian(yF,q) *qd;
xtFd   = jacobian(xtF,q)*qd;
xtBd   = jacobian(xtB,q)*qd;
xBd    = jacobian(xB,q) *qd;
yBd    = jacobian(yB,q) *qd;
xbd    = jacobian(xb,q) *qd;
ybd    = jacobian(yb,q) *qd;

ud=[xFd;yFd;xtFd;xtBd;xBd;yBd;xbd;ybd];


%Potential energies

%Front and Back tires, integrated around
Vft=simplify(0.5*ktire*int((rspringfront)^2,psi,0,2*pi));
Vbt=simplify(0.5*ktire*int((rspringback)^2,psi,0,2*pi));

%Fcont is integrated in order to write as a potential
Vcont=0.5*kcont0*ytF^2 + 0.25*kcont2*ytF^4 + 0.5*kcont0*ytB^2 + 0.25*kcont2*ytB^4;

%Total Potential Energy
V=0.5*ksus*(Lsus-s)^2 + 0.5*karm*(Larm - armspring)^2 + 0.5*kpel*((B-thetaf)-afb)^2 + Vft + Vbt + ...
    g*(mwheel*yF + mf*yf + mwheel*yB + mtire*ytB + mtire*ytF + mb*yb) + Vcont;

%Total Kinetic Energy
T=0.5*mb*(xbd^2+ybd^2) + 0.5*mwheel*(xFd^2+yFd^2) + 0.5*mwheel*(xBd^2+yBd^2) + 0.5*mtire*(xtFd^2+ytFd^2) + 0.5*mtire*(xtBd^2+ytBd^2)+...
    0.5*mf*(xfd^2 + yfd^2) + 0.5*If*(thetafd)^2 + 0.5*Ib*(Bd)^2 + 0.5*Iwheel*(thetaBd)^2 + 0.5*Itire*(thetatbd)^2+...
    0.5*Iwheel*(thetaFd)^2 + 0.5*Itire*(thetatfd)^2 ;


%Writing the lagrangian in order to find EoM
dV_dq = transpose(simplify(jacobian(V,q))) ;
dT_dq=transpose(simplify(jacobian(T,q)));
dT_dqd=transpose(simplify(jacobian(T,qd)));
d_dtdT_dqd =  simplify(jacobian(dT_dqd,t)) + simplify(jacobian(dT_dqd,q))*qd + simplify(jacobian(dT_dqd,qd))*qdd;

fkin=d_dtdT_dqd - dT_dq;
fpot=dV_dq;

%EoM
Equations = d_dtdT_dqd - dT_dq + dV_dq ;

%K matrix of nonfixed system
K=jacobian(dV_dq,q);
rank(K) %See that it is singular

%Everything written when thetatf fixed so that there are 10 generalized
%coordinates
qfix=transpose([ytB ytF xf yf B thetaf thetaF thetaB thetatb s]);
qdfix=transpose([ytBd ytFd xfd yfd Bd thetafd thetaFd thetaBd thetatbd sd]);
qddfix=transpose([ytBdd ytFdd xfdd yfdd Bdd thetafdd thetaFdd thetaBdd thetatbdd sdd]);
Vfix=subs(V,thetatf,0);
Tfix=subs(T,[thetatf, thetatfd, thetatfdd],[0,0,0]);
dV_dqfix = transpose(simplify(jacobian(Vfix,qfix))) ;
dT_dqfix=transpose(simplify(jacobian(Tfix,qfix)));
dT_dqdfix=transpose(simplify(jacobian(Tfix,qdfix)));
d_dtdT_dqdfix =  simplify(jacobian(dT_dqdfix,t)) + simplify(jacobian(dT_dqdfix,qfix))*qdfix + simplify(jacobian(dT_dqdfix,qdfix))*qddfix;

fkinfix= d_dtdT_dqdfix - dT_dqfix;

Equationsfix = d_dtdT_dqdfix - dT_dqfix + dV_dqfix ;



Kfix=jacobian(dV_dqfix,qfix);

%An initial guess for Newton-Rhapson Method(which is the system positions
%at xf and yf = 0 and all springs are at their natural lengths.
ytBg=y4i;
ytFg= subs(- sin(thetaf)*((291404338770025*s)/1125899906842624 + 8/25) - cos(thetaf)*((8700286382685973*s)/9007199254740992 - 7/25),[thetaf,s],[0,Lsus]);
xfg=0;
yfg=0;
Bg=afb;
thetaf=0;
thetaFg=0;
thetatfg=0;
thetaBg=afb;
thetatbg=0;
sg=Lsus;

qgfix=double([ytBg ; ytFg; xfg; yfg; Bg; thetaf; thetaFg; thetaBg; thetatbg; sg]);
qe=qgfix;
r=subs(dV_dqfix,qfix,qgfix);
i=1;
%Implementation of Newton-Rhapson method using the initial guess for the
%fixed case
while norm(r)>(10^-10)
    Kt=double(subs(Kfix,qfix,qe));
    deltaq=double(-inv(Kt)*r);
    qe=double(qe+deltaq);
    r=subs(dV_dqfix,qfix,qe);
    disp(double(r));
    i=i+1;
end

%Checking equilibrium points on both EoMfix and EoM
checkeomfix=subs(Equationsfix,qfix,qe);
checkeomfix=subs(checkeomfix,qdfix,zeros(10,1));
checkeomfix=subs(checkeomfix,qddfix,zeros(10,1));

disp('Fixed:')
double(checkeomfix)

%Checking if it is also equilibrium for nonfixed case
qtest=qe;
qtest(end+1)=0;
checkeom=subs(Equations,q,qtest);
checkeom=subs(checkeom,qd,zeros(11,1));
checkeom=subs(checkeom,qdd,zeros(11,1));

disp('Nonfixed:')
double(checkeom)





%LINEARIZATION


%Linearizing
syms ytBl ytFl xfl yfl Bl thetafl thetaFl thetaBl thetatbl sl thetatfl ytBld ytFld xfld yfld Bld thetafld thetaFld thetaBld thetatbld sld thetatfld ytBldd ytFldd xfldd yfldd Bldd thetafldd thetaFldd thetaBldd thetatbldd sldd thetatfldd w

ql=transpose([ytBl ytFl xfl yfl Bl thetafl thetaFl thetaBl thetatbl sl thetatfl]);
qld=transpose([ytBld ytFld xfld yfld Bld thetafld thetaFld thetaBld thetatbld sld thetatfld]);
qldd=transpose([ytBldd ytFldd xfldd yfldd Bldd thetafldd thetaFldd thetaBldd thetatbldd sldd thetatfldd]);


Kl=subs(K,q,qtest);
Ml=subs(simplify(jacobian(jacobian(T,qd),qd)),q,qtest);

EoMlinundamped=Ml*qldd + Kl*ql;

%Adding the associated damping forces to the lagrangians
Qsus=jacobian(s,q)'*(-csus*sd);
QtF=jacobian(ytF,q)'*(-ccont*ytFd);
QtB=jacobian(ytB,q)'*(-ccont*ytBd);
armspringd=jacobian(armspring,t)+jacobian(armspring,q)*qd;
Qarm=jacobian(armspring,q)'*(-carm*armspringd);
Qdamping=Qsus+QtF+QtB+Qarm;
EOMdamping=Equations-Qdamping;


%Evaluating the corresponding C matrix at the equilibrium
C=jacobian(EOMdamping,qd);
Cl=subs(C,q,qtest);
Cl=subs(Cl,qd,zeros(11,1));
Cl=subs(Cl,qdd,zeros(11,1));




positivedefinite = all(eig(vpa(Kl)) > 0); %checking stability of the system


%Linearized equations of motion with damping
EoMlin=Ml*qldd + Cl*qld + Kl*ql;

%Eigenvectores and Eigenvalues of undamped system
[Evecs,Evals]=eig(double(Kl),double(Ml));


Eigenfreq = sqrt(diag(Evals));



Genmass=double(transpose(Evecs(:,1))*Ml*Evecs(:,1)); %seeing that generalized mass is unity so I can directly use
%my vectors to find amplitudes of normal equations



%Evaluating the modal damping terms to decouple 
Bkk=0;
for i=1:1:11
        Bkk(i)=Evecs(:,i)'*Cl*Evecs(:,i);
end

%effect of damping
dlambda=double(-Bkk/(2*Genmass));



%Implementing the normal equations to observe a response from a specific
%initial condition

qdisp=0.8*qtest; % displacement from equilibrium to see the response





qdisp=qdisp-qtest;

%modal amplitudes with respect to displacements
for i=1:1:11
   amps(i)=transpose(Evecs(:,i))*Ml*qdisp;
end

%normal eqs

for i=1:1:11
    normals(i)=amps(i)*exp((dlambda(i)+Eigenfreq(i)*1i)*t);
end

%overall solution for the generalized coordinates
solution=0;
for i=1:1:11
    line= normals(i)*Evecs(:,i);
    solution=line+solution;
end



%Response to the steps


Y=0.1; %[m] step of height

wheel_base=Lsus*sin(asus)-x1i(1)+x4i(1); %[m]

%Calculating the time between tires getting influenced by step
speed=1;
deltat1=wheel_base/speed;





