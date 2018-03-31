function show_map(ep_record,addvals,storerew,showothers)
global maze
% figure(1)
% maze(2,2)=1;
% maze(100,100)=1;
% maze(101,100)=1;
% maze(102,100)=1;
% ep_record=[ep_record;100,20;20,100];
subplot(1,3,1)
temp=flipud((1-maze)');
imshow(temp)
% sizeQ=size(maze,1);
%     x1 = 1:sizeQ; 
%     x2 = 1:sizeQ;
%     [X1,X2] = meshgrid(x1,x2);
%     gscatter(X1(:),X2(:),reshape(maze,1,sizeQ*sizeQ))
if(showothers~=-2)
    hold on;
    plot(ep_record(:,1),104-ep_record(:,2))
    hold off
    drawnow;
end
    if(showothers~=-1)
        subplot(1,3,2)
        if(size(addvals,1)~=0)
        plot(ema(addvals,100))
        drawnow;
        end

        subplot(1,3,3)
        if(size(storerew,1)~=0)
        plot(ema(storerew,100))
        drawnow;
        end
    end
end