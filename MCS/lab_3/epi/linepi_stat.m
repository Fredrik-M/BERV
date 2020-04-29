
N = 100;

T = 50;
K = 100;
M = 20;

s0 = [zeros(1, ceil(N/2)-1), 1, zeros(1, floor(N/2))];
p = zeros(1, M);
gamma = linspace(0.1, 0.8, 8);
P = zeros(length(gamma), 2);

for i = 1:length(gamma)
    for m = 1:M
        d = 0;
        for k = 1:K
            s = s0;
            for t = 1:T
                if ~any(s)
                    d = d+1;
                    break
                end
                s = step_lin(s, gamma(i));
            end
        end
        p(m) = (K-d)/K;
    end
    P(i,1) = mean(p);
    P(i,2) = 1.96 * std(p) / sqrt(M);
end

set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
hold on
plot(gamma, P(:,1));
plot(gamma, P(:,1) - P(:,2), ':r');
plot(gamma, P(:,1) + P(:,2), ':r');
title('Probability of epidemic');
xlabel('$\gamma$');
ylabel('$P(E;\,\gamma)$');