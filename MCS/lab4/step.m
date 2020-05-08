% Advances the simulation one time step and returns the new state vector.
% An infectious node that recovers will not become infected again in the
% same time step, and will not infect others.
%
% A   :: adjacency matrix
% i_  :: logical vector indicating the state of each node
% f_i :: function :: n -> i, where n is a vector indicating the infectious 
%           degree (number of infectious nodes connected to each node, and 
%           i is a corresponding vector of new states
% p_r :: probability of recovering

function i = step(A, i_, f_i, p_r)
    if ~all(size(i_) == [size(A, 2),1])
        i_ = i_';
    end
    r = i_ & (rand(length(i_), 1) <= p_r);
    n = sum(i_ & ~r & A)';
    i = (i_ & ~r) | f_i(n .* ~r);
end