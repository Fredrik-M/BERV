set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear

N = 100;
T = 100;
gamma = 0.6:-0.1:0.3;

s0 = [zeros(1, ceil(N/2)-1), 1, zeros(1, floor(N/2))];
cmap = [0.5, 1, 0.5; 1, 0.2, 0.2];

s = zeros(T+1, length(s0), length(gamma));
for i = 1:length(gamma)
    s(1,:,i) = s0;
    for t = 2:T+1
        s(t,:,i) = step_lin(s(t-1,:,i), gamma(i));
    end
end

for i = 1:length(gamma)
    figure();
    ax = gridPlot(s(:,:,i), cmap, 0.5);
    title(sprintf('$\\gamma = %0.1f$', gamma(i)));
    ylabel('$t$');
    yticklabels('auto');
end