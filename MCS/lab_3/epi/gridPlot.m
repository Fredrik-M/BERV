
function ax = gridPlot(S, cmap, pv)
    surface(pad(S, pv), 'EdgeColor','k');
    ax = gca;
    colormap(ax, cmap);
    ax.YDir = 'reverse';
    ax.YTickLabel = {};
    ax.XTickLabel = {};
    s = max(size(S));
    %xlim([1,s(1)+1]);
    %ylim([1,s(2)+1]);
    xlim([1,s+1]);
    ylim([1,s+1]);
end