% Unit is percentage of population : S + E + I + R + D + V = 1
% p :: struct
% p.beta  -- average contact rate
% p.kappa -- average incubation rate
% p.gamma -- average recovery rate
% p.s     -- percentage of infections with symptoms :: [0, 1]
% p.alpha -- percentage of infections with acute symptoms :: [0, 1 - p.s]
% p.mu    -- baseline mortality among acute cases
% p.mu_h  -- mortality (acute cases) with hostpital treatment
% p.h     -- hospital ICU capacity (percent of population)
% p.q     -- quarantine effectivness (percent of symptomatic cases)
% p.rho_h -- hospital exposure reduction
% p.sigma -- average vaccination rate
% p.n     -- time to develop vaccine

function ddt = SEIRDV_ODE_QSS(t, seirdv, p)
    ddt = zeros(5, 1);
    [S,E,I,R,D,V] = feval(@(c)c{:}, num2cell(seirdv)); 

    acute_untreated = max(0, p.alpha * I - p.h);
    acute_treated   = min(p.alpha * I, p.h);
    F = p.beta * (I * (1 - p.q * p.s) + acute_treated * (p.q - p.rho_h));
    
    ddt(1) = -F * S - (t >= p.n) * p.sigma * S;
    ddt(2) = F * S - p.kappa * E;
    ddt(3) = p.kappa * E - p.gamma * I;
    ddt(4) = p.gamma * (1 - p.mu_h) * acute_treated ...
             + p.gamma * (1 - p.mu) * acute_untreated ...
             + p.gamma * (1 - p.alpha) * I;
    ddt(5) = p.gamma * p.mu_h * acute_treated ...
             + p.gamma * p.mu * acute_untreated;
    ddt(6) = (t >= p.n) * p.sigma * S;
end
    