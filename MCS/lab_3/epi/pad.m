
function P = pad(M, n)
    sz = size(M);
    P = [[M; [0:n-1, zeros(1, sz(2) - n)]], zeros(1 + sz(1), 1)];
end

% function P = pad(M, v)
%     s = size(M);
%     P = [[M; v * ones(1, s(2))], v * ones(1 + s(1), 1)];
% end