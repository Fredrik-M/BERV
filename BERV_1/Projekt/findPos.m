% Returns: the index of the first component of vector that is greater than or
% equal to val, unless val == vector(1), in which case 2 is returned.
% Returns -1 if val is greater than or smaller than all components of vector.
% PRE: vector must be non-empty and ordered ascending.
% PRE: val must be in the interval [vector(1), vector(n)]
 
function index = findPos(vector, val)

index = 2;

if isempty(vector) || val < vector(1) || val > vector(length(vector))
    throw(MException('component:IllegalArgumentException', ...
                     '%d is not in interval [%d, %d]', ...
                     val, vector(1), vector(length(vector))));
end

while vector(index) < val
    if vector(index) > vector(index + 1)
        throw(MException('component:IllegalArgumentException', ...
                         'vector is not ordered ascending: At indices %d, %d', ...
                         index, index + 1));
    end
    index = index + 1;
end