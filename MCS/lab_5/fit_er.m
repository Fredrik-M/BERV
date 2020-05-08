
% ======================================================================
set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear
% ======================================================================

N = 5500;
p = 0.000436;
Q = 30;

G_ex = load('G_pwr.mat').G_pwr;
m_ex = metrics(G_ex, 1);
ma   = [m_ex.avg_k; m_ex.dens; m_ex.gcc; m_ex.avg_spl];

M = zeros(Q, 6);
for i = 1:Q
    g = graph_er(N, p);
    m = metrics(g, 1);
    M(i,1) = m.avg_k;
    M(i,2) = m.dens;
    M(i,3) = m.gcc;
    M(i,4) = m.avg_spl;
    M(i,5) = m.N;
    M(i,6) = m.E;
end

tl = tiledlayout(4, 1, 'TileSpacing','compact');
for i = 1:4
    ax(i) = nexttile();
    hold on;
    boxplot(M(1:4,i), 'Orientation','horizontal');
    plot([ma(i), ma(i)], ax(i).YLim, ':r');
    yticklabels([]);
end
ylabel(ax(1), '$\bar{k}$ ', 'Rotation',0.5, 'VerticalAlignment','middle', 'HorizontalAlignment','right');
ylabel(ax(2), 'density');
ylabel(ax(3), 'gcc');
ylabel(ax(4), 'spl');