function [x_new,y_new] = para_curves(x,y,l)


y2 = gradient(y) ;
x2 = gradient(x) ;

p = [x2' y2'];

new = cell(1,1) ;

% Creating perp vectors

np = zeros(size(p')) ;
norma = zeros(1,size(p,1)) ;

for idx = 1:size(p,1)
np(:,idx) = null(p(idx,:)) ;
norma(idx) = norm(np(:,idx)) ;
end


new{1,1} = [x;y] + l*(np) ;%./norma ;
x_new = new{1,1}(1,:) ;
y_new = new{1,1}(2,:) ;

end