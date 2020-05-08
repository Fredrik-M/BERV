% Removes a number of nodes from G, proportional to alpha, and returns the 
% resulting graph. Nodes are removed in descending order based on the local
% metric measured by f.
% G     :: graph object
% f     :: function :: G -> v, where v is a vector such that v(i) is some 
%           local metric on vertex i. length(v) must equal the size of G.
% alpha :: proportion of nodes to remove. Must be in [0, 1].

function H = remove_f(G, f, alpha)
    N = size(G.Nodes);
    v = f(G);
    s = unique(v);
    n = zeros(1, round(N(1) * alpha));
    j = length(s);
    k = 1;
    while k <= length(n)
        i = find(v == s(j), length(n));
        m = min(k + length(i) - 1, length(n));
        n(k:m) = i(1:m-k+1);
        k = m + 1;
        j = j - 1;
    end
    H = rmnode(G, n);
end