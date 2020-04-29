function nr = stochPredPrey( )
% nr = nr_PredPrey()
%
% Stoichiometry matrix, nr, for the Pred-prey model:
% y1 + y2 -> 2*y2
%      y2 -> 0
% y1      -> 2*y1
%
% The variables y1 and y2 correspond to the columns in nr, and are ordered 
% as:
%   y1  y2
% The first row i nr coresponds to the first equation, 2nd row corresponds 
% to the 2nd equation and so forth.
% 

nr = [-1 1;
      0 -1;
      1 0];
end

    
