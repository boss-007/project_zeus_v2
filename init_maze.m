function init_maze(id)
global maze
if(id==1)
    maze1();
elseif(id==2)
    maze2();
elseif(id==3)
    maze3();
end
save('maze.mat','maze');
disp('maze saved');
end
function maze1()
global maze
maze=zeros(103);
maze(1,1)=1;
% obs(1,:)=[.3,.5,.5,.7];
maze(30:50,50:70)=1;
maze(50:80,60:68)=1;
maze(40:48,30:60)=1;

%borders
maze(1:end,1)=1;
maze(1:end,end)=1;
maze(1,1:end)=1;
maze(end,1:end)=1;
end

function maze2()
global maze
maze=zeros(103);
maze(1,1)=1;
% obs(1,:)=[.3,.5,.5,.7];
maze(30:40,50:70)=1;
maze(50:end,60:68)=1;
maze(50:60,60:68)=0;
maze(70:90,60:68)=0;
maze(30:40,1:60)=1;
maze(60:70,30:end)=1;
%borders
maze(1:end,1)=1;
maze(1:end,end)=1;
maze(1,1:end)=1;
maze(end,1:end)=1;
end

function maze3()
global maze
maze=zeros(103);
% maze(1,1)=1;
% % obs(1,:)=[.3,.5,.5,.7];
% maze(30:50,50:70)=1;
% maze(50:80,60:68)=1;
% maze(40:48,30:60)=1;

%borders
maze(1:end,1)=1;
maze(1:end,end)=1;
maze(1,1:end)=1;
maze(end,1:end)=1;
end