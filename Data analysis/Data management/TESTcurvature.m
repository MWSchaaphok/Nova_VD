%% Curvature test
    load('Assen_middle_1m.mat');
    % Adapt track array 
    curv_track    = [curv(1),curv];
    dist_track    = cumsum([0,dist]);
   
    % Define and save track
    psi_track  = cumtrapz(dist_track,curv_track);
    N_track    = cumtrapz(dist_track, cos(psi_track));
    E_track    = cumtrapz(dist_track, -sin(psi_track));
    
    plot(E_track,N_track,'k--');
    hold on
    [x_left,y_left]     = para_curves(E_track,N_track,-5);
    [x_right,y_right]   = para_curves(E_track,N_track,5);
    plot(x_left,y_left,'k-','HandleVisibility','off')
    plot(x_right,y_right,'k-','HandleVisibility','off')
    axis equal 
    xlabel('E')
    ylabel('N')
    
 %% Compute from E,N again Curv
     
     %% Test computation curvature
    curvature = [0]; % Assume first meter are straight
    for i = 2:length(N_track)-1
        % First check if points are collinear
        xy = [E_track(1,i-1:i+1)' N_track(1,i-1:i+1)'];
        collinear = pointsAreCollinear(xy);
        if collinear 
        curvature = [curvature,0];        
        else 
            a = sqrt((xy(1,1)-xy(2,1))^2 + (xy(1,2)-xy(2,2))^2);
            b = sqrt((xy(2,1)-xy(3,1))^2 + (xy(2,2)-xy(3,2))^2);
            c = sqrt((xy(3,1)-xy(1,1))^2 + (xy(3,2)-xy(1,2))^2);
            k = sqrt((a+(b+c))*(c-(a-b))*(c+(a-b))*(a+(b-c))) / 4 ;    % Heron's formula for triangle's surface
            den = a*b*c;  % Denumerator; make sure there is no division by zero.
            if den == 0.0  % Very unlikely, but just to be sure
                curvature = [curavature, 0];
            else
                curvature = [curvature 4*k / den];
            end
        end 
    end 
    curvature = [real(curvature),real(curvature(end))];
    figure; 
    
    plot(dist_track, abs(curv_track),'r');
    hold on;
    plot(dist_track,curvature,'b')
    
 %% Functions
    function [collinear] = pointsAreCollinear(xy)
        collinear = 0; 
        if rank(xy(2:end,:) - xy(1,:)) == 1
            collinear = 1; 
        end 
    end 