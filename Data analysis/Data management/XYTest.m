    [Xs, Ys] = Spherical2AzimuthalEquidistant(gps.latitude,gps.longitude, gps.latitude(1), gps.longitude(1), ...
                    0, 0, 6364565);
    Xs = Xs - Xs(1);
    Ys = Ys - Ys(1); 
    plot(Xs,Ys);   
    

        %% Distance still too short.
    dist = sqrt((Xs(2:end)-Xs(1:end-1)).^2 + (Ys(2:end)- Ys(1:end-1)).^2);
    
    % Convert to radians
    lat = gps.latitude/180*pi;
    lon = gps.longitude/180*pi; 
    
    % Formula for 
    dist2(1) = 0;
    for i = 1 : length(gps.longitude)-1
        dist2(i+1) =  2*asin(sqrt((sin((lat(i)-lat(i+1))/2))^2 + ... 
                 cos(lat(i))*cos(lat(i+1))*(sin((lon(i)-lon(i+1))/2))^2));
    end 
    
    dist2 = dist2*60*180/pi*1.852*1000;         % Convert to meters 
