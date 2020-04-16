% logistic :: [x0, ..., xn], [mu0, ..., mun] -> [f_mu0(x0), ..., f_mun(xn)]
% Where f_mu is the logistic map with parameter mu.

function l = logistic(x, mu)
    l = mu .* x .* (1 - x);
end