% Returns a state vector indicating which nodes get infected
% n :: infectious degree for each node: 
%       n(i) = k means node i is connected to k infectious nodes
% p :: rate parameter

function i = inf_exp(n, p)
    r = rand(length(n), 1);
    i = -log(r) / p <= n;
end
