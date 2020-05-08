% Interactive simulation

function sim(S, f, cmap, n)
    figure();
    ax = gridPlot(S, cmap, n);
    
    i = 1;
    while true
        in = input(sprintf('step %i\n', i - 1), 's');
        if in == 'q'
            break
        end

        S = f(S);
        cla(ax);
        surface(ax, pad(S, n), 'EdgeColor','k');
        title(ax, sprintf('step: %i', i));
        i = i + 1;
    end
end