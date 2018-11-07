function [error_rate] = work(net, data_in, data_out, a)

% size(data,1) - number of examples 

if (size(data_in,2) == size(net.weight1,1))
%     data_in = data_in./12;
%     data_in = input_processing(data_in);
    u_layer1 = data_in * net.weight1;
    y_layer1 = sigmoida(a, u_layer1);
    u_layer2 = y_layer1 * net.weight2;
    y_layer2 = softmax_act(u_layer2);
    
    [v, indexes] = max(y_layer2');
    [u, indexes_d] = max(data_out');
    result = indexes - indexes_d;
    k = find(result);
    error_rate = 100*length(k)/length(result);
else
    disp('data dimension does not match the network input')
end

end