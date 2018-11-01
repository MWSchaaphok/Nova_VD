function [x,y] = lonlat2xy(lat,lon)
%Coordinates = deg2rad(xlsread('Assen_xy.xlsx')); % Load geographic coordinates and convert to radians

lon_ref = lon(1);           % Set 0 on x-axis
lat_ref = lat(1);           % Set 0 on y-axis

x = (lon - lon_ref)*(40075000.0/(2*pi))*cos(lat_ref);   % Convert to x coordinates
y = (lat - lat_ref)*(40007000.0/(2*pi));                % Convert to y coordinates

% plot(x,y)                 % Plot track
% grid on
% daspect([1 1 1])

% d = diff([x(:) y(:)]);
% total_length = sum(sqrt(sum(d.*d,2)))
% 
% width = max(x)-min(x)
% height = max(y)-min(y)

end