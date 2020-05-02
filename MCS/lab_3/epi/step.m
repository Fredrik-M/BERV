% Adjacency at boundaries is treated as if the grid was folded into a torus
% States: 0 : Susceptible, 1 : Infectious, 2 : Recovered
% p :: struct
% p.beta  -- probability of transmission
% p.gamma -- probability of recovery
% p.kappa -- probability of transition R -> S

function St = step(St_, p)
    % transitions R -> S
    RS = rand(size(St_)) <= p.kappa & St_ == 2;
    %RS = mod((St_ == 2) + (St_ == 2 & T_RS), 3);
    
    % transitions I -> R
    IR = rand(size(St_)) <= p.gamma & St_ == 1;
    
    % transitions S -> I
    k = ones(1,3);
    K = [k; 1,0,1; k];
    I = St_ == 1 & IR == 0;
    C = conv2(I, K, 'same');
    % top-bottom and left-right interaction
    C(1,:)   = C(1,:) + conv(I(end,:), k, 'same');
    C(end,:) = C(end,:) + conv(I(1,:), k, 'same');
    C(:,1)   = C(:,1) + conv(I(:,end), k, 'same');
    C(:,end) = C(:,end) + conv(I(:,1), k, 'same');
    % diagonal interaction
    C(1,1)     = C(1,1) + I(end,end);
    C(end,end) = C(end,end) + I(1,1);
    C(1,end)   = C(1,end) + I(end,1);
    C(end,1)   = C(end,1) + I(1,end);
    % probability of NOT being infected
    P = (1 - p.beta) .^ C;
    SI = rand(size(St_)) >= P & St_ == 0 & C > 0;
    
    St = mod(St_ + RS + IR + SI, 3);
end