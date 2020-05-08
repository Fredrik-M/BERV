% Plots a graph object and returns the graphPlot object
% G :: graph object

function gp = gPlot(G)
    gp = plot(G);
    colormap([0.5,1,0.5; 1,0,0]);
    gp.EdgeColor = [0.75,0.75,0.75];
    gp.NodeLabel = [];
end