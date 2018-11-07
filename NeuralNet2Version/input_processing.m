function [aver_now, disp_now, train_data_in, train_data_out, test_data_in, test_data_out] = input_processing(train_data_in, ...
    train_data_out, test_data_in, test_data_out, minv, maxv)

% size(data,1) - number of examples 
% size(data,2) - number of network inputs

% aver = (minv+maxv)/2;

summ1 = (sum(train_data_in,2)/size(train_data_in,2));
summ2 = (sum(train_data_out,2)/size(train_data_out,2));
summ3 = (sum(test_data_in,2)/size(test_data_in,2));
summ4 = (sum(test_data_out,2)/size(test_data_out,2));
train_data_in = train_data_in - summ1;% average = 0
train_data_out = train_data_out - summ2;% average = 0
test_data_in = test_data_in - summ3;% average = 0
test_data_out = test_data_out - summ4;% average = 0

aver_now = sum(train_data_in,2)/size(train_data_in,2);
disp_now = sum((train_data_in-aver_now).^2,2)/size(train_data_in,2);

% min_tr_in = min(train_data_in,[],2);
% min_tr_out = min(train_data_out,[],2);
% min_test_in = min(test_data_in,[],2);
% min_test_out= min(test_data_out,[],2);
% 
% train_data_in = train_data_in - min_tr_in;
% train_data_out = train_data_out - min_tr_out;
% test_data_in = test_data_in - min_test_in;
% test_data_out = test_data_out - min_test_out;
% 
% max_tr_in = (maxv-minv)./max(train_data_in,[],2);
% max_tr_out = (maxv-minv)./max(train_data_out,[],2);
% max_test_in = (maxv-minv)./max(test_data_in,[],2);
% max_test_out= (maxv-minv)./max(test_data_out,[],2);
% 
% train_data_in = train_data_in.*max_tr_in + minv;
% train_data_out = train_data_out.*max_tr_out + minv;
% test_data_in = test_data_in.*max_test_in + minv;
% test_data_out = test_data_out.*max_test_out + minv;

% summ = (sum(data_in,2)/size(data_in,2));
% out_data_in = data_in - summ;% average = 0
% % dispersions = sum(out_data_in.^2,2)/(size(data_in,2)-1);
% % ratio_disps = dispersions / disp;
% % out_data_in = out_data_in./sqrt(ratio_disps);
% out_data_in = out_data_in + aver;
% aver_now = sum(out_data_in,2)/size(out_data_in,2);
% disp_now = sum((out_data_in-aver_now).^2,2)/size(aver_now,2);

end