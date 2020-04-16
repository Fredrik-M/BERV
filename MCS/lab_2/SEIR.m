
% N     -- population size
% i0    -- number of infected individuals at t = 0
% beta  -- average contact rate
% kappa -- average incubation rate
% gamma -- average recovery rate

N  = 100;
i0 = 1;

% Time unit is weeks
tspan = [0, 30];

params = struct(...
    'beta', 0.8, ...
    'kappa', 1.12, ...
    'gamma', 0.4 ...
);

opts = odeset(...
    'AbsTol', 1e-10, ...
    'RelTol', 1e-8 ...
);

% =====================================================================

I0 = i0 / N;
S0 = 1 - I0;
y0 = [S0, 0, I0, 0];

f = @(t, seir)SEIR_ODE(t, seir, params);
[t, y] = ode45(f, tspan, y0, opts);
R0 = params.beta / params.gamma;
Re = R0 * y(:,1);

ap = area(t, y(:,[3,2,1,4]));
xlim(tspan);
ylim([0,1]);
ap(1).FaceColor = [1, 0, 0];
ap(2).FaceColor = [1, 1, 0];
ap(3).FaceColor = [1, 1, 1];
ap(4).FaceColor = [0.8, 0.8, 0.8];
title(sprintf(['SEIR,  \x03b2 = %0.3f,  ', ...
                      '\x03ba = %0.3f,  ', ...
                      '\x03b3 = %0.3f,  ', ...
                      'I_{0} = %0.3f'], ...
              params.beta, params.kappa, params.gamma, I0));
xlabel('Time (weeks)');
ylabel('Fraction of population');
legend('Infectious', 'Exposed', 'Susceptible', 'Recovered');

figure();
tl = tiledlayout(2,1);
ax1 = nexttile();
plot(t, y);
colororder({'k', 'm', 'r', 'b'});
hold on;
scatter(t(logical(y(:,3) == max(y(:,3)))), max(y(:,3)));
xlim(tspan);
ylim([0,1]);
title(tl, sprintf(['SEIR,  \x03b2 = %0.3f,  ', ...
                      '\x03ba = %0.3f,  ', ...
                      '\x03b3 = %0.3f'], ...
              params.beta, params.kappa, params.gamma));
xlabel(tl, 'Time (weeks)');
ylabel(tl, 'Fraction of population');
legend('Susceptible', 'Exposed', 'Infectious', 'Recovered');
annotation('textbox',[0,0.75,0.1,0.1], ...
           'String',sprintf('I_{0} = %0.3f', I0), ...
           'FitBoxToText','on');

y0 = [S0, I0, 0, 0];
[t, y] = ode45(f, tspan, y0, opts);

ax2 = nexttile();
plot(t, y);
colororder({'k', 'm', 'r', 'b'});
hold on;
scatter(t(logical(y(:,3) == max(y(:,3)))), max(y(:,3)));
xlim(tspan);
ylim([0,1]);
annotation('textbox',[0,0.25,0.1,0.1], ...
           'String',sprintf('E_{0} = %0.3f', I0), ...
           'FitBoxToText','on');

tl.TileSpacing = 'compact';
xticklabels(ax1, {});
linkaxes([ax1, ax2]);

%title(tl, sprintf(['SEIR,  \x03b2 = %0.3f,  ', ...
%                      '\x03ba = %0.3f,  ', ...
%                      '\x03b3 = %0.3f,  ', ...
%                      'I_{0} = %0.3f'], ...
%              params.beta, params.kappa, params.gamma, I0));