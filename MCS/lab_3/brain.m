clear;

N = 40;
p = 0.3;

steps = 0;

% ===================================================================

S = rand(N) < p;
Sp = pad(S);

pl = surface(Sp, 'EdgeColor','k');
ax = gca;
ax.YDir = 'reverse';
ax.YTickLabel = {};
ax.XTickLabel = {};
xlim([1,N+1]);
ylim([1,N+1]);

fig = gcf;
fig.NextPlot = 'replace';

while true
    in = input('step', 's');
    if in == 'q'
        break
    end

    S = step(S);
    clf(fig);
    surface(pad(S), 'EdgeColor','k');
end