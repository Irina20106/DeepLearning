function [net,dW1,dW2] = back_path(net, y_layer1, dy_layer1, y_layer2, dy_layer2, data_in, data_out,speed,dW10,dW20,alf,simple)

% size(data,1) - number of examples 

if (size(data_out,1) == size(y_layer2,1) && size(data_out,2) == size(y_layer2,2))
    Err = data_out - y_layer2;
%     dy_layer2 = sum(dy_layer2,1)/size(dy_layer2,1);
%     Err = sum(Err,1)/size(Err,1);
    sigma2 = dy_layer2.*Err;
%     y_layer1 = sum(y_layer1,1)/size(y_layer1,1);
    dW2 = (y_layer1'*sigma2);
    dW2 = speed*dW2+alf*dW20;
%     dW2 = speed*(y_layer1'*sigma2);
%     dy_layer1 = sum(dy_layer1,1)/size(dy_layer1,1);
    summa = sigma2*net.weight2';
%     sigma1 = dy_layer1.*(sigma2*net.weight2');
    sigma1 = dy_layer1.*summa;
%     data = sum(data_in,1)/size(data_in,1);
    data = data_in;
    dW1 = data'*sigma1;
    dW1 = speed*dW1+alf*dW10;
%     dW1 = speed*(data'*sigma1);
    net.weight1 = net.weight1 + dW1;
    net.weight2 = net.weight2 + dW2;
else
    disp('data dimension does not match the network output')
end

end