function [neural_net,j,E_start,euclideanErr] = train(data_in, data_out, neural_net, speed, epochs, ...
    relative_error, a, alf, simple,step_info, gradient, number_min_gradients, min_error, ...
    test_data_in, test_data_out, number_retraining, L2)

% size(data,1) - number of examples 

mode = 2; % 1 - packet, 2 - serial

j = -1;
E_start = -1;
euclideanErr = -1;
E_old = 0;
error_rate_temp_old = 1000000000; 
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
            [neural_net,euclideanErr, En] = iteration(data_in, data_out, neural_net, speed, a, 1,dW1,dW2,0,simple, L2);
            if abs(En-E_old)/En < relative_error
                break;
            end
            E_old = En;
        end
    elseif (mode == 2)
        num_min_grad = 0;
        num_err_test = 0;
        for j=1:1:epochs
            euclideanErr = 0;
            crossErr = 0;
            if simple == 1
                dW1 = zeros(size(neural_net.weight1,1),size(neural_net.weight1,2),'single');
                dW2 = zeros(size(neural_net.weight2,1),size(neural_net.weight2,2),'single');
            else
                dW1 = zeros(size(neural_net.weight1,1),size(neural_net.weight1,2));
                dW2 = zeros(size(neural_net.weight2,1),size(neural_net.weight2,2));
            end
            if num_err_test == 0
                net = neural_net;
            end
            arr = rand_example(size(data_in,1));
            for m=1:1:size(data_in,1)
                [neural_net,Err,En,dW1,dW2] = iteration(data_in(arr(m),:),data_out(arr(m),:),neural_net,speed,a,1,dW1,dW2,alf,simple,L2);
                euclideanErr = euclideanErr + En;
                crossErr = crossErr + Err;
            end
            euclideanErr = (euclideanErr / size(data_in,1));
            crossErr = (crossErr / size(data_in,1));
            norma_dW1 = norm(dW1);
            norma_dW2 = norm(dW2);
            
            error_rate_temp = work(neural_net, test_data_in, test_data_out, a);
            if error_rate_temp_old < error_rate_temp
                num_err_test = num_err_test + 1;
            else
                num_err_test = 0;
                error_rate_temp_old = error_rate_temp;
            end
            if mod(j,step_info) == 0
                disp('---------------------------------------');
                disp('gradient:');
                disp(sqrt(norma_dW1*norma_dW2));
                disp('Euclidean norm error:');
                disp(euclideanErr);
                disp('Cross entropy:');
                disp(crossErr);
                disp('Error of test:');
                disp(error_rate_temp);
                disp('Epoch:');
                disp(j);
            end
            if norma_dW1 < gradient || norma_dW2 < gradient
                num_min_grad = num_min_grad + 1;
            else
                num_min_grad = 0;
            end
            if abs(euclideanErr-E_old)/euclideanErr < relative_error || euclideanErr < min_error ...
                    || num_min_grad > number_min_gradients || num_err_test > number_retraining
                if abs(euclideanErr-E_old)/euclideanErr < relative_error
                    disp('min_delta_error');
                elseif euclideanErr < min_error
                    disp('min_error');
                elseif num_min_grad > number_min_gradients
                    disp('min_gradient');
                elseif num_err_test > number_retraining
                    neural_net = net;
                    disp('test error');
                end
                break;
            end
            E_old = euclideanErr;
        end
    end
else
    disp('data dimension does not match the network')
end

end