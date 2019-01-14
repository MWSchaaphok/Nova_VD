 clc
 clear all
 load('East-Northco-ord.mat')
 %%

 la = 5 ;
 lb = -5 ;
 [x_new,y_new] = para_curves(E,N,la) ;
 [x_new2,y_new2] = para_curves(E,N,lb) ;
 
 figure
 plot(E,N,'--k')
 hold on
 plot(x_new,y_new,'or')
 hold on
 plot(x_new2,y_new2,'ob')
 axis equal