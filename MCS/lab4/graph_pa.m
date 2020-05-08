% Generates a random graph with n vertices, based on the Barabási-Albert model.
% The process starts with n0 = m + 1 vertices. For each new vertex, m links
% are added, independently and such that no duplicate- or self links form. 
% n :: total number of vertices. Must be >= 2.
% m :: number of links formed by each new vertex. Must be < n.

function g = graph_pa(n, m)
    A = zeros(n);
    A(1,m+1) = 1;
    A(m+1,1) = 1;
    for i = 1:m
        A(i,i+1) = 1;
        A(i+1,i) = 1;
    end
    
    e = sum(triu(A), 'all');
    for j = m+2:n
        p = sum(A(1:j-1,1:j-1), 2) / (2 * e);      
        c = rand(length(p), 1) <= p;
        while sum(c) < m
            c = c | (rand(length(p), 1) <= p);
        end
        i = find(c);
        i = i(randperm(length(i), m));

        A(i,j) = 1;
        A(j,i) = 1;

        e = e + m;
    end

    g = graph(A);
end