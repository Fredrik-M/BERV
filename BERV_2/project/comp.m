% Plots a comparison between deterministic and stochastic simulation of the
% circadian clock model, using ode15s and SSA.

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
% change delta_R for comparison of equilibrium behaviour
p.delta_R = 0.05;

% D_A, D_R, Dp_A, Dp_R, M_A, M_R, A, R, C
y0 = [1, 1, zeros(1, 7)];
tspan = [0, 400];

opts = odeset( ...
    'RelTol', 1e-3, ...
    'AbsTol', 1e-6 ...
    );
% deterministic solution
f = @(t, y)CO_ODE(t, y, p);
[td, yd] = ode15s(f, tspan, y0, opts);

% stochastic solution. default time step 0.1
[ts, ys] = SSA(@prop_CO, @stoch_CO, y0, tspan, p);

% plot R(t)
tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(td, yd(:,8));
title('Deterministic solution');
ax2 = nexttile();
plot(ts, ys(:,8));
title('Stochastic solution');

xticklabels(ax1, {});
ax1.XLim = tspan;
ax2.XLim = tspan;
ylabel(ax1, '$R(t)$');
ylabel(ax2, '$R(t)$');
xlabel(ax2, '$t$');
