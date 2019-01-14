function [x_new,y_new] = para_curves(x,y,l)
% load('East-Northco-ord.mat')
% x = E;
% y = N;
% l=5;
% thresh_d = 5 ;
y2 = gradient(y) ;
x2 = gradient(x) ;

p = [x2' y2'];

new = cell(1,1) ;

% Creating perp vectors

np = zeros(size(p')) ;
norma = zeros(1,size(p,1)) ;
%%
dist = zeros(size(p,1)-1,1) ;
for idx = 1:size(p,1)
    norm_vec = null(p(idx,:)) ;
    if size(norm_vec,2) == 2
        norm_vec = norm_vec(:,1);
    end
np(:,idx) = norm_vec ;
norma(idx) = norm(np(:,idx)) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Checks for the distance between the subsequent points. Is the distance ...
%     is found to be abnormal changes the sgin of 'l'

new{1,1}(:,idx) = [x(idx);y(idx)] + l*np(:,idx) ;


if idx ~=1
    dist(idx) = sqrt((new{1,1}(1,idx) - new{1,1}(1,idx-1))^2 + ...
        (new{1,1}(2,idx) - new{1,1}(2,idx-1))^2) ;
%     thresh_d = 
    if dist(idx) > abs(l) % abs(l) acts as a threshold
        l = -l ;
        new{1,1}(:,idx) = [x(idx);y(idx)] + l*np(:,idx) ;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
end

% % new{1,1} = [x;y] + l*(np) ;%./norma ;
% % x_new = new{1,1}(1,:) ;
% % y_new = new{1,1}(2,:) ;
% % distw = sqrt((diff(x_new)).^2+(diff(y_new)).^2) ;

% thresh_d = mean(distw);
% new = cell(1,1) ;

% for ids = 1:size(p,1)
%     new{1,1}(:,ids) = [x(ids);y(ids)] + l*np(:,ids) ;
%     if ids~=1
%         dist(ids) = sqrt((new{1,1}(1,ids) - new{1,1}(1,ids-1))^2 + ...
%             (new{1,1}(2,ids) - new{1,1}(2,ids-1))^2) ;
%         if dist(ids) > thresh_d
%             l = -l ;
%             new{1,1}(:,ids) = [x(ids);y(ids)] + l*np(:,ids) ;
%         end
%     end
% end

x_new = new{1,1}(1,:) ;
y_new = new{1,1}(2,:) ;

end
