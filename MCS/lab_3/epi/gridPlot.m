
function ax = gridPlot(S, cmap, n)
    surface(pad(S, n), 'EdgeColor','k');
    ax = gca;
    colormap(ax, cmap);
    ax.YDir = 'reverse';
    ax.YTickLabel = {};
    ax.XTickLabel = {};
    s = max(size(S));
    xlim([1,s+1]);
    ylim([1,s+1]);
end