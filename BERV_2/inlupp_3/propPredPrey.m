function w = propPredPrey(Y, p)
%
% w = prop_PredPrey(Y, p)
% Propensities, w, for the Predator-Prey model.
% 
% Input: u - the current state vector (here Y = [y1 y2] ) 
%        p - list of parameters (here p = [alfa beta gamma] )
%
% The current state variables (in Y) are ordered as:
%    Y = [y1 y2]
% The parameters (in p) are ordered as:
%   p = [alfa beta gamma]
%

alfa = p(1); beta = p(2); gamma = p(3);

w = [beta*Y(1)*Y(2);
     gamma*Y(2);
     alfa*Y(1)];
end