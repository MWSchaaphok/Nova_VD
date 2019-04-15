% script reads csv of DAQ data and saves proper variables
% Thies Oelerich

%% read csv file
% specify file
file = 'TestCSVfile.csv';

% read all contents in one big matrix
A = csvread(file, 1);

%% get data from that matrix

% GPS
t1                       = A(:, 1);
latitude                 = A(:, 2);
longitude                = A(:, 3);
idx                      = ~isnan(t1);
t1                       = t1(idx);
latitude                 = latitude(idx);
longitude                = longitude(idx);

% LV voltage
t2                       = A(:, 4);
LV_voltage               = A(:, 5);
idx                      = ~isnan(t2);
t2                       = t2(idx);
LV_voltage               = LV_voltage(idx);

% BMS voltage
t3                       = A(:, 6);
BMS_volt_min             = A(:, 7);
BMS_volt_max             = A(:, 8);
BMS_volt_avg             = A(:, 9);
BMS_volt_tot             = A(:, 10);
idx                      = ~isnan(t3);
t3                       = t3(idx);
BMS_volt_min             = BMS_volt_min(idx);
BMS_volt_max             = BMS_volt_max(idx);
BMS_volt_avg             = BMS_volt_avg(idx);
BMS_volt_tot             = BMS_volt_tot(idx);

% BMS current and charge
t4                       = A(:, 11);
BMS_current              = A(:, 12);
BMS_charge               = A(:, 13);
idx                      = ~isnan(t4);
t4                       = t4(idx);
BMS_current              = BMS_current(idx);
BMS_charge               = BMS_charge(idx);

% Accelerometer
t5                       = A(:, 14);
accel_x                  = A(:, 15);
accel_y                  = A(:, 16);
accel_z                  = A(:, 17);
idx                      = ~isnan(t5);
t5                       = t5(idx);
accel_x                  = accel_x(idx);
accel_y                  = accel_y(idx);
accel_z                  = accel_z(idx);

% BMS temperatures
t6                       = A(:, 18);
BMS_temp_min             = A(:, 19);
BMS_temp_max             = A(:, 20);
BMS_temp_avg             = A(:, 21);
idx                      = ~isnan(t6);
t6                       = t6(idx);
BMS_temp_min             = BMS_temp_min(idx);
BMS_temp_max             = BMS_temp_max(idx);
BMS_temp_avg             = BMS_temp_avg(idx);

% MC motor temp
t7                       = A(:, 22);
MC_motor_temp            = A(:, 23);
idx                      = ~isnan(t7);
t7                       = t7(idx);
MC_motor_temp            = MC_motor_temp(idx);

% MC power stage temp
t8                       = A(:, 24);
MC_ps_temp               = A(:, 25);
idx                      = ~isnan(t8);
t8                       = t8(idx);
MC_ps_temp               = MC_ps_temp(idx);

% MC air temp
t9                       = A(:, 26);
MC_air_temp              = A(:, 27);
idx                      = ~isnan(t9);
t9                       = t9(idx);
MC_air_temp              = MC_air_temp(idx);

% MC data
t10                      = A(:, 28);
MC_actual_speed          = A(:, 29);
MC_actual_current        = A(:, 30);
MC_output_voltage        = A(:, 31);
MC_motor_power           = A(:, 32);
MC_cmd_current           = A(:, 33);
MC_DC_bus_voltage        = A(:, 34);
idx                      = ~isnan(t10);
t10                      = t10(idx);
MC_actual_speed          = MC_actual_speed(idx);
MC_actual_current        = MC_actual_current(idx);
MC_output_voltage        = MC_output_voltage(idx);
MC_motor_power           = MC_motor_power(idx);
MC_cmd_current           = MC_cmd_current(idx);
MC_DC_bus_voltage        = MC_DC_bus_voltage(idx);
