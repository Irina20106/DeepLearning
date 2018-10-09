function [neural_net,j,E_start,E_new] = train(data_in, data_out, neural_net, speed, epochs, ...
    relative_error, a, alf, simple,step_info, gradient, number_min_gradients, min_error)

% size(data,1) - number of examples 

mode = 2; % 1 - packet, 2 - serial

j = -1;
E_start = -1;
E_new = -1;
E_old = 0;
if (size(data_in,2)==size(neural_net.weight1,1) && size(data_out,2)==size(neural_net.weight2,2) && size(data_in,1)==size(data_out,1))
    
    if (mode == 1)
        [neural_net,E_start] = iteration(data_in, data_out, neural_net, speed, a, 0);
        if simple == 1
            dW1 = zeros(size(neural_net.weight1,1),size(neural_net.weight1,2),'single');
            dW2 = zeros(size(neural_net.weight2,1),size(neural_net.weight2,2),'single');
        else
            dW1 = zeros(size(neural_net.weight1,1),size(neural_net.weight1,2));
            dW2 = zeros(size(neural_net.weight2,1),size(neural_net.weight2,2));
        end
        for j=1:1:epochs
            [neural_net,E_new] = iteration(data_in, data_out, neural_net, speed, a, 1,dW1,dW2,0,simple);
            if abs(E_new-E_old)/E_new < relative_error
                break;
            end
            E_old = E_new;
        end
    elseif (mode == 2)
        num_min_grad = 0;
        for j=1:1:epochs
            E_new = 0;
            E_new2 = 0;
            if simple == 1
                dW1 = zeros(size(neural_net.weight1,1),size(neural_net.weight1,2),'single');
                dW2 = zeros(size(neural_net.weight2,1),size(neural_net.weight2,2),'single');
            else
                dW1 = zeros(size(neural_net.weight1,1),size(neural_net.weight1,2));
                dW2 = zeros(size(neural_net.weight2,1),size(neural_net.weight2,2));
            end
            for m=1:1:size(data_in,1)
                [neural_net,Err,En,dW1,dW2] = iteration(data_in(m,:),data_out(m,:),neural_net,speed,a,1,dW1,dW2,alf,simple);
                E_new = E_new + En;
                E_new2 = E_new2 + Err;
            end
            E_new = (E_new / size(data_in,1));
            E_new2 = (E_new2 / size(data_in,1));
            norma_dW1 = norm(dW1);
            norma_dW2 = norm(dW2);
            if mod(j,step_info) == 0
                disp('---------------------------------------');
                disp('gradient 1:');
                disp(norma_dW1);
                disp('gradient 2:');
                disp(norma_dW2);
                disp('Euclidean norm error:');
                disp(E_new);
                disp('Cross entropy:');
                disp(E_new2);
                disp('Epoch:');
                disp(j);
            end
            if norma_dW1 < gradient || norma_dW2 < gradient
                num_min_grad = num_min_grad + 1;
            else
                num_min_grad = 0;
            end
            if abs(E_new-E_old)/E_new < relative_error || E_new < min_error || num_min_grad > number_min_gradients
                if abs(E_new-E_old)/E_new < relative_error
                    disp('min_delta_error');
                elseif E_new < 0.001
                    disp('min_error');
                elseif num_min_grad > number_min_gradients
                    disp('min_gradient');
                end
                break;
            end
            E_old = E_new;
        end
    end
else
    disp('data dimension does not match the network')
end

end