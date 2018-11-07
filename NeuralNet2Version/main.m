clear
clc

simple_type_data = 0; %1 - longer but saves memory
% [train_data_in, train_data_out, test_data_in, test_data_out] = data_preparation(simple_type_data);
load('train_data_in');
load('train_data_out');
load('test_data_in');
load('test_data_out');

layers = 2;
input_dimension = size(train_data_in,2);
neurons = [300,size(train_data_out,2)];
speed = 0.1;
epochs = 100;
relative_error = 0.000000001;
min_error = 0.0001;
gradient = 1e-20;
number_min_gradients = 8;
number_retraining = 10;
a = 1;
moment = 0.2;
L2 = 0.000005;
step_epoch_show_info = 1;
min_value = 0.1;
max_value = 0.9;

if simple_type_data == 1
    layers = single(layers);
    input_dimension = single(input_dimension);
    neurons = single(neurons);
    speed = single(speed);
    epochs = single(epochs);
    relative_error = single(relative_error);
    a = single(a);
    moment = single(moment);
end

% processing of data, create neural net, train net
% [aver, disp, train_data_in, train_data_out, test_data_in, test_data_out] = input_processing(train_data_in, ...
%     train_data_out, test_data_in, test_data_out, min_value, max_value);
net = new_neural_net(layers, input_dimension, neurons, simple_type_data);
[neural_net,epoch,E_start,E_new] = train(train_data_in, train_data_out, net, speed, ...
    epochs, relative_error, a,moment, simple_type_data, step_epoch_show_info, ...
    gradient, number_min_gradients, min_error, test_data_in, test_data_out, ...
    number_retraining, L2);

save('neural_net_200','neural_net');

% testing
error_rate = work(neural_net, test_data_in, test_data_out, a);