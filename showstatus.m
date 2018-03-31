function showstatus()

% 
% [X,Y] = meshgrid(-1:.1:1);
% Z = X.*exp(-X.^2 - Y.^2);
% [DX,DY] = gradient(Z,.2,.2);
% 
% figure
% contour(X,Y,Z)
% hold on
% quiver(X,Y,DX,DY)
% hold off
% 

load('status.mat')
load('maze.mat')
figure(1)
show_map(ep_record,storeaddval,storerew,1);

end