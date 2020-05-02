set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear

S1 = [zeros(6,14); zeros(2,6),[1,2; 1,2],zeros(2,6); zeros(6,14)];

S2 = zeros(14);
S2(5,5) = 1; S2(5,6) = 2; S2(5,9) = 1; S2(5,10) = 2;
S2(6,5) = 1; S2(6,6) = 2; S2(6,8) = 1; S2(6,9) = 2;
S2(7,7) = 1; S2(7,8) = 2;
S2(8,8) = 1; S2(8,9) = 2;
S2(9,9) = 1; S2(9,10) = 2;

S3 = zeros(14);
S3(6,8) = 2;
S3(7,9) = 1;
S3(8,6) = 2; S3(8,7) = 1; S3(8,8) = 2;
S3(9,7) = 1;

tl = tiledlayout(2,2, 'TileSpacing','compact');
nexttile();
ax1 = gridPlot(S1);
title('a');
nexttile();
ax2 = gridPlot(S2);
title('b');
nexttile();
ax3 = gridPlot(S3);
title('c');