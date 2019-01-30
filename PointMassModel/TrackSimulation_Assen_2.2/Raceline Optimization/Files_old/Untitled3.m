function [t,tc] = ComputeLapTime(v, path)

% Compute total time s
ds = diff(path.dist); 
t = ds./v(2:end);                   
tc = cumsum(t);
tc = [0 tc];
lap_tot = double(tc(end));
sprintf('Total Lap Time = %d s',lap_tot)

end