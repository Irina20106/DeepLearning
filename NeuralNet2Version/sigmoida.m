function [y,dy] = sigmoida(a, u)

% y        - value of function
% dy       - d(softmax_act) / d(fi_array(i))

% aa = 1.7159;
% aa = 1.7159;
% b = 2/3;
% y = aa*tanh(b*u);
% dy = (b/aa) * (aa - y) .* (aa + y);

y = 1./(1 + exp(-a*u));
dy = a*y.*(1-y);

end