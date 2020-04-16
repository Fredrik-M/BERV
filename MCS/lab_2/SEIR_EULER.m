
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
    'beta', 0.96, ...
    'kappa', 1.12, ...
    'gamma', 0.4 ...
);

h = 1;

% =====================================================================

I0 = i0 / N;
S0 = 1 - I0;
y0 = [S0, 0, I0, 0];

f = @(t, seir)SEIR_ODE(t, seir, params);
[t, y] = euler_fwd(f, tspan, y0, h);
disp(y(10,:));
disp(y(end,:));

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
plot(t, y);
colororder({'k', 'm', 'r', 'b'});
hold on;
scatter(t(logical(y(:,3) == max(y(:,3)))), max(y(:,3)));
xlim(tspan);
ylim([0,1]);
title(sprintf(['SEIR,  \x03b2 = %0.3f,  ', ...
                      '\x03ba = %0.3f,  ', ...
                      '\x03b3 = %0.3f,  ', ...
                      'I_{0} = %0.3f'], ...
    params.beta, params.kappa, params.gamma, I0));
xlabel('Time (weeks)');
ylabel('Fraction of population');
legend('Susceptible', 'Exposed', 'Infectious', 'Recovered');

