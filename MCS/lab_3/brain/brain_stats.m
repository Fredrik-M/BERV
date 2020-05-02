set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear

% N  -- grid size
% p  -- probability of a neuron starting in the firing state
% t  -- time steps per simulation
% s  -- number of simulations
% st -- time steps for which to save the state

N  = 40;
P  = 0.3;
T  = 1000;
s  = 100;
st = [10, 20, 100, T];

% =======================================================================

f  = zeros(T+1, s);
St = zeros(N, N, length(st), s);

for i = 1:s
    S = rand(N) <= P;
    f(1, i) = sum(S == 1, 'all');
 
    for j = 2:T+1
        S = step(S);
        f(j, i) = sum(S == 1, 'all');
        
        if any(j == st)
           St(:,:,find(j == st),i) = S; 
        end
    end
end

% Avg. nr of firing neurons at t = [0, t] across all simulations
fm_s = mean(f, 2);
% Mean state from sample of 5 random simulations at t = st
Stm = mean(St(:,:,:,randi([1, s], 1, 5)), 4);
% Sample of 5 random simulations at t = st
St_ex = St(:,:,:,randi([1, s], 1, 5));

scatter(1:T, fm_s(2:end), 5, 'r');
xlabel('$t$');
ylabel('Avg. nr of firing neurons');

cmap = [linspace(0.5, 1, 10)', linspace(1, 0.2, 10)', linspace(0.5, 0.2, 10)'];
cmap = [cmap(1:end-1, :); ...
        [linspace(1, 0.8, 10)', linspace(0.2, 0.8, 10)', linspace(0.2, 0.8, 10)']];

figure();
tl1 = tiledlayout(2, 2, 'TileSpacing','compact');
for i = 1:length(st)
    nexttile();
    densPlot(Stm(:,:,i), cmap);
    title(sprintf('$t = %i$', st(i)));
end
figure();
tl2 = tiledlayout(2, 2, 'TileSpacing','compact');
for i = 1:length(st)
    nexttile();
    gridPlot(St_ex(:,:,i));
    title(sprintf('$t = %i$', st(i)));
end

% =======================================================================

function densPlot(Sm, cmap)
    surface(pad(Sm, 2), 'Edgecolor','k');
    ax = gca;
    colormap(ax, cmap);
    ax.YDir = 'reverse';
    ax.YTickLabel = {};
    ax.XTickLabel = {};
    s = size(Sm);
    xlim([1,s(1)+1]);
    ylim([1,s(2)+1]);
end
