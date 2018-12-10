%% Laptime - location CG optimization
clear all

%% Using optimization scheme
% Okay the optimization itself seems to be working fine. The problem
% basically in the computed maximum deceleration. If we adapt the
% ForwardBackwardPass to include the constraints from the GG-diagrams it
% should optimize a lot better. 

% track = 'Straight';
% laps = 1; 
% %pos(1) = l1;
% %pos(2) = h;
% options = optimset('PlotFcns',@optimplotfval);
% fun = @(pos) Laptime_FB(track,laps,pos(1),pos(2)) ;
% pos_guess = [0.5 0.5];
% [pos_min,fval] = fmincon(fun,pos_guess,[],[],[],[],[0.3, 0.1],[0.8, 0.6]);
% l1 = pos_min(1)
% h = pos_min(2) 

% % Making 3D plot 
% %Using self defined combinations
l1 = 0.2:0.1:0.8;
h  = 0.1:0.1:0.8;
figure;
laptime = zeros(size(l1,2),size(h,2)); 
for j = 1:size(l1,2)
    id=1; 
    
    for i = 1:size(h,2)
   
        laptime(j,id) = Laptime_FB('Assen_optimal',1,l1(j),h(i)); 
        id = id+1;
    end 
    plot(h, laptime(j,:)) 
    hold on 
end
 
title('Height COG Laptime Assen for different distance COG to front wheel');
xlabel('Height COG')
ylabel('Laptime (s)')
for i=1:size(l1,2)
    text(h(end),laptime(i,end),['l1\leftarrow',num2str(l1(i))])
end 