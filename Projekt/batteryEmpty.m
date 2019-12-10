%Given a model, route and initial charge, computes the point at which the battery is depleted.

function res = batteryEmpty(charge, model, route)

N = 100;

distance_vec = load(route, 'distance_km').distance_km;
route_length = distance_vec(length(distance_vec));

E = @(x)(tot_consumption(x, model, route, N));

try
    res = fzero(@(x)(E(x)-charge), [0, route_length]);
catch
    disp('Battery will last the entire route')
end
