function Network=create_network(L)
%%%%% INITIALIZATION PHASE %%%%%
nLayers = length(L); % we'll use the number of layers often  

% randomize the weight matrices (uniform random values in [-1 1], there
% is a weight matrix between each layer of nodes. Each layer (exclusive the 
% output layer) has a bias node whose activation is always 1, that is, the 
% node function is C(net) = 1. Furthermore, there is a link from each node
% in layer i to the bias node in layer j (the last row of each matrix)
% because it is less computationally expensive then the alternative. The 
% weights of all links to bias nodes are irrelevant and are defined as 0
w = cell(nLayers-1,1); % a weight matrix between each layer
for i=1:nLayers-2        
    w{i} = [1 - 2.*rand(L(i+1),L(i)+1) ; zeros(1,L(i)+1)];
end
w{end} = 1 - 2.*rand(L(end),L(end-1)+1);

Network.structure = L;
Network.weights = w;
Network.epochs = -1;
Network.mse = -1;
end