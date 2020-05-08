% Generates a Barabási-Albert random graph and simulates an epidemic on it,
% over t time steps. Plots the number of infected individuals for each rate
% parameter in p_i over time and as a function of r/p_i. The initially 
% infectious nodes are chosen at random from a uniform distribution.
% Assumes that matfile contains a variable G that is the graph object.
% I0  :: number of infected nodes at t = 0
% p_i :: vector of rate parameters to use
% r   :: probability of recovery
% t   :: time steps to simulate

function epi_stat(matfile, I0, p_i, r, t)
    set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
    close all

    s = load(matfile);
    G = s.G;
    N = size(G.Nodes);
    N = N(1);

    i0 = zeros(N, 1);
    i0(randperm(N, I0)) = 1;

    I = zeros(t+1, length(p_i));
    for s = 1:length(p_i)
        fprintf('%i, ', s);
        f = @(n)inf_exp(n, p_i(s));
        I(:,s) = sum(sim_t(G, i0, f, r, t))';
    end

    plot(0:t, I);
    xlabel('$t$');
    ylabel('$I(t)$');
    lgd = cell(1, length(p_i));
    for i = 1:length(p_i)
        lgd{i} = sprintf('$p = %0.3f$', p_i(i));
    end
    legend(lgd);
    title('Infectious individuals over time');

    figure();
    surf(p_i, 0:t, I);
    xlabel('$p$');
    ylabel('$t$');
    zlabel('$I(t;\,p)$');
    title('Infectious individuals over time');

    figure();
    plot(r ./ p_i, I(end,:));
    xlabel('$rp^{-1}$');
    ylabel(sprintf('$I_{%i}$', t));
    title(sprintf('Infectious individuals at $t = %i$ as a function of $rp^{-1}$', t));

    figure();
    surf(r ./ p_i, 0:t, I);
    xlabel('$rp^{-1}$');
    ylabel('$t$');
    zlabel('$I(t;\,rp^{-1})$');
    title('Infectious individuals over time as a function of $rp^{-1}$');
end


