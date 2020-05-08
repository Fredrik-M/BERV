% Adjacency at boundaries is treated as if the grid was folded into a torus
% States: 0 : ready, 1 : firing, 2 : resting

function S = step(S_)
    % transitions resting -> ready
    S = mod(S_ + (S_ == 2), 3);
    
    % count firing neighbours
    k = ones(1,3);
    K = [k; 1,0,1; k];
    C = conv2(S, K, 'same');
    % top-bottom and left-right interaction
    C(1,:)   = C(1,:) + conv(S(end,:), k, 'same');
    C(end,:) = C(end,:) + conv(S(1,:), k, 'same');
    C(:,1)   = C(:,1) + conv(S(:,end), k, 'same');
    C(:,end) = C(:,end) + conv(S(:,1), k, 'same');
    % diagonal interaction
    C(1,1)     = C(1,1) + S(end,end);
    C(end,end) = C(end,end) + S(1,1);
    C(1,end)   = C(1,end) + S(end,1);
    C(end,1)   = C(end,1) + S(1,end);
    
    % transitions ready -> firing and firing -> resting
    S = 2 * S + and(not(S_), C == 2);
end