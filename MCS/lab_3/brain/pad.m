
function P = pad(M, v)
    s = size(M);
    P = [[M; v * ones(1, s(2))], v * ones(1 + s(1), 1)];
end