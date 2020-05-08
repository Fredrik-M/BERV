% Returns the global clustering coefficient of a graph
% G :: graph object

function cc = clustCo(G)
    A = adjacency(G);
    O = A^2;
    o = sum(triu(O, 1), 'all');
    c = sum(diag(O * A)) / 2;
    
    cc = c / (c + o);
end