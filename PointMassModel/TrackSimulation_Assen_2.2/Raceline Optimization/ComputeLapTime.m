function [t,tc] = ComputeLapTime(v, path)

% Compute total time [s]
ds = path.dist - [0,path.dist(1:end-1)]; 
t = ds./v;  
if t(1)- t(2) < 10^-2
    fprintf('Warning t1 = t2 in ComputeLapTime')
end 
tc = cumsum(t);
%tc = [0 tc];
lap_tot = double(tc(end));
sprintf('Total Lap Time = %d s',lap_tot)

end