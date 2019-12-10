% It applies the trapets method on a vector of values of f function.
% start is the initial value, End is the last value.

function result = trapet(f, start, End)
step = (End - start)/(length(f) -1);

v = (0.5 * step) .* ones(1, length(f) - 1);
g = (f(1:length(f) - 1) + f(2:length(f)))';

result = v * g;

