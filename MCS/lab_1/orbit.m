% orbit :: f, [x0_0, ..., x0_m], N -> [[x0_0; ...; f^N(x0_0)], ..., [x0_m; ...; f^N(x0_m)]]
% Where f^k(x) = f(f(...f(x))) is f composed k times.
% map :: [x0, ..., xm] -> [f(x0), ..., f(xm)]
% Returns a N * m matrix where column i is the first N elements in the
% orbit of x0_i (starting from x0_i).

function O = orbit(map, x0, N)
    O = zeros(N + 1, length(x0));
    O(1,:) = x0;
    for i = 2:N + 1
        O(i,:) = map(O(i - 1,:));
    end
end