
% ======================================================================
set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear
% ======================================================================

Q = 30;

G_ex = load('G_pwr.mat').G_pwr;
m_ex = metrics(G_ex, 1);
ma   = [m_ex.avg_k; m_ex.dens; m_ex.gcc; m_ex.avg_spl];

M = zeros(Q, 6);
P = zeros(Q, 2);
s = degree(G_ex);
for i = 1:Q
    g = graph_conf(s);
    m = metrics(g, 1);
    M(i,1) = m.avg_k;
    M(i,2) = m.dens;
    M(i,3) = m.gcc;
    M(i,4) = m.avg_spl;
    P(i,1) = m.N;
    P(i,2) = m.E;
end

tl = tiledlayout(4, 1, 'TileSpacing','compact');
for i = 1:4
    ax(i) = nexttile();
    hold on;
    boxplot(M(:,i), 'Orientation','horizontal');
    plot([ma(i), ma(i)], ax(i).YLim, ':r');
    yticklabels([]);
end
ylabel(ax(1), '$\bar{k}$ ', 'Rotation',0.5, 'VerticalAlignment','middle', 'HorizontalAlignment','right');
ylabel(ax(2), 'density');
ylabel(ax(3), 'gcc');
ylabel(ax(4), 'spl');