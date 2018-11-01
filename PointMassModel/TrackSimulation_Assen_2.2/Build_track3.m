%function [] = Build_track3(filename,trackname,track_length,ds)    
%% Build track function 
%  This function builds array with curvature and cumulative distance from
%  file with lon,lat-coordinates of the track. 
%  Saves curvature and dist to file trackname_track_ds.mat

%  Authors:        Anoosh and Marianne 
%  Date:           23-10-2018
%  Last modified:  25-10-2018


%% Load and adapt (x,y)-coordinates track
    filename= 'Assen_optimal.xlsx';
    trackname = 'Assen_optimal';
    track_length = 4545;
    ds = 1;

    [track] = xlsread(filename);
    lon = deg2rad(track(:,1));
    lat = deg2rad(track(:,2));
 
    [x1,y1] = lonlat2xy(lat,lon);

    % Smoothening data
    sf = 3;                         % Smoothening factor
    x2 = smooth(x1,sf);             % Smoothen x-coordinate
    y2 = smooth(y1,sf);             % Smoothen y-coordinate

%     plot(x2,y2,'-*')
%     title('TT Assen (first smoothening)')
%     set(gca,'FontSize',20)
%     grid on

    % Translation such that the track is around zero 
    % Place start point at (0,0)
    x3 = x2 - x2(1);
    y3 = y2 - y2(1);
    
    % Translate such that every coordinate positive
    %x3 = x2 - min(x2);
    %y3 = y2 - min(y2);
   
%     figure
%     plot(x3,y3,'-*')
%     title('TT Assen (after translation)')
%     set(gca,'FontSize',20)
%     grid on

    % Scale the distances to true distances of track 
    dx = diff(x3);
    dy = diff(y3);
    tl = sum(sqrt(dx.^2 + dy.^2));      % Compute total distance 
    track_length = 4545;                % Track Length of Assen
    scalfac = tl/track_length;          % Compute scale factore
    scalfac = 1; 
    x3 = x3/scalfac;                    % Scale x-coordinate
    y3 = y3/scalfac;                    % Scale y-coordinate

%     figure
%     plot(x3,y3,'-*')
%     title('TT Assen (scaled)')
%     set(gca,'FontSize',20)
%     grid on

%%  Test track length
    dx = diff(x3);                      % Compute difference x-coordinate
    dy = diff(y3);                      % Compute difference y-coordinate
    dis_t = (sqrt(dx.^2 + dy.^2));      % Compute distance between two adjacent points
    tl = sum(dis_t);                    % Compute total track length
    if (tl - track_length>0.1)          % Check whether track length is as desired
        fprintf('Warning 1: Total track_length differs more than 0.1 m')
    end
  

    %% Discretising Track
    z = 0:ds:ceil(tl);                  % Desired distance between adjacent points
    dis_t = [0; dis_t];
    
    % Interpolate x,y-coordintes to get coordinates for new points
    x_new = interp1(cumsum(dis_t)',x3(1:end)',z,'linear');
    y_new = interp1(cumsum(dis_t)',y3(1:end)',z,'linear');

%     figure
%     plot(x_new,y_new,'-*')
%     title('TT Assen (interpolated)')
%     set(gca,'FontSize',20)
%     grid on
    
    %% Second check on track_length
    dx = gradient(x_new);
    dy = gradient(y_new);
    dis = (sqrt(dx.^2 + dy.^2));
    t2 = sum(dis);                          %Track length
    if (t2 - track_length>50)             % Check whether track length is as desired
        fprintf('Warning 2: Total track_length differs more than 50 m \n')
    end
    
%    figure
%    plot(x_new,y_new)
%    axis equal
   
   %% Curvature Generation
   dx = gradient(x_new) ;                   % Compute first derivative x
   dy = gradient(y_new) ;                   % Compute first derivative y 


   dist = sqrt(dx.^2 + dy.^2) ;             % Compute distance between points
   %dist = cumsum(dist);

   ddx = gradient(dx) ;                     % Compute second derivative x
   ddy = gradient(dy) ;                     % Compute second derivative y 

   curv = (dx.*(ddy) - dy.*(ddx))./...      % Compute curvature at each point    
       (((dx.^2 + dy.^2).^(3/2)));
%% Test smoothing
dist(isnan(dist))=0;
curv(isnan(curv))=0;
%curv(abs(curv)<0.002) = 0;
curv = Approx_curv(curv,40);
curv2 = smooth(curv,5);
curv = curv2'; 
  
 %% Check curvature 
 %  The check is done by transforming back to the x,y-coordintes
   
 psi = cumtrapz(cumsum(dist),curv);
 N   = cumtrapz(cumsum(dist), cos(psi));
 E   = cumtrapz(cumsum(dist), -sin(psi));
 
 % Plot track with new x,y-coordinates
 figure
 plot(E,N)
 xlabel('x [m]')
 ylabel('y [m]')
 hold on; 
 plot(x_new, y_new);
 legend('From curvature','From latlon coord')
 axis equal
 
 %% Save track in distance,curvature coordinates 
 
 % width = max(E)-min(E);
 % height = max(N)-min(N);
 save(strcat(trackname,'track_ds_',num2str(ds),'.mat'),'dist','curv','ds');
 
%end
    