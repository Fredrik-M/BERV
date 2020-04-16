% Unit is percentage of population : S + E + I + R + D = 1
% p :: struct
% p.beta  -- average contact rate
% p.kappa -- average incubation rate
% p.gamma -- average recovery rate
% p.alpha -- percentage of infections with acute symptoms
% p.mu    -- baseline mortality among acute cases
% p.mu_h  -- mortality (acute cases) with hostpital treatment
% p.h     -- hospital ICU capacity (percent of population)

function ddt = SEIRD_ODE(t, seird, p)
    ddt = zeros(5, 1);
    [S,E,I,R,D] = feval(@(c)c{:}, num2cell(seird));
    
    acute_untreated = max(0, p.alpha * seird(3) - p.h);
    acute_treated   = min(p.alpha * seird(3), p.h);
    F = p.beta * I;
    
    ddt(1) = -F * S;
    ddt(2) = F * S - p.kappa * E;
    ddt(3) = p.kappa * E - p.gamma * I;
    ddt(4) = p.gamma * (1 - p.mu_h) * acute_treated ...
             + p.gamma * (1 - p.mu) * acute_untreated ...
             + p.gamma * (1 - p.alpha) * I;
    ddt(5) = p.gamma * p.mu_h * acute_treated ...
             + p.gamma * p.mu * acute_untreated;
end
    