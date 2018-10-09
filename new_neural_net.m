function [net_struct] = new_neural_net(layers, input_dimension, neurons, simple)

% layers          - number of network layers
% input_dimension - dimension of input vector
% neurons         - number of neurons in the layer 

weight1 = 0;
weight2 = 0;
d = 0;
if (layers == 2)
    if simple == 1
        weight1 = single((rand(input_dimension, neurons(1))+d)/sqrt(input_dimension));
        weight2 = single((rand(neurons(1), neurons(2))+d)/sqrt(neurons(1)));
    else
        weight1 = (rand(input_dimension, neurons(1))+d)/sqrt(input_dimension);
        weight2 = (rand(neurons(1), neurons(2))+d)/sqrt(neurons(1));
%           load('w1')
%           load('w2')
%           weight1 = w1;
%           weight2 = w2;
    end
%     weight1 = [0.1,0.2,0.4];
%     weight2 = [0.25,0.15;0.05,0.7;0.5,0.3];
end

net_struct = struct('weight1',weight1,'weight2',weight2);

end