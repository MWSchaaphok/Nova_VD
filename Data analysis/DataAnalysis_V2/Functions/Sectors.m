function [Sector,S_nr] = Sectors(gps,track_name,distance)
    sect_file = strcat(track_name, '_sectors.csv');
    Sect = readtable(sect_file);
    S_nr = height(Sect);
    %col = ['r','b','k','g','y','m','c'];
    for i=1:height(Sect)
        name                = strcat('S',num2str(i));
        Sector.(name).name  = Sect{i,2};
        Coords              = [nonzeros(Sect{i,3:end}); Sect{i,3:4}'];
        Sector.(name).coord = reshape(Coords,[2,(length(Coords)/2)])';
        Sector.(name).ind   = inpolygon(gps.latitude,gps.longitude,Sector.(name).coord(:,1),Sector.(name).coord(:,2));
        ind                 = find(Sector.(name).ind == 1);
        temp                = ind(diff(ind)>1);
        if ~isempty(temp)
            Sector.(name).dist  = distance(temp(1)) - distance(ind(1));
        else 
            Sector.(name).dist  = distance(ind(end)) - distance(ind(1));
        end
        plot(Sector.(name).coord(:,1),Sector.(name).coord(:,2));
        plot(gps.longitude(Sector.(name).ind),gps.latitude(Sector.(name).ind),'ko','Color',[rand rand rand]) % points inside
    end
    
%      %% Plot sector
%      S1 = [4.3743 52.0055;4.3723 52.007;4.3715 52.007;4.3741  52.0053;4.3743 52.0055];
%      [s1] = inpolygon(gps.longitude,gps.latitude,S1(:,1),S1(:,2));
%      hold on
%       plot(Sectors.S1.coord(:,1),Sectors.S1.coord(:,2));
%       plot(gps.longitude(Sectors.S1.ind),gps.latitude(Sectors.S1.ind),'r+') % points inside
%       plot(gps.longitude(~Sectors.S1.ind),gps.latitude(~Sectors.S1.ind),'bo') % points outside
end