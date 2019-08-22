% Numerical perturbation analysis example
P = [1 -1; 0 2];
q = [-1; 0];
G = [1 2; 1 -4; -1 -1];
u1 = -2;
u2 = -3;
h = [u1; u2; 5];
cvx_begin
    variables x(2);
    dual variable y;
    minimize quad_form(x, P) + dot(x, q);
    subject to
        y: G * x - h <= 0
cvx_end
p0 = cvx_optval;
y0 = y
for s1 = [0 -0.1 0.1]
    for s2 = [0 -0.1 0.1]
        h = [u1 + s1; u2 + s2; 5];
        cvx_begin quiet
            variables x(2);
            dual variable y;
            minimize quad_form(x, P) + dot(x, q);
            subject to
                y: G * x - h <= 0
        cvx_end
        p_exact = cvx_optval;
        p_pred = p0 - dot([s1; s2; 0], y0);
        p_exact - p_pred
    end
end

% A simple example
cvx_begin
    variables x;
    minimize x*x + 1;
    subject to
    (x - 2)*(x - 4) <= 0;
cvx_end

x = 0:0.1:5;
y = x.*x + 1;
plot(x, y, 'g');
hold on;
% x = -5:0.1:5;
y = (x - 2) .* (x - 4);
plot(x, y, 'b');
hold on;
ld = 0.5;
y = x.*x + 1 + ld * (x - 2) .* (x - 4);
plot(x, y, 'r');
y = -9*x.*x./(1 + x) + 1 + 8*x;
plot(x, y)
