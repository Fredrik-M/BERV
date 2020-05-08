close all
clear

N = 50;
P_i = 0.005;

p = struct(...
    'beta',  0.4, ...
    'gamma', 0.2, ...
    'kappa', 0.02 ...
    );

% ======================================================================

S0 = rand(N) <= P_i;
if ~any(S0)
    S0(ceil(rand() * N)) = 1;
end

cmap = [0.5, 1, 0.5; 1, 0.2, 0.2; 0.8, 0.8, 0.8];
sim(S0, @(S)step(S, p), cmap, 3);