function s = step_lin(s_, gamma)
    n = length(s_);
    s = s_ & ~(rand(1, n) <= gamma);
    s = [s(2:n) | s(1:n-1), s(n)];
    s = [s(1), s(2:n) | s(1:n-1)];
end