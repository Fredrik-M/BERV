set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear

N = 50;
P_i = 0.005;
T = 1000;

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

S = zeros(N, N, T + 1);
S(:,:,1) = S0;
cmap = [0.5, 1, 0.5; 1, 0.2, 0.2; 0.8, 0.8, 0.8];

for t = 2:T+1
    S(:,:,t) = step(S(:,:,t-1), p);
end

IR = zeros(T+1, 2);
for i = 1:T+1
    IR(i, 1) = sum(S(:,:,i) == 1, 'all');
    IR(i, 2) = sum(S(:,:,i) == 2, 'all');
end

plot(0:T, IR / N^2);
colororder(gca, {'r','b'});
xlabel('$t$');
ylabel('Fraction of population');
legend('Infectious', 'Recovered');

figure();
tl = tiledlayout(2, 2, 'TileSpacing','compact');
ax1 = nexttile();
gridPlot(S(:,:,1), cmap, 3);
ax2 = nexttile();
imax = find(IR(:,1) == max(IR(:,1)), 1);
gridPlot(S(:,:,imax), cmap, 3);
ax3 = nexttile();
imin = find(IR(imax:end,1) == min(IR(imax:end,1)), 1);
gridPlot(S(:,:,imin), cmap, 3);
ax4 = nexttile();
gridPlot(S(:,:,imin + 40), cmap, 3);