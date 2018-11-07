function [En, E] = error_norm(y_layer2, data_out)

% size(data,1) - number of examples 

if (size(data_out,1) == size(y_layer2,1) && size(data_out,2) == size(y_layer2,2))
    %E = (data_out - y_layer2).^2;
    E = -(data_out.*log(y_layer2));
    E = sum(sum(E,1));
%     E = E/(2*size(data_out,1));
    E = E/(size(data_out,1));
    En = (data_out - y_layer2).^2;
    En = sum(sum(En,1));
    En = En/(2*size(data_out,1));
else
    disp('data dimension does not match the network output')
end

end