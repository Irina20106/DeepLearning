function [y,dy] = softmax_act(u)

% u - matrix[num x K]
% y        - value of function
% dy       - d(softmax_act) / d(fi_array(i))

% summ - matrix[num x 1]
% Example: 
% summ(1) = exp(u(1,1)) + exp(u(1,2)) + ... + exp(u(1,K))
% y(1,2) = exp(u(1,2))/summ(1); y(2,2) = exp(u(2,2))/summ(2)

% summ = sum(exp(u),2);%столбец
% k = find(summ==0);
% if length(k) > 0
%     summ(k) = 1;
% end
% y = exp(u)./summ;

u_max = max(u,[],2);
u_temp = u - u_max*ones(1,size(u,2));
summa = sum(exp(u_temp),2);%столбец
y = exp(u_temp)./(summa*ones(1,size(u,2)));

% y = (softmax(u'))'; 

dy = y.*(1-y);

end