% Returns the stoichiometry matrix for the circadian clock model

function nr = stoch_CO()
%        D_A D_R D'_A D'_R M_A M_R  A   R   C
    nr = [1   0   -1    0   0   0   0   0   0;  %    D'_A -> D_A
         -1   0    1    0   0   0  -1   0   0;  % D_A + A -> D'_A
          0   1    0   -1   0   0   0   0   0;  %    D'_R -> D_R
          0  -1    0    1   0   0  -1   0   0;  % D_R + A -> D'_R
          0   0    0    0   1   0   0   0   0;  %       0 -> M_A
          0   0    0    0   1   0   0   0   0;  %       0 -> M_A
          0   0    0    0  -1   0   0   0   0;  %     M_A -> 0
          0   0    0    0   0   1   0   0   0;  %       0 -> M_R
          0   0    0    0   0   1   0   0   0;  %       0 -> M_R
          0   0    0    0   0  -1   0   0   0;  %     M_R -> 0
          0   0    0    0   0   0   1   0   0;  %       0 -> A
          0   0    0    0   0   0   1   0   0;  %       0 -> A
          0   0    0    0   0   0   1   0   0;  %       0 -> A
          0   0    0    0   0   0  -1   0   0;  %       A -> 0
          0   0    0    0   0   0  -1  -1   1;  %   A + R -> C
          0   0    0    0   0   0   0   1   0;  %       0 -> R
          0   0    0    0   0   0   0  -1   0;  %       R -> 0
          0   0    0    0   0   0   0   1  -1]; %       C -> R
end