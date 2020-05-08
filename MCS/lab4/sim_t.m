% Simulates t time steps and returns a length(i0)-by-t+1 state matrix where 
% column i is the state at time t = i.
% G   :: graph object
% i0  :: initial state vector
% f_i :: function :: n -> i, where n is a vector indicating the infectious 
%           degree (number of infectious nodes connected to each node, and 
%           i is a corresponding vector of new states
% p_r :: probability of recovering
% t   :: time steps to simulate

function I = sim_t(G, i0, f_i, p_r, t)
    A = full(adjacency(G));
    I = zeros(length(i0), t + 1);
    I(:,1) = i0;

    for t = 2:t+1
        I(:,t) = step(A, I(:,t-1), f_i, p_r);
    end
end
