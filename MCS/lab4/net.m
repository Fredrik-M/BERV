% Loads and plots a graph object and its degree distribution
% Assumes that matfile contains a variable G that is the graph object.

function net(matfile)
    set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
    close all

    s = load(matfile);
    G = s.G;

    gp = plot(G);
    gp.EdgeColor = [0.6,0.6,0.6];
    figure();
    hold on;
    d = degree(G);
    histogram(d, 'BinMethod','integers');
    ax = gca;
    mp = plot([mean(d),mean(d)], ax.YLim, '--k');
    title('Degree distribution')
    xlabel('$k$ (degree)');
    ylabel('vertices');
    legend([mp], sprintf('$\\bar{k} = %0.3f$', mean(d)), 'Box','off');
end