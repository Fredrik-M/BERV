function ddt = sirODE(t,y,params)
% lambda - Birth rate
% mu - Death rate
% beta - Infection rate
% gamma - Recovery rate
% y - [S(t-1);I(t-1);R(t-1)]

ddt = zeros(3,1);
F = params.beta * y(2);
ddt(1) = params.lambda - params.mu * y(1) - F * y(1);
ddt(2) = F * y(1) - (params.gamma + params.mu) * y(2);
ddt(3) = params.gamma * y(2) - params.mu * y(3);
end