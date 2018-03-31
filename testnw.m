function testnw()
addpath(genpath('../../forkable_utils'));
[train_x,train_t,~,~]=gentempdata();
X=train_x';
D=train_t'*100;
numnodes=[size(X,2),10,5,size(D,2)];
rew=100.*rand(size(D));
net=create_network(numnodes);
storemse=[];
% fnet=feedforwardnet([10,5]);
% fnet=train(fnet,X',D');
% fout=fnet(X');
for i=1:100000
    out=forward_pass(net,X);
%     D=out+(.1.*(rew-out));
    err=D-out;
    [~,net]=backward_pass(net,err,X);
    storemse=[storemse,net.mse];

    if(mod(i,1500)==0)
        figure(1)
        plot(storemse)
        drawnow
    end

end
end