% Unit is percentage of population : S + E + I + R = 1
% p :: struct
% p.beta  -- average contact rate
% p.kappa -- average incubation rate
% p.gamma -- average recovery rate

function ddt = SEIR_ODE(t, seir, p)
    ddt = zeros(4, 1);
    [S,E,I,R] = feval(@(c)c{:}, num2cell(seir));
    F = p.beta * seir(3);
    
    ddt(1) = -F * S;
    ddt(2) = F * S - p.kappa * E;
    ddt(3) = p.kappa * E - p.gamma * I;
    ddt(4) = p.gamma * I;
end
     