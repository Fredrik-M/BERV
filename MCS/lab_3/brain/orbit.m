% Simulates up to t time steps and searches for an orbit. 
% If one is found, all St will contain all states leading up to it, O will 
% contains the states that constitute the orbit, and p will be the period.

function [St, O, p] = orbit(S, t)
    p  = 0;
    s  = size(S);
    O  = double.empty(s(1), s(2), 0);
    St = zeros(s(1), s(2), t+1);
    St(:,:,1) = S;

    for i = 2:t+1
        S = step(S);
        for j = i-1:-1:1
            if all(S == St(:,:,j), 'all')
                p = i-j;
                O = St(:,:,j:i-1);
                St = St(:,:,1:j-1);
                return
            end
        end
        
        St(:,:,i) = S; 
    end
end