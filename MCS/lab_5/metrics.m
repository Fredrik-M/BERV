% Returns an array of structs containing metrics for at most the c largest
% connected components of G, ordered descending. Trivial components will 
% have some NaN fields.
% G :: graph object (simple, undirected)
% c :: max number of components to consider
% m(i).g       :: subgraph (graph object)
% m(i).N       :: number of verices
% m(i).E       :: number of edges
% m(i).avg_k   :: average degree
% m(i).gcc     :: global clustering coefficient
% m(i).dens    :: density
% m(i).avg_spl :: average shortest path lenght

function m = metrics(G, c)
    com = conncomp(G);
    cid = unique(com)';
    [~,ci] = sort(sum(com == cid, 2), 'descend');
    cid = cid(ci);
    if c == 0
        n =length(cid);
    else
        n = min(c, length(cid));
    end
    for i = n:-1:1
        g = subgraph(G, find(com == cid(i)));
        N = height(g.Nodes);
        E = height(g.Edges);
        m(i) = struct( ...
            'g', g, ...
            'N', N, ...
            'E', E, ...
            'avg_k', mean(degree(g)), ...
            'gcc', clustCo(g), ...
            'dens', 2 * E / (N * (N-1)), ...
            'avg_spl', sum(distances(g), 'all') / (N * (N-1)) ...
        );
    end
end

