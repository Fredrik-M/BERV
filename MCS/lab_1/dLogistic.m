% Derivative of the logistic map

function dl = dLogistic(x, mu)
    dl = mu - 2 * mu .* x;
end