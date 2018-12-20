function [tc,lapt,lapstr] = Laptime(v_dec,curv3,curv4,n_lap,par)

%% Function description
%  This function computes the total and individual laptime from the velocity profile, 
%  number of laps and curvature profile. 
%  Author: Anoosh
%  Date: 2017
%  Last modified: 19-10-2018 (Marianne)

% Compute total time for all laps
t = par.ds./v_dec(2:end);                   
tc = cumsum(t);
lap_tot = double(tc(end));
sprintf('Total Lap Time = %d s',lap_tot)
lapstr = ['Total Lap Time = ' num2str(lap_tot) ' s'];
% Compute time per lap individually
lapt = zeros(1,n_lap);

% Compute lap 1
t_lap = par.ds./v_dec(2:size(curv3,2));
       tc2 = cumsum(t_lap);
       lapt(1) = tc2(end);
       sprintf('Lap Time for lap 1 = %d s',lapt(1))
       lapstr = [lapstr newline 'Lap Time for lap 1 = ' num2str(lapt(1)) ' s'];
%Compute other laps
for idx = 2:n_lap
       t_lap = par.ds./v_dec(...
          2 + ((size(curv4,2)-size(curv3,2))/...
          (n_lap-1))*(idx-1):...
          1 +((size(curv4,2)-size(curv3,2))/...
          (n_lap-1))*(idx));
      size(t_lap)
      tc2 =cumsum(t_lap);
      size(tc2)
      idx
      lapt(idx) = tc2(end);
     sprintf('Lap Time for lap %d = %d s', idx, lapt(idx)) 
     lapstr = [lapstr newline ['Lap Time for lap ' num2str(idx) ' = ' num2str(lapt(idx)) ' s']];
end
end