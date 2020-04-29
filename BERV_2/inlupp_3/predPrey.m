% Plots M simulations (predator population in red, prey in blue) over tspan

N_pred = 1000;
N_prey = 1000;

alpha  = 10;
beta   = 0.01;
gamma  = 4;

tspan = [0, 10];

M = 5;

% =======================================================================

p  = [alpha, beta, gamma];
x0 = [N_pred, N_prey];

hold on;
for i = 1:M
    [t, x] = SSA(@propPredPrey, @stochPredPrey, x0, tspan, p);
    plot(t, x(:,1), 'r');
    plot(t, x(:,2), 'b');
end
xlim(tspan);