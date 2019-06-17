function [parsed_osm,Sector,S_nr] = PlotMap(track_name,gps)
    osm_filename = strcat(track_name,'_map.osm');
    img_filename = strcat(track_name,'_map.png');
    
    disp('Reading open street map information...');
    [parsed_osm,~]= parse_openstreetmap(osm_filename);
    disp('Finished reading');
    fig = figure; 
    ax = axes('Parent',fig);
    bounds = parsed_osm.bounds;
    show_map(ax,bounds,img_filename);
    plot(ax,gps.longitude, gps.latitude,'r','LineWidth',2);
    title('GPS data')
    hold on; 
    [Sector,S_nr] = Sectors(gps,track_name);
    for i = 1:S_nr
        name = strcat('S',num2str(i));
        hold on; plot(Sector.(name).coord(:,2), Sector.(name).coord(:,1),'k'); hold off
    end
%     %% Plot sector
%     S1 = [4.3743 52.0055;4.3723 52.007;4.3715 52.007;4.3741  52.0053;4.3743 52.0055];
%     [s1] = inpolygon(gps.longitude,gps.latitude,S1(:,1),S1(:,2));
%     hold on
%     plot(S1(:,1),S1(:,2));
%     plot(gps.longitude(s1),gps.latitude(s1),'r+') % points inside
%     plot(gps.longitude(~s1),gps.latitude(~s1),'bo') % points outside

end 


