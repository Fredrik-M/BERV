% Removes a number of randomly selected nodes from G, proportional to
% alpha, and returns the resulting graph.
% G     :: graph object
% alpha :: proportion of nodes to remove. Must be in [0, 1].

function H = remove_rand(G, alpha)
    N = size(G.Nodes);
    n = randperm(N(1), round(N(1) * alpha));
    H = rmnode(G, n);
end