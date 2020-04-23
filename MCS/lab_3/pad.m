function P = pad(M)
    s = size(M);
    P = [[M;zeros(1, s(2))], zeros(1 + s(1), 1)];
end