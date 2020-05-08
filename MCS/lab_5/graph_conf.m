
function g = graph_conf(s)
    if mod(sum(s), 2)
        error('Sum of degree sequence must be even');
    end
    
    i = 1:length(s);
    A = zeros(length(s));
    while ~isempty(i)
        u = i(randi(length(i)));
        s(u) = s(u) - 1;
        i = find(s > 0);
        
        v = i(randi(length(i)));
        s(v) = s(v) - 1;
        i = find(s > 0);
        
        A(u,v) = 1;
        A(v,u) = 1;
    end
    
    g = graph(A);
end