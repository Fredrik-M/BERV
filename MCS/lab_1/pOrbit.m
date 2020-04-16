% Documentation, please.

function O = pOrbit(map, dmap, x0, q, absTol)
    F  = @(x)comp(map, x, q) - x;
    dF = @(x)prod(dmap(orbit(map, x, q-1))) - 1;
    X = newtRap(F, dF, x0, absTol);
    O = orbit(map, X, q);
end