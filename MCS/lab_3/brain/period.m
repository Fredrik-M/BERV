% Simulates up to t time steps, and searches for an orbit. Returns the
% period if one is found.

function p = period(S, t)
    p  = 0;
    s  = size(S);
    St = zeros(s(1), s(2), t+1);
    St(:,:,1) = S;

    for i = 2:t+1
        S = step(S);
        for j = i-1:-1:1
            if all(S == St(:,:,j), 'all')
                p = i-j;
                return
            end
        end
        
        St(:,:,i) = S; 
    end
end