%% simple_portfolio_data
n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;

cvx_begin;
variables x(n);
dot(pbar, x) >= dot(pbar, x_unif);
sum(x) == 1;
% x >= 0;
sum(max(-x,0)) <= 0.5
minimize transpose(x)*S*x;
cvx_end;
sqrt(x'*S*x)