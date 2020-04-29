% Interactive simulation

function sim(S, f, cmap, pv)
    figure();
    ax = gridPlot(S, cmap, pv);
    
    i = 1;
    while true
        in = input(sprintf('step %i\n', i - 1), 's');
        if in == 'q'
            break
        end

        S = f(S);
        cla(ax);
        surface(ax, pad(S, pv), 'EdgeColor','k');
        title(ax, sprintf('step: %i', i));
        i = i + 1;
    end
end