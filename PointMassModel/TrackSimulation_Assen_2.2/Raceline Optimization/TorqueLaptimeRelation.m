%% Torque -Laptime curve
clear all
gear_ratio = 1:0.5:4;
Tm = 250;
figure;
laptime = zeros(size(gear_ratio,2),size(Tm,2)); 
for j = 1:size(gear_ratio,2)
    %id=1; 
    
    %for i = 1:size(Tm,2)
   
        %laptime(j,id) = Laptime_FB(240, 'Assen_optimal', 2,1/gear_ratio(j)); 
        laptime(j) = Laptime_FB(Tm,'Assen_optimal',2,1/gear_ratio(j));
       % id = id+1;
    %end 
    %plot(gear_ratio, laptime(j)) 
    hold on 
end

plot(gear_ratio,laptime,'-*')
title(' Laptime Assen for different gear ratios');
xlabel('Gear ratio')
ylabel('Laptime (s)')
% for i=1:size(gear_ratio,2)
%     text(Tm(1),laptime(i,1),['rs/rm\leftarrow',num2str(gear_ratio(i))])
% end 