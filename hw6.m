% Maximum likelihood estimation of an increasing nonnegative signal
ml_estim_incr_signal_data_norng;
cvx_begin
    variables x(N)
    cv = conv(h, x)
    minimize sum_square(cv(1:N) - y)
    subject to
    x >= 0
    x(1:end-1) <= x(2:end)
cvx_end

cvx_begin
    variables xf(N)
    cv = conv(h, xf)
    minimize sum_square(cv(1:N) - y)
cvx_end

plot(1:1:100, xtrue, 'b')
hold on
plot(1:1:100, x, 'r')
hold on
plot(1:1:100, xf, '.')

% Worst-case probability of loss
mu1 = 8;
mu2 = 20;
sigma1 = 6;
sigma2 = 17.5;
ro = -0.25;
val1 = linspace(-30, 70); % discrete value of distribution 1 and 2
val2 = linspace(-30, 70);
idx = val1' + val2 <= 0; % index where R1 + R2 <= 0
exp_p1 = exp(-(val1' - mu1).^2/(2*sigma1*sigma1));
exp_p2 = exp(-(val2' - mu2).^2/(2*sigma2*sigma2));
p1 = exp_p1 / sum(exp_p1);
p2 = exp_p2 / sum(exp_p2);
cvx_begin
    variables P(100, 100)
    maximize sum(P(idx))
    subject to
        P >= 0
        sum(P, 1) == p2'
        sum(P, 2) == p1
        sum(sum((val1' - mu1).*(val2 - mu2) .* P)) == ro * sigma1 * sigma2
cvx_end

[X, Y] = meshgrid(val1, val2);
contour(X, Y, P);