% Generates an Erdös-Renyi random graph with n vertices where each pair of
% vertices are connected with probability p.

function g = graph_er(n, p)
    A = triu(rand(n) <= p, 1);
    g = graph(A + A');
end