% Returns: the index of the first component of vector that is greater than or
% equal to val, unless val == vector(1), in which case 2 is returned.
% Returns -1 if val is greater than all components of vector.

function index = findPos(vector, val)

index = 2;

if isempty(vector)
    index = -1;
    disp('findPos: vector is empty');
    return
end

while vector(index) < val
    if index == length(vector)
        index = -1;
        disp('findPos: No such value');
        return
    end
    index = index + 1;
end