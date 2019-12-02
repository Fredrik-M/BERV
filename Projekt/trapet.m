function result = trapet(f, start, End)
% It applies the trapets method on a vector of values of f function.
% start is the initial value, End is the last value.
result = 0;
step = (End - start)/(length(f) -1);
for i = 1:length(f)-1
    result = result + step*(f(i) + f(i+1))/2;
end
end

