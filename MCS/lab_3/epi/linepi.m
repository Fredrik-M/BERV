
N = 100;
gamma = 0.6;

s = [zeros(1, ceil(N/2)-1), 1, zeros(1, floor(N/2))];
cmap = [0.5, 1, 0.5; 1, 0.2, 0.2];

sim(s, @(s)step_lin(s, gamma), cmap, 0.5);