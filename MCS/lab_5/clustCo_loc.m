
function cc = clustCo_loc(G, i)
    n = neighbors(G, i);
    if isempty(n)
        cc = 0;
        return
    end
    c = 0;
    for i = 1:length(n)
        nn = neighbors(G, n(i));
        for j = 1:length(nn)
            if any(n(i+1:end) == nn(j))
                c = c + 1;
            end
        end
    end
    cc = 2 * c / (length(n) * (length(n) - 1));
end