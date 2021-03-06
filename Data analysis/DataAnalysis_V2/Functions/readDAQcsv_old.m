% script reads csv of DAQ data and saves proper variables
% Thies Oelerich & Marianne Schaaphok
function [gps,LV,BMS_V,BMS_C,BMS_T,acc,MC_m,MC_PS,MC_air,MC,Gyro] = readDAQcsv_old(file)

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

%gps.longitude            = floor(gps.longitude) + 10*(gps.longitude-floor(gps.longitude));
%gps.latitude             = floor(gps.latitude) + 10*(gps.latitude-floor(gps.latitude));

% LV voltage
t2                       = A(:, 4);
LV_voltage               = A(:, 5);
idx                      = ~isnan(t2);
LV.t                       = t2(idx);
LV.voltage               = LV_voltage(idx);

% BMS voltage
t3                       = A(:, 6);
BMS_volt_min             = A(:, 7);
BMS_volt_max             = A(:, 8);
BMS_volt_avg             = A(:, 9);
BMS_volt_tot             = A(:, 10);
idx                      = ~isnan(t3);

BMS_V.t                  = t3(idx);
BMS_V.volt_min           = BMS_volt_min(idx);
BMS_V.volt_max           = BMS_volt_max(idx);
BMS_V.volt_avg           = BMS_volt_avg(idx);
BMS_V.volt_tot           = BMS_volt_tot(idx);

% BMS current and charge
t4                       = A(:, 11);
BMS_current              = A(:, 12);
BMS_charge               = A(:, 13);
idx                      = ~isnan(t4);
BMS_C.t                  = t4(idx);
BMS_C.current            = BMS_current(idx);
BMS_C.charge             = BMS_charge(idx);

% Accelerometer
t5                       = A(:, 14);
accel_x                  = A(:, 15);
accel_y                  = A(:, 16);
accel_z                  = A(:, 17);
idx                      = ~isnan(t5);

acc.t                    = t5(idx);
acc.x                    = accel_x(idx);
acc.y                    = accel_y(idx);
acc.z                    = accel_z(idx);

% BMS temperatures
t6                       = A(:, 18);
BMS_temp_min             = A(:, 19);
BMS_temp_max             = A(:, 20);
BMS_temp_avg             = A(:, 21);
idx                      = ~isnan(t6);

BMS_T.t                  = t6(idx);
BMS_T.temp_min           = BMS_temp_min(idx);
BMS_T.temp_max           = BMS_temp_max(idx);
BMS_T.temp_avg           = BMS_temp_avg(idx);

% MC motor temp
t7                       = A(:, 22);
MC_motor_temp            = A(:, 23);
idx                      = ~isnan(t7);

MC_m.t                   = t7(idx);
MC_m.temp                = MC_motor_temp(idx);

% MC power stage temp
t8                       = A(:, 24);
MC_ps_temp               = A(:, 25);
idx                      = ~isnan(t8);

MC_PS.t                  = t8(idx);
MC_PS.temp               = MC_ps_temp(idx);

% MC air temp
t9                       = A(:, 26);
MC_air_temp              = A(:, 27);
idx                      = ~isnan(t9);

MC_air.t                 = t9(idx);
MC_air.temp              = MC_air_temp(idx);

% MC data
t10                      = A(:, 28);
MC_actual_speed          = A(:, 29);
MC_actual_current        = A(:, 30);
MC_output_voltage        = A(:, 31);
MC_motor_power           = A(:, 32);
MC_cmd_current           = A(:, 33);
MC_DC_bus_voltage        = A(:, 34);
idx                      = ~isnan(t10);

MC.t                     = t10(idx);
MC.actual_speed          = MC_actual_speed(idx);
MC.actual_current        = MC_actual_current(idx);
MC.output_voltage        = MC_output_voltage(idx);
MC.motor_power           = MC_motor_power(idx);
MC.cmd_current           = MC_cmd_current(idx);
MC.DC_bus_voltage        = MC_DC_bus_voltage(idx);

% gyroscope data
try 
    t11                      = A(:, 35);
    Gyro_x                   = A(:, 36);
    Gyro_y                   = A(:, 37);
    Gyro_z                   = A(:, 38);
catch 
    t11                      = [];
    Gyro_x                   = [];
    Gyro_y                   = [];
    Gyro_z                   = [];   
end 
idx                      = ~isnan(t11);
Gyro.t                   = t11(idx);
Gyro.x                   = Gyro_x(idx);
Gyro.y                   = Gyro_y(idx);
Gyro.z                   = Gyro_z(idx);

end

