function ddt = sirODE(t,y)
N = 1000;
mu = 2e-3 / 365;
beta = 0.3;
v = 1 / 7;

ddt = zeros(2,1);
ddt(1) = mu * (N - y(1)) - beta * y(2) / N * y(1);
ddt(2) = beta * y(2) / N * y(1) - v * y(2) - mu * y(2);
ddt(3) = v * y(2) - mu * y(3);
end