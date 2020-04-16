
% N     -- population size
% i0    -- number of infected individuals at t = 0

% beta  -- average contact rate
% kappa -- average incubation rate
% gamma -- average recovery rate
% s     -- percentage of infections with symptoms :: [0, 1]
% alpha -- percentage of infections with acute symptoms :: [0, 1 - p.s]
% mu    -- baseline mortality among acute cases
% mu_h  -- mortality (acute cases) with hostpital treatment
% h     -- hospital ICU capacity (percent of population)
% q     -- quarantine effectivness (percent of symptomatic cases)
% rho_h -- hospital exposure reduction
% sigma -- average vaccination rate
% n     -- time to develop vaccine

N  = 10e6;
i0 = 0.01e6;

% Time unit is weeks
tspan = [0, 40];

p = struct(...
    'beta',  1.35, ...
    'kappa', 1.95, ...
    'gamma', 0.4, ...
    's',     0.5, ...
    'alpha', 0.04, ...
    'mu',    0.5, ...
    'mu_h',  0.0175, ...
    'h',     1000 / N, ...
    'q',     0.6, ...
    'rho_h', 0.95, ...
    'sigma', 0.25, ...
    'n',     12 ...
);

opts = odeset(...
    'AbsTol', 1e-10, ...
    'RelTol', 1e-8 ...
);

% =====================================================================

I0 = i0 / N;
S0 = 1 - I0;
y0 = [S0, 0, I0, 0, 0, 0];

f = @(t, seirdv)SEIRDV_ODE_QSS(t, seirdv, p);
[t, y] = ode45(f, tspan, y0, opts);

disp(y(end,:));

R0 = p.beta / p.gamma;
Re = R0 * y(:,1);

% ap = area(t, y(:,[3,2,1,4,5]));
% xlim(tspan);
% ylim([0,1]);
% ap(1).FaceColor = [1, 0, 0];
% ap(2).FaceColor = [1, 1, 0];
% ap(3).FaceColor = [1, 1, 1];
% ap(4).FaceColor = [0, 1, 0];
% ap(5).FaceColor = [0.2, 0.2, 0.2];
% title(sprintf(['SEIRDV,  \x03b2 = %0.3f,  ', ...
%                        '\x03ba = %0.3f,  ', ...
%                        '\x03b3 = %0.3f,  ', ...
%                        'I_{0} = %0.3e'], ...
%               p.beta, p.kappa, p.gamma, I0));
% xlabel('Time (weeks)');
% ylabel('Fraction of population');
% legend('Infectious', 'Exposed', 'Susceptible', 'Recovered', 'Dead');

% ========================

figure();
plot(t, y);
colororder({'b', 'm', 'r', 'g', 'k', 'c'});
hold on;
plot(tspan, [p.h, p.h], 'LineStyle','--','Color',[0.5, 0.5, 0.5]);
scatter(t(logical(y(:,3) == max(y(:,3)))), max(y(:,3)), 'k');
xlim(tspan);
ylim([0,1]);
title(sprintf(['SEIRDV,  \x03b2 = %0.3f,  ', ...
                        '\x03ba = %0.3f,  ', ...
                        '\x03b3 = %0.3f,  ', ...
                        'I_{0} = %0.3e'], ...
    p.beta, p.kappa, p.gamma, I0));
xlabel('Time (weeks)');
ylabel('Fraction of population');
legend('Susceptible', 'Exposed', 'Infectious', 'Recovered', 'Dead', 'Vaccinated', 'ICU capacity');

% =========================

figure();
tl = tiledlayout(2,1);
ax1 = nexttile();
p.h = 1;
f = @(t, seirdv)SEIRDV_ODE_QSS(t, seirdv, p);
[t, y] = ode45(f, tspan, y0, opts);
disp(y(end,:));
plot(t, y(:,[2,3,5]));
colororder({'m', 'r', 'k'});
hold on;
scatter(t(logical(y(:,3) == max(y(:,3)))), max(y(:,3)), 'k');
annotation('textbox',[0.1,0.75,0.1,0.1], ...
           'String',sprintf('I_{h} = %0.1f,  D(40) = %0.4f', p.h, y(end,5)), ...
           'FitBoxToText','on', ...
           'EdgeColor','w');
legend('Exposed', 'Infectious','Dead');       

ax2 = nexttile();
p.h = 1000 / N;
f = @(t, seirdv)SEIRDV_ODE_QSS(t, seirdv, p);
[t, y] = ode45(f, tspan, y0, opts);
disp(y(end,:));
plot(t, y(:,[2,3,5]));
colororder({'m', 'r', 'k'});
hold on;
scatter(t(logical(y(:,3) == max(y(:,3)))), max(y(:,3)), 'k');
annotation('textbox',[0.1,0.25,0.1,0.1], ...
           'String',sprintf('I_{h} = %0.1e,  D(40) = %0.4f', p.h, y(end,5)), ...
           'FitBoxToText','on', ...
           'EdgeColor','w');

tl.TileSpacing = 'compact';
xticklabels(ax1, {});
linkaxes([ax1, ax2]);
xlim(tspan);
ylim([0,1]);
title(tl, sprintf(['SEIRDV,  \x03b2 = %0.3f,  ', ...
                           '\x03ba = %0.3f,  ', ...
                           '\x03b3 = %0.3f,  ', ...
                           'I_{0} = %0.2e'], ...
              p.beta, p.kappa, p.gamma, I0));
xlabel(tl, 'Time (weeks)');
ylabel(tl, 'Fraction of population');

% ========================

N = 0:1:40;
D = zeros(1, length(N));
P = zeros(length(N), 2);
for i = 1:length(N)
   p.n = N(i);
   f = @(t, seirdv)SEIRDV_ODE_QSS(t, seirdv, p);
   [t, y] = ode45(f, tspan, y0, opts);
   D(i) = y(end,5);
   P(i,:) = [t(logical(y(:,3) == max(y(:,3)))), max(y(:,3))];
end

figure();
tl = tiledlayout(2,1);
tl.TileSpacing = 'compact';
ax1 = nexttile();
plot(N, D, 'k');
xticklabels(ax1, {});
ylabel('Death toll')

ax2 = nexttile();
scatter(N, P(:,1), 'r');
hold on;
plot([0:1:1 + round(max(P(:,1)))], [0:1:1 + round(max(P(:,1)))], '--k');
ylim([0, 1 + round(max(P(:,1)))]);
xlabel('n')
ylabel('Time of peak infection');
title(tl, 'Impact of vaccinations after n weeks with $\sigma = 0.25$', 'interpreter','latex')
