% logistic :: [x0, ..., xn], mu -> [f_mu(x0), ..., f_mu(xn)]
% Where f_mu is the logistic map with parameter mu.

function l = logistic(x, mu)
    l = mu * x .* (1 - x);
end