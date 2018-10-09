function [train_data_in, train_data_out, test_data_in, test_data_out] = data_preparation(simple)

%% mnist
% for train
train = csvread('mnist_train.csv');
num_examples = size(train,1);
num_examples = 60000;
if simple == 1
    train = single(train);
    train_data_out = zeros(num_examples,10,'single')+0.001;
else
    train_data_out = zeros(num_examples,10)+0.001;
end

for i=1:1:num_examples
    train_data_out(i,train(i,1)+1) = 0.991;
end
train_data_in = train(1:num_examples,2:end)./318.75;

% for testing
test = csvread('mnist_test.csv');
if simple == 1
    test = single(test);
    test_data_out = zeros(size(test,1),10,'single')+0.001;
else
    test_data_out = zeros(size(test,1),10)+0.001;
end

for i=1:1:size(test,1)
    test_data_out(i,test(i,1)+1) = 0.991;
end
test_data_in = test(:,2:end)./318.75;

clear train test i;

end