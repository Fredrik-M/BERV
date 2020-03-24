% lambda - Birth rate
% mu - Death rate
% beta - Infection rate
% gamma - Recovery rate
% N - Population size
% I - Initial infectious
% R - Initial resistant

N = 10e6;

params = struct(...
    'lambda', 12.1 * 1e-3 / 365, ...
    'mu', 9.2 * 1e-3 / 365, ...
    'beta', 0.4, ...
    'gamma', 1 / 9 ...
);

I = 5;
R = 0;
tspan = [0, 120];

% =====================================================================

% R_0 - Basic reproduction number
R_0 = params.beta * params.lambda / (params.mu * (params.mu + params.gamma));
% y_0 - Initial conditions
y_0 = [N - I - R, I, R] ./ N;

f = @(t,y)sirODE(t,y,params);
opts = odeset(...
    'AbsTol', 1e-6, ...
    'RelTol', 1e-3 ...
);

[t,y] = ode45(f, tspan, y_0, opts);
p = y(:,1) + y(:,2) + y(:,3);

plot(t,y(:,1),'b', t,y(:,2),'r', t,y(:,3),'g', t,p,'--c');
set(gcf, 'Position', [100, 200, 800, 600]);
title(sprintf(...
    ['\x039b = %0.4e,  \x03bc = %0.4e,  \x03b2 = %0.3f,  \x03b3 = %0.3f\n' ...
    'R_{0} = %0.3f'], ...
    params.lambda, params.mu, params.beta, params.gamma, R_0 ...
));
xlabel('Time (days)');
ylabel('Fraction of population');
legend('Susceptible', 'Infectious', 'Resistant');