function [neural_net,Err,En,dW1,dW2] = iteration(data_in, data_out, neural_net, speed, a, correct,dW10,dW20,alf,simple)

% size(data,1) - number of examples 
if (size(data_in,2)==size(neural_net.weight1,1) && size(data_out,2)==size(neural_net.weight2,2) && size(data_in,1)==size(data_out,1))
    [y_layer1, dy_layer1, y_layer2, dy_layer2] = forward_path(neural_net, data_in, a);
    [En, Err] = error_norm(y_layer2, data_out);
    if correct == 1
        [neural_net, dW1, dW2] = back_path(neural_net,y_layer1,dy_layer1,y_layer2,dy_layer2,data_in,data_out,speed,dW10,dW20,alf,simple);
    end
else
    disp('data dimension does not match the network')
end

end