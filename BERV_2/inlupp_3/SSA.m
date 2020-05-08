function [tt, X] = SSA(prop, nr, x0, tspan, p, step)
% [t, X] = SSA(@prop, @nr, x0, tspan, p)
% The Stochastic Simulation Algorithm (SSA) or Gillespies direct method.
%
% Input:
% prop  - Function handle pointing to the function that calculates the
%         propensity function vector
%         Calling sequence w = prop(x,p) where x is the state
%         vector, p is a vector with propensities. w is the output
%         propensity vector
% nr    - A function handle pointing to the function that returns the
%         stoichiometry matrix for the model.
%         Calling sequence: N = nr(), where N is the stoichiometry matrix,
%         no input parameter
% x0    - The initial state (vector).
% tspan - time interval [t0 tfinal]. To save memory and execution time the
%         solver store results only at certain time intervals
% p     - Vector with the propensities
% Output:
% t     - the time vector
% X     - The computed state vector

% Andreas Hellander, 2009.
%

% Create vector that decide what results to store (to speed up run time and
% save memory)
if nargin==5
    step = 0.1;
end
t_report = tspan(1):step:tspan(end);

% Initiate vectors
dim=numel(x0);
output_size = numel(t_report);
X=zeros(output_size,dim);
tt = zeros(output_size, 1);
x0 = x0(:)'; % Always row vector

N = nr();
X(1,:) = x0;
x = x0;
t = tspan(1);
tt(1) = t;
i=2;
while (i <= output_size)
    re = prop(x,p);
    a0 = sum(re);
    if a0 > eps      
        % Time until next reaction
        tau = -log(rand())/a0;
        % If tau>timestep, meaning next time jump timestep(s) in tt and
        % we must remove these time steps in tt and X
        if tau >= step
            nsteps = floor(tau/step);
            tt = [tt(1:i-1); tt(i+nsteps:end)];
            X = [X(1:i-1,:); X(i+nsteps:end,:)];
            t_report = [t_report(1:i-1) t_report(i+nsteps:end)];
            output_size = output_size-nsteps;
            if i>output_size
                return
            end
        end
    else
        disp('All states died out');
        return
    end
    % Find next reaction
    r = next_reaction(re,rand());
    
    % Update the state and time
    x = x + N(r,:);
    t = t + tau;
    
    % Store result if we passed the next time in t_report
    if t >= t_report(i)
        X(i,:) = x;
        tt(i) = t;
        i = i+1;
    end
    
end

end

% ---
% Internal function
% ---

function r = next_reaction(re, u)
% r = next_reaction(re, u)
% Finds the next reaction.
%
% Input:  re - A list with values of all propensity functions.
%         u  - A uniform random number in (0,1].
%
cre = cumsum(re);
cre = cre/cre(end);
r = find(cre > u,1);
end

        
         
