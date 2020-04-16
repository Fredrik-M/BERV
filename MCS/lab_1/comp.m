% comp :: f, [x0, ..., xm], n -> [f^n(x0), ..., f^n(xm)]
% Where f^k(x) = f(f(...f(x))) is f composed k times.

function y = comp(f, x, n)
    y = f(x);
    for i = 1:n - 1
        y = f(y);
    end
end