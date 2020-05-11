% Simulates the circadian clock model stochastically on t = [0, 400], using 
% SSA. Plots the results for A(t) and R(t).

% A  -- activator protein
% R  -- repressor protein
% D  -- activator | repressor gene
% Dp -- activator | repressor gene with A | R bound
% M  -- mRNA
% C  -- inactive complex formed by A and R

% alpha  -- basal transcription rate
% alphaP -- activated transcription rate
% beta   -- translation rate
% delta  -- rate of spontaneous degradation
% gamma  -- rate of binding of A to other components
% theta  -- rate of unbinding of A from other components

% ======================================================================
set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all;
clear;
% ======================================================================

% parameters
p = importdata('params.mat');

% D_A, D_R, Dp_A, Dp_R, M_A, M_R, A, R, C
y0 = [1, 1, zeros(1, 7)];
tspan = [0, 400];

% default time step 0.1
[t, y] = SSA(@prop_CO, @stoch_CO, y0, tspan, p);

% plot A(t) and R(t)
tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t, y(:,7));
ax2 = nexttile();
plot(t, y(:,8));

xticklabels(ax1, {});
ax1.XLim = tspan;
ax2.XLim = tspan;
ylabel(ax1, '$A(t)$');
ylabel(ax2, '$R(t)$');
xlabel(ax2, '$t$');
