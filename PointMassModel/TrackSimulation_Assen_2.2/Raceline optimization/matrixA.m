function [A] = matrixA(i,par,v)
Cf = 160*ones(size(v));
Cr = 180*ones(size(v));
Iz = 2250; 

a = par.l1*par.b;
b = par.b-a; 
A = [ 0 v(i) 0 v(i) 0 ; 0 0 1 0 0 ; ...
      0 0 -(a^2*Cf(i) + b^2*Cr(i))/(v(i)*Iz) (b*Cr(i) - a*Cf(i))/Iz 0 ; ...
      0 0 ((b*Cr(i) - a*Cf(i))/(par.m*v(i)^2)-1) -((Cf(i) + Cr(i))/(par.m*v(i))) 0 ; 0 0 1 0 0 ];
end 