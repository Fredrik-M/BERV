% Plots the solution for x to the Van der Pol equation with parameter lambda using ode45.
% Plots the step size as a function of t for ode45 and ode15s, with parameter lambda.
% Plots the solution for x using odeRal with maximum stable step sizes, with lambda = 1 and lambda = 100.

% lambda -- Damping parameter to VdP_ODE
% y_init -- Initial conditions for VdP_ODE
% tspan  -- Interval for independent variable t.

lambda = 100;
y0     = [1, 0];
tspan  = [0, 300];

opts = odeset( ...
    'RelTol', 1e-3, ...
    'AbsTol', 1e-6 ...
    );

% ========================================================================

f = @(t, y)VdP_ODE(t, y, lambda);
[t_45, y_45]   = ode45(f, tspan, y0, opts);
[t_15s, y_15s] = ode15s(f, tspan, y0, opts);

set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
% Solutions ode45
tl = tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t_45, y_45(:,1));

ax2 = nexttile();
plot(t_45, y_45(:,2));

xticklabels(ax1, {});
%linkaxes([ax1, ax2]);
title(ax1, sprintf('Solutions (ode45) with $\\lambda = %0.1f$', lambda));
xlabel(ax2, '$t$');
ylabel(ax1, '$x$', ...
    'Rotation',0, 'VerticalAlign','middle', 'HorizontalAlign','right');
ylabel(ax2, '$\frac{dx}{dt}$', ...
    'Rotation',0, 'VerticalAlign','middle', 'HorizontalAlign','right', 'FontSize',14);

% =========
% Timestep ode45/152
figure();
tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t_45(1 : end - 1), diff(t_45));

ax2 = nexttile();
plot(t_15s(1 : end - 1), diff(t_15s));

xticklabels(ax1, {});
title(ax1, sprintf('Step size with $\\lambda = %0.1f$ \n ode45', lambda));
title(ax2, 'ode15s');
xlabel(ax2, '$t$');
ylabel(ax1, '$\Delta t$', ...
    'Rotation',0, 'VerticalAlign','middle', 'HorizontalAlign','right');
ylabel(ax2, '$\Delta t$', ...
    'Rotation',0, 'VerticalAlign','middle', 'HorizontalAlign','right');

% =========
% odeRal
lambda = 1;
h = 0.5;
f = @(t, y)VdP_ODE(t, y, lambda);
[t_r, y_r] = odeRal(f, tspan, y0, h);

figure();
tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t_r, y_r(:,1));
title(sprintf('odeRal \n $\\lambda = %0.1f$, $h = %0.4f$', lambda, h));

lambda = 100;
h = 0.0062;
f = @(t, y)VdP_ODE(t, y, lambda);
[t_r, y_r] = odeRal(f, tspan, y0, h);

ax2 = nexttile();
plot(t_r, y_r(:,1));
title(sprintf('$\\lambda = %0.1f$, $h = %0.4f$', lambda, h));

xticklabels(ax1, {});
xlabel(ax2, '$t$');
ylabel(ax1, '$x$', ...
    'Rotation',0, 'VerticalAlign','middle', 'HorizontalAlign','right');
ylabel(ax2, '$x$', ...
    'Rotation',0, 'VerticalAlign','middle', 'HorizontalAlign','right');
