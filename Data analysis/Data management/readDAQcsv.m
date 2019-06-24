% script reads csv of DAQ data and saves proper variables
% Thies Oelerich & Marianne Schaaphok
clear; close all; clc;

file = '20190621_1836.012.csv';
% Read all contents of csv file in one big matrix
%A = csvread(file,1,0);
try 
    A = dlmread(file,';',1,0);
catch 
    A = dlmread(file,',',1,0);
end 
%% get data from that matrix

% GPS
t1                       = A(:, 1);
latitude                 = A(:, 2);
longitude                = A(:, 3);
idx                      = ~isnan(t1);

gps.t                    = t1(idx);
gps.latitude             = latitude(idx);
gps.longitude            = longitude(idx);

% Accelerometer
t2                       = A(:, 4);
accel_x                  = A(:, 5);
accel_y                  = A(:, 6);
accel_z                  = A(:, 7);
idx                      = ~isnan(t2);

acc.t                    = t2(idx);
acc.x                    = accel_x(idx);
acc.y                    = accel_y(idx);
acc.z                    = accel_z(idx);


% gyroscope data
t3                       = A(:, 8);
Gyro_x                   = A(:, 9);
Gyro_y                   = A(:, 10);
Gyro_z                   = A(:, 11);

idx                      = ~isnan(t3);
Gyro.t                   = t3(idx);
Gyro.x                   = Gyro_x(idx);
Gyro.y                   = Gyro_y(idx);
Gyro.z                   = Gyro_z(idx);

% BMS voltage
t4                       = A(:, 12);
BMS_volt_min             = A(:, 13);
BMS_volt_max             = A(:, 14);
BMS_volt_avg             = A(:, 15);
BMS_volt_tot             = A(:, 16);
idx                      = ~isnan(t4);

BMS_V.t                  = t4(idx);
BMS_V.volt_min           = BMS_volt_min(idx);
BMS_V.volt_max           = BMS_volt_max(idx);
BMS_V.volt_avg           = BMS_volt_avg(idx);
BMS_V.volt_tot           = BMS_volt_tot(idx);

% BMS current and charge
t5                       = A(:, 17);
BMS_current              = A(:, 18);
BMS_charge               = A(:, 19);
idx                      = ~isnan(t5);
BMS_C.t                  = t5(idx);
BMS_C.current            = BMS_current(idx);
BMS_C.charge             = BMS_charge(idx);


% BMS temperatures
t6                       = A(:, 20);
BMS_temp_min             = A(:, 21);
BMS_temp_max             = A(:, 22);
BMS_temp_avg             = A(:, 23);
idx                      = ~isnan(t6);

BMS_T.t                  = t6(idx);
BMS_T.temp_min           = BMS_temp_min(idx);
BMS_T.temp_max           = BMS_temp_max(idx);
BMS_T.temp_avg           = BMS_temp_avg(idx);

% MC motor temp
t7                       = A(:, 24);
MC_motor_temp            = A(:, 25);
idx                      = ~isnan(t7);

MC_m.t                   = t7(idx);
MC_m.temp                = MC_motor_temp(idx);

% MC power stage temp
t8                       = A(:, 26);
MC_ps_temp1              = A(:, 27);
MC_ps_temp2              = A(:, 28);
MC_ps_temp3              = A(:, 29);
idx                      = ~isnan(t8);

MC_PS.t                  = t8(idx);
MC_PS.temp1              = MC_ps_temp1(idx);
MC_PS.temp2              = MC_ps_temp2(idx);
MC_PS.temp3              = MC_ps_temp3(idx);

% MC speed
t9                       = A(:, 30);
MC_speed                 = A(:, 31);
idx                      = ~isnan(t9);

MC_Speed.t               = t9(idx);
MC_Speed.speed           = MC_speed(idx);

% MC current
t10                      = A(:, 32);
MC_current_pA            = A(:, 33);
MC_current_pB            = A(:, 34);
MC_current_pC            = A(:, 35);
MC_current_DC            = A(:, 36);
idx                      = ~isnan(t10);

MC_Current.t             = t10(idx);
MC_Current.pA            = MC_current_pA(idx);
MC_Current.pB            = MC_current_pB(idx);
MC_Current.pC            = MC_current_pC(idx);
MC_Current.DC            = MC_current_DC(idx);

% MC voltage
t11                      = A(:, 37);
MC_voltage_DC            = A(:, 38);
MC_voltage_output        = A(:, 39);
MC_voltage_VAB           = A(:, 40);
MC_voltage_VBC           = A(:, 41);
idx                      = ~isnan(t11);

MC_Voltage.t             = t11(idx);
MC_Voltage.DC            = MC_voltage_DC(idx);
MC_Voltage.output        = MC_voltage_output(idx);
MC_Voltage.VAB           = MC_voltage_VAB(idx);
MC_Voltage.VBC           = MC_voltage_VBC(idx);

% MC flux
t12                      = A(:, 42);
MC_flux_com              = A(:, 43);
MC_flux_fb               = A(:, 44);
MC_Id                    = A(:, 45);
MC_Iq                    = A(:, 46);
idx                      = ~isnan(t12);

MC_Flux.t                = t12(idx);
MC_Flux.com              = MC_flux_com(idx);
MC_Flux.fb               = MC_flux_fb(idx);
MC_Flux.Id               = MC_Id(idx);
MC_Flux.Iq               = MC_Iq(idx);

% MC faults
t13                      = A(:, 47);
MC_fault_post_lo         = A(:, 48);
MC_fault_post_hi         = A(:, 49);
MC_fault_run_lo          = A(:, 50);
MC_fault_run_hi          = A(:, 51);
idx                      = ~isnan(t13);

MC_Fault.t               = t13(idx);
MC_Fault.post_lo         = MC_fault_post_lo(idx);
MC_Fault.post_hi         = MC_fault_post_hi(idx);
MC_Fault.run_lo          = MC_fault_run_lo(idx);
MC_Fault.run_hi          = MC_fault_run_hi(idx);

% MC torque
t14                      = A(:, 52);
MC_torque_com            = A(:, 53);
MC_torque_fb             = A(:, 54);
idx                      = ~isnan(t14);

MC_Torque.t              = t14(idx);
MC_Torque.com            = MC_torque_com(idx);
MC_Torque.fb             = MC_torque_fb(idx);

%% plot stuff

figure;
plot(gps.latitude, gps.longitude);
title('GPS');

figure; hold on;
plot(acc.t, acc.x)
plot(acc.t, acc.y)
plot(acc.t, acc.z)
title('Accelerometer')
legend('x', 'y', 'z')

figure; hold on;
plot(Gyro.t, Gyro.x)
plot(Gyro.t, Gyro.y)
plot(Gyro.t, Gyro.z)
title('Gyroscope')
legend('x', 'y', 'z')

figure; hold on;
plot(BMS_V.t, BMS_V.volt_min)
plot(BMS_V.t, BMS_V.volt_max)
plot(BMS_V.t, BMS_V.volt_avg)
plot(BMS_V.t, BMS_V.volt_tot)
title('BMS voltages')
legend('min', 'max', 'avg', 'tot')

figure; hold on;
plot(BMS_T.t, BMS_T.temp_min)
plot(BMS_T.t, BMS_T.temp_max)
plot(BMS_T.t, BMS_T.temp_avg)
title('BMS temperatures')
legend('min', 'max', 'avg')

figure; hold on;
plot(MC_m.t, MC_m.temp);
title('Motor temperature')

figure; hold on;
plot(MC_PS.t, MC_PS.temp1);
plot(MC_PS.t, MC_PS.temp2);
plot(MC_PS.t, MC_PS.temp3);
title('MC power stage temperature')
legend('1', '2', '3')

figure; hold on;
plot(MC_Speed.t, MC_Speed.speed)
title('Speed')

figure; hold on;
plot(MC_Current.t, MC_Current.pA);
plot(MC_Current.t, MC_Current.pB);
plot(MC_Current.t, MC_Current.pC);
plot(MC_Current.t, MC_Current.DC);
title('MC currents')
legend('pA', 'pB', 'pC', 'DC')

figure; hold on;
plot(MC_Voltage.t, MC_Voltage.DC);
plot(MC_Voltage.t, MC_Voltage.output);
plot(MC_Voltage.t, MC_Voltage.VAB);
plot(MC_Voltage.t, MC_Voltage.VBC);
title('MC voltages')
legend('DC', 'output', 'VAB', 'VBC')

figure; hold on;
plot(MC_Flux.t, MC_Flux.com);
plot(MC_Flux.t, MC_Flux.fb);
plot(MC_Flux.t, MC_Flux.Id);
plot(MC_Flux.t, MC_Flux.Iq);
title('MC Flux')
legend('com', 'fb', 'Id', 'Iq')

figure; hold on;
plot(MC_Fault.t, MC_Fault.post_lo);
plot(MC_Fault.t, MC_Fault.post_hi);
plot(MC_Fault.t, MC_Fault.run_lo);
plot(MC_Fault.t, MC_Fault.run_hi);
title('MC faults')

figure; hold on;
plot(MC_Torque.t, MC_Torque.com);
plot(MC_Torque.t, MC_Torque.fb);
title('Torque')
legend('com', 'fb')
