function [y,dy] = softmax_act(u)

% u - matrix[num x K]
% y        - value of function
% dy       - d(softmax_act) / d(fi_array(i))

% summ - matrix[num x 1]
% Example: 
% summ(1) = exp(u(1,1)) + exp(u(1,2)) + ... + exp(u(1,K))
% y(1,2) = exp(u(1,2))/summ(1); y(2,2) = exp(u(2,2))/summ(2)

% summ = sum(exp(u),2);%�������
% k = find(summ==0);
% if length(k) > 0
%     summ(k) = 1;
% end
% y = exp(u)./summ;

y = (softmax(u'))';

dy = y.*(1-y);

end