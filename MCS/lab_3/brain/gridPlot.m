
function ax = gridPlot(S)
    surface(pad(S, 2), 'EdgeColor','k');
    cmap = [0.5, 1, 0.5; 1, 0.2, 0.2; 0.8, 0.8, 0.8];
    ax = gca;
    colormap(ax, cmap);
    ax.YDir = 'reverse';
    ax.YTickLabel = {};
    ax.XTickLabel = {};
    s = size(S);
    xlim([1,s(1)+1]);
    ylim([1,s(2)+1]);
end