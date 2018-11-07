function [y_layer1, dy_layer1, y_layer2, dy_layer2] = forward_path(net, data_in, a)

% size(data,1) - number of examples 

if (size(data_in,2) == size(net.weight1,1))
    u_layer1 = data_in * net.weight1;
    [y_layer1, dy_layer1] = sigmoida(a, u_layer1);
    u_layer2 = y_layer1 * net.weight2;
    [y_layer2, dy_layer2] = softmax_act(u_layer2);
else
    disp('data dimension does not match the network input')
end

end