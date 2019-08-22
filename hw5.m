% Fitting with censored data
cens_fit_data_norng;
X = X';
cvx_begin
    variables c(n) yc(K - M);
    minimize sum((y - X(1:M, :) * c) .^ 2) + sum((yc - X(M+1:end, :) * c) .^ 2);
    subject to
        yc > D
cvx_end
    
cvx_begin
    variables c(n)
    minimize sum((y - X(1:M,:) * c) .^ 2)
cvx_end

% Minimax rational fit to the exponential
k = 201;
i = 1:1:201;
t = -3 + 6 * (i - 1) / (k - 1);
y = exp(t);
l = 0;
u = max(y);
e = 0.001;
while true
    d = (l + u) / 2;
    cvx_begin quiet
        variables a0 a1 a2 b1 b2;
        minimize 0;
        subject to
        1 + b1 * t + b2 * t.^2 >= 0;
        a0 + a1 * t + a2 * t.^2 - y .* (1 + b1 * t + b2 * t.^2) - d * (1 + b1 * t + b2 * t.^2) <= 0;
        a0 + a1 * t + a2 * t.^2 - y .* (1 + b1 * t + b2 * t.^2) + d * (1 + b1 * t + b2 * t.^2) >= 0;
    cvx_end
    if strcmp(cvx_status, 'Solved')
        u = d;
    else
        l = d;
    end
    if u - l <= e && strcmp(cvx_status, 'Solved')
        break
    end
end