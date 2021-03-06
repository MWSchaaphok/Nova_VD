function [t,tc] = ComputeLapTime(v, path)
%% Compute total time for one lap [s]
t = (2*path.ds)./(v(1:end-1)+v(2:end));                     % Compute time for each segment by t = ds/v_average
tc = [0,cumsum(t)];                                         % Find total time 
lap_tot = double(tc(end));                                  % Endtime lap
sprintf('Total Lap Time = %d s',lap_tot)
end