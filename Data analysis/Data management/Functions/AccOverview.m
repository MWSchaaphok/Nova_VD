%Acceleration types
GyroAccel.IAx; % Longitudinal acceleration from accelerometer in g
GyroAccel.Ax;   % Long. acceleration from gyroscope in g
gps.speed(1) = gps.speed(2); 
GyroAccel.A_gps = [0; diff(movmean(gps.speed,40)/3.6)./diff(gps.t)]./9.81; % acc based on gps in g

figure; 
plot(GyroAccel.dist, movmean(GyroAccel.IAx,40), GyroAccel.dist, movmean(GyroAccel.Ax,40), gps.dist, GyroAccel.A_gps)
xlabel('distance [m]')
ylabel('acc [g]')
title('Longitudinal accelerations')
legend('Accelerometer','Gyroscope','Gps')

figure; 
plot(gps.dist, movmean(gps.speed,40))

figure; 
[ha, ~] = tight_subplot(5, 1, 0.0,0.08,0.03);
started = find(gps.dist>0);
startpoint = started(1);
ended = find(gps.dist>1000);
endpoint = ended(1);
window = 40; 
gps_speed_filtered = movmean(gps.speed,window);
gps_A_filtered = min(0,[0; diff(movmean(gps.speed,80)/3.6)./diff(gps.t)]);
gps_br_filtered = max(0,[0;diff(movmean(gps.speed,80)/3.6)./diff(gps.t)]);
acc_filtered = min(0,movmean(GyroAccel.Ax,window)); 
br_filtered = max(0,movmean(GyroAccel.Ax,window));
plot(ha(1),gps.dist(startpoint:endpoint), gps_speed_filtered(startpoint:endpoint));
plot(ha(2),gps.dist(startpoint:endpoint), gps_A_filtered(startpoint:endpoint));
plot(ha(4),gps.dist(startpoint:endpoint), gps_br_filtered(startpoint:endpoint));
plot(ha(3),gps.dist(startpoint:endpoint), acc_filtered(startpoint:endpoint));
plot(ha(5),gps.dist(startpoint:endpoint), br_filtered(startpoint:endpoint));

speed_Ax = cumtrapz(GyroAccel.t, GyroAccel.IAx);


