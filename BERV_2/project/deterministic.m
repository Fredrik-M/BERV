
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

tspan = [0, 400];

% =======================================================================

p = struct ( ...
    'alpha_A',   50, ...
    'alphaP_A',  500, ...
    'alpha_R',   0.01, ...
    'alphaP_R',  50, ...
    'beta_A',    50, ...
    'beta_R',    5, ...
    'delta_MA',  10, ...
    'delta_MR',  0.5, ...
    'delta_A',   1, ...
    'delta_R',   0.2, ...
    'gamma_A',   1, ...
    'gamma_R',   1, ...
    'gamma_C',   2, ...
    'theta_A',   50, ...
    'theta_R',   100 ...
    );

% D_A, D_R, Dp_A, Dp_R, M_A, M_R, A, R, C
y0 = [1, 1, zeros(1, 7)];

opts = odeset( ...
    'RelTol', 1e-3, ...
    'AbsTol', 1e-6 ...
    );

f = @(t, y)CO_ODE(t, y, p);
[t, y] = ode15s(f, tspan, y0, opts);

set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
tl = tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t, y(:,7));

ax2 = nexttile();
plot(t, y(:,8));

xticklabels(ax1, {});
ylabel(ax1, '$A(t)$');
ylabel(ax2, '$R(t)$');
xlabel(ax2, '$t$');

% ==============

tspan = [0, 50];
[t45, y45]   = ode45(f, tspan, y0, opts);
[t15s, y15s] = ode15s(f, tspan, y0, opts);

figure();
tl = tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t45(1:end-1), diff(t45));

ax2 = nexttile();
plot(t15s(1:end-1), diff(t15s));

title(ax1, 'ode45');
title(ax2, 'ode15s');
xticklabels(ax1, {});
ylabel(ax1, '$h(t)$');
ylabel(ax2, '$h(t)$');
xlabel(ax2, '$t$');
