function polgrad_multiact_maze()
%x,y ranges in 0,100 normalized to [0,1] with 1 || 2 obstacles
%state space
%x
%y
%action space
%angle
%distance
addpath(genpath('pol_grad'));
nums=2;
numa=2;
netQ=create_network([(nums+numa),20,15,numa],2);

netA=create_network([nums,20,15,numa],1);
maxIter=3800;
first_s=[0.1,0.1];
sample_size=500;
records=[];
episode_record=[];
init_maze(2);
maxvar=.4;
figure(1)
storeaddval=[];
storerew=[];
disp('initializing complete')
for i=1:maxIter
    var=maxvar*(maxIter-i)/maxIter;
    goal_reached=0;
    state=first_s;
    action=forward_pass(netA,state)+ normrnd(0,var,[1,numa]);
    action(action>1)=1;
    action(action<-1)=-1;
    %action=get_action();
    ep_record=invnorm_convert(state);
    stepcounter=0;
    totalrew=[];
    same_counter=0;
    %stepcounter=1;
    while(goal_reached==0)
        %stepcounter=stepcounter+1;
        [next_state,reward,goal_reached]=mdp(state,action);
        next_action=forward_pass(netA,next_state) + normrnd(0,var,[1,numa]);
%         next_state=[.8,.8];
        next_action(next_action>1)=1;
        next_action(next_action<-1)=-1;
        ep_record=[ep_record;invnorm_convert(next_state)];
        totalrew=[totalrew,reward];
        stepcounter=stepcounter+1;
        
%        if(mod(i,1)==0 && mod(stepcounter,5000)==0)
%        show_map(ep_record(end-4499:end,:),storeaddval,0,1);%(end-499:end,:)
%        end
        %next_action=get_action();
        records=[records;state,action,reward,next_state,next_action];
        
        if(next_state(1)==state(1) && next_state(2)==state(2))
            same_counter=same_counter+1;
        end
        state=next_state;
        action=next_action;
        if(size(records,1)>=sample_size)
            [netA,netQ,addval]=...
                train_pol_grad(netQ,netA,records,nums,numa);
            records=[];
            storeaddval=[storeaddval,addval];
        end
        
    end
    storerew=[storerew,stepcounter];

if(mod(i,2)==0)
save('status.mat','ep_record','storeaddval','storerew');
show_map(ep_record,storeaddval,storerew,1);
end

% if(i==1000)
%     disp('seeding Q network stopped')
%     maxvar=.25;
% end
disp(['episode ' num2str(i) ' complete. ' num2str(var) ' '...
    num2str(stepcounter) ' ' num2str(sum(totalrew)) ' ' num2str(min(storerew))])
end
end

function action=get_action()

action(1)=.5;
angle=input('act_2:');
action(2)=(angle/180)-1;
end

function [next_state,reward,goal_reached]=mdp(state,action)
next_state=state;
reward=-1;
goal_reached=0;
%action 1:distance is in [+.1,-.1]
%action 2:angle is [0,360]
ang=(action(2)+1)*180;
rad_angle=(ang)*pi/180;
distance=(action(1)+1.1)*.2;
%reward=-(distance+1);
% distance=(2*rand-1)*.05;
next_state(1)=state(1)+distance.*cos(rad_angle);
next_state(2)=state(2)+distance.*sin(rad_angle);
if(isobstacle(state,next_state)==1)
    next_state=state;
    reward=-2;
    %disp('obstacle!!!')
elseif(next_state(1) <=1 && next_state(1)>=.7 ...
       && next_state(2) <=1 && next_state(2)>=.7)
    goal_reached=1;
    reward=10;
end
% disp(next_state)
%         if(next_state(1)==state(1) && next_state(2)==state(2))
%             same_counter=same_counter+1;
%         end
end

function ret=isobstacle(state,next_state)
global maze
global old_s
loc_s=invnorm_convert(state);
loc_ns=invnorm_convert(next_state);
if(loc_s(1)<loc_ns(1))
    x=loc_s(1):loc_ns(1);
else
    x=loc_s(1):-1:loc_ns(1);
end
m=(loc_ns(2)-loc_s(2))/(loc_ns(1)-loc_s(1)+.001);
y=ceil(m*(x-loc_s(1))+loc_s(2));
y(y>103)=103;
y(y<1)=1;
x=[x,loc_s(1),loc_ns(1)];
y=[y,loc_s(2),loc_ns(2)];
ids=sub2ind(size(maze),x,y);
ret=any(maze(ids)==1);
% ret=0;
old_s=loc_s;
end





function loc=invnorm_convert(state)
%state range 0-100
loc=ceil(state*100)+2;
loc(loc>102)=103;
loc(loc<2)=1;
end

