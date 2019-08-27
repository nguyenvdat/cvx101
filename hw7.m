% Three-way linear classification
% sep3way_data
% cvx_begin
%     variables a1(2) a2(2) a3(2) b1 b2 b3
%     minimize 0
%     subject to
%     X' * a1 - b1 >= max(X' * a2 - b2, X' * a3 - b3) + 1e-9
%     Y' * a2 - b2 >= max(Y' * a1 - b1, Y' * a3 - b3) + 1e-9
%     Z' * a3 - b3 >= max(Z' * a1 - b1, Z' * a2 - b2) + 1e-9
% cvx_end

% Fitting a sphere to data
% sphere_fit_data;
% cvx_begin
%     variables t x(2)
%     minimize sum_square(sum(U'.^2, 2) - 2*U'*x + t)
% cvx_end
% r = sqrt(sum_square(x) - t)

% draw found circle along with the original points
% hold on
% th = 0:pi/50:2*pi;
% xunit = r * cos(th) + x(1);
% yunit = r * sin(th) + x(2);
% plot(xunit, yunit, 'b');
% hold on
% plot(U(1, :), U(2, :), 'r.')
% hold off

% Learning a quadratic pseudo-metric from distance measurements
% quad_metric_data_norng
% cvx_begin
%     variable P(5, 5)
%     minimize 1/100*sum(d'.^2 - 2*d'.*sqrt(sum((X - Y)' * P .* (X - Y)', 2)) + sum((X - Y)' * P .* (X - Y)', 2))
%     subject to
%         P == semidefinite(5)
% cvx_end
% 1/10*sum(d_test'.^2 - 2*d_test'.*sqrt(sum((X_test - Y_test)' * P .* (X_test - Y_test)', 2)) + sum((X_test - Y_test)' * P .* (X_test - Y_test)', 2))

% Maximum volume rectangle inside a polyhedron
max_vol_box_norng
cvx_begin
    variables l(n) u(n)
    A_plus = max(A, 0);
    A_minus = max(-A, 0);
    maximize geo_mean(u - l)
    % maximize 1/n*sum(log(u-l))
    subject to
        A_plus * u - A_minus * l <= b
        u >= l
cvx_end

exp(1/n*sum(log(u-l)))