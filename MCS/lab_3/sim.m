
function sim(S)
    figure();
    ax = gridPlot(S);
    
    i = 1;
    while true
        in = input(sprintf('step %i\n', i - 1), 's');
        if in == 'q'
            break
        end

        S = step(S);
        cla(ax);
        surface(ax, pad(S, 2), 'EdgeColor','k');
        title(ax, sprintf('step: %i', i));
        i = i + 1;
    end
end