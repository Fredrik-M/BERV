% Interactive simulation. Pressing enter advances the simulation one time
% step. Entering q aborts it.
% G   :: graph object
% i0  :: initial state vector
% f_i :: function :: n -> i, where n is a vector indicating the infectious 
%           degree (number of infectious nodes connected to each node, and 
%           i is a corresponding vector of new states
% p_r :: probability of recovering

function sim(G, i0, f_i, p_r)
    A = full(adjacency(G));
    i = i0;
    s = 0;

    gp = gPlot(G);
    while true
        gp.NodeCData = i;
        title(sprintf('Step: %i, Infectious: %i', s, sum(i)));
        if input(sprintf('step: %i\n', s), 's') == 'q'
            break
        end
        i = step(A, i, f_i, p_r);
        s = s + 1;
    end
end
