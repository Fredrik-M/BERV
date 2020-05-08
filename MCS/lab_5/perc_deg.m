
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

M = zeros(1, length(alpha), 2);
S = zeros(Q, length(alpha));
for j = 1:length(alpha)
    for i = 1:Q
        G = graph_er(N, p);
        H = remove_f(G, @degree, alpha(j));
        com = conncomp(H);
        cid = unique(com)';
        m = max(sum(com == cid, 2));
        S(i,j) = m;
    end
    
    H = remove_f(G_ex, @degree, alpha(j));
    com = conncomp(H);
    cid = unique(com)';
    m = max(sum(com == cid, 2));
    M(:,j,2) = m;
end

M(:,:,1) = mean(S, 1);

hold on;
plot(alpha, M(:,:,1));
plot(alpha, M(:,:,2));
xlabel('$\alpha$');
ylabel('$N_{max}$');