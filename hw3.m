rng(0, 'v5uniform');
n=100;
m=300;
A=rand(m,n);
b=A*ones(n,1)/2;
c=-rand(n,1);
cvx_begin;
variables x(n);
A*x <= b;
x >= 0;
x <= 1;
minimize dot(c,x);
cvx_end;

t_range=linspace(0,1,100);
obj = zeros(100,1);
maxviol = zeros(100,1);
for i = 1:100
    t = t_range(i);
    x_hat = x >= t;
    obj(i) = dot(c, x_hat);
    maxviol(i) = max(A*x_hat - b);
end
plot(t_range, obj);
plot(t_range, maxviol);
U=min(obj(maxviol<=0))
    
