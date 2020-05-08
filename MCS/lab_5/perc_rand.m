
% ======================================================================
set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all
clear
% ======================================================================

N = 5500;
p = 0.000436;
Q = 10;
alpha = 0.01:0.01:0.5;

G_ex = load('G_pwr.mat').G_pwr;
G = graph_er(N, p);

S = zeros(Q, length(alpha), 2);
for j = 1:length(alpha)
    for i = 1:Q
        H = remove_rand(G, alpha(j));
        com = conncomp(H);
        cid = unique(com)';
        m = max(sum(com == cid, 2));
        S(i,j,1) = m;
        
        H = remove_rand(G_ex, alpha(j));
        com = conncomp(H);
        cid = unique(com)';
        m = max(sum(com == cid, 2));
        S(i,j,2) = m;
    end
end

M = mean(S, 1);

hold on;
plot(alpha, M(:,:,1));
plot(alpha, M(:,:,2));
xlabel('$\alpha$');
ylabel('$N_{max}$');