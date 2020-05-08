
N = 100;

T = 50;
K = 100;
M = 20;

p0 = linspace(0.01, 0.5, 20);
gamma = linspace(0.1, 0.8, 20);

P = zeros(length(p0), length(gamma));
e = zeros(length(p0), length(gamma));
p = zeros(1, M);

for i = 1:length(p0)
    fprintf('%i, ', i);
    for j = 1:length(gamma)
        for m = 1:M
            d = 0;
            for k = 1:K
                s = rand(1, N) <= p0(i);
                if ~any(s)
                    s(50) = 1;
                end
                for t = 1:T
                    s = step_lin(s, gamma(j));
                end
                if ~any(s)
                    d = d+1;
                end
            end
            p(m) = (K-d)/K;
        end
        P(i,j) = mean(p);
        e(i,j) = 1.96 * std(p) / sqrt(M);
    end
end

set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
hold on
surf(gamma, p0, P, 'FaceColor','interp');
title('Probability of epidemic');
xlabel('$\gamma$');
ylabel('$p_0$');
zlabel('$P(E;\,\gamma, p_0)$');
